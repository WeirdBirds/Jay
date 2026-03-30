// SMAA — Enhanced Subpixel Morphological Anti-Aliasing (single-pass approximation)
//
// Based on the SMAA technique by Jimenez et al. (2012).
// This is a single-pass approximation that performs luma-based edge detection
// and morphological blending in one fragment shader invocation.
// For the full multi-pass SMAA, see: http://www.iryoku.com/smaa/
//
// Backup: fxaa.slang contains the previous FXAA implementation.

struct VertexOutput {
    float2 uv;
    float4 sv_position : SV_Position;
};

struct Globals {
    row_major float4x4 view;
    row_major float4x4 proj;
    float2 resolution;
    float time;
};

[[vk::binding(0, 0)]] ConstantBuffer<Globals> globals;
[[vk::binding(0, 1)]] Sampler2D scene_color;
[[vk::binding(1, 1)]] Texture2D<float> depth_texture;
[[vk::binding(2, 1)]] SamplerState depth_sampler;

static const float SMAA_THRESHOLD       = 0.1;   // Edge detection threshold
static const int   SMAA_MAX_SEARCH_STEPS = 12;    // Max search distance along edges
static const float SMAA_LOCAL_CONTRAST_ADAPTATION = 2.0;
static const int   GTAO_DIRECTION_COUNT = 4;
static const int   GTAO_STEP_COUNT = 6;
static const float GTAO_RADIUS_PIXELS = 12.0;  // Screen-space search radius in pixels
static const float GTAO_RADIUS_WORLD = 3.0;    // World-space AO radius — smaller = stronger contact shadows
static const float GTAO_BIAS = 0.0001;           // Very small to catch contact points
static const float GTAO_STRENGTH = 2.0;
static const float GTAO_THICKNESS = 1.5;       // Max depth difference (linear) that counts as occlusion

[shader("vertex")]
VertexOutput vert_main(uint vertex_id : SV_VertexID) {
    VertexOutput output;

    if (vertex_id == 0) {
        output.sv_position = float4(-1.0, -1.0, 0.0, 1.0);
        output.uv = float2(0.0, 0.0);
    } else if (vertex_id == 1) {
        output.sv_position = float4(3.0, -1.0, 0.0, 1.0);
        output.uv = float2(2.0, 0.0);
    } else {
        output.sv_position = float4(-1.0, 3.0, 0.0, 1.0);
        output.uv = float2(0.0, 2.0);
    }

    return output;
}

float rgb_to_luma(float3 color) {
    return dot(color, float3(0.2126, 0.7152, 0.0722));
}

// Detect edges at the current pixel by comparing luma differences against a threshold.
// Returns a float2 where x = left edge, y = top edge (0 or 1).
float2 detect_edges(float2 uv, float2 texel) {
    float L       = rgb_to_luma(scene_color.Sample(uv).rgb);
    float L_left  = rgb_to_luma(scene_color.Sample(uv + float2(-1.0,  0.0) * texel).rgb);
    float L_top   = rgb_to_luma(scene_color.Sample(uv + float2( 0.0, -1.0) * texel).rgb);
    float L_right = rgb_to_luma(scene_color.Sample(uv + float2( 1.0,  0.0) * texel).rgb);
    float L_bot   = rgb_to_luma(scene_color.Sample(uv + float2( 0.0,  1.0) * texel).rgb);

    float4 delta = abs(float4(L, L, L, L) - float4(L_left, L_top, L_right, L_bot));
    float2 edges = step(float2(SMAA_THRESHOLD, SMAA_THRESHOLD), delta.xy);

    // Local contrast adaptation: suppress edges where a neighbor has a much stronger edge,
    // which reduces false positives in high-contrast areas.
    float max_delta = max(max(delta.z, delta.w), max(delta.x, delta.y));
    edges *= step(delta.xy, float2(max_delta, max_delta) * SMAA_LOCAL_CONTRAST_ADAPTATION);

    return edges;
}

// Search along an edge in a given direction to find where it ends.
// Returns the distance (in pixels) to the edge endpoint.
float search_edge(float2 uv, float2 dir, float2 texel) {
    float2 pos = uv;
    for (int i = 0; i < SMAA_MAX_SEARCH_STEPS; i++) {
        pos += dir * texel;
        float2 e = detect_edges(pos, texel);
        // If the edge component along our search direction disappears, we found the end.
        float edge_val = (abs(dir.x) > 0.5) ? e.y : e.x;
        if (edge_val < 0.5)
            return float(i + 1);
    }
    return float(SMAA_MAX_SEARCH_STEPS);
}

// Compute a blending weight based on edge crossing distances.
// Uses a smooth area-based estimate inspired by SMAA's area calculation.
float compute_blend_weight(float d1, float d2) {
    float total = d1 + d2;
    if (total < 1e-5)
        return 0.0;
    // Smoothstep-based area approximation: closer to the midpoint = more blending.
    float t = d1 / total;
    // Parabolic blend factor — peaks at 0.5 (midpoint of the edge)
    return 0.5 - 2.0 * (t - 0.5) * (t - 0.5);
}

float sample_depth(float2 uv) {
    return depth_texture.SampleLevel(depth_sampler, uv, 0.0);
}

float linearize_depth(float depth) {
    float a = globals.proj[2][2];
    float b = globals.proj[2][3];
    return b / (depth + a);
}

float2 get_gtao_direction(int index) {
    if (index == 0) return float2( 1.0,  0.0);
    if (index == 1) return float2( 0.0,  1.0);
    if (index == 2) return float2(-1.0,  0.0);
    return float2( 0.0, -1.0);
}

// Reconstruct the expected depth slope along a screen-space direction
// by sampling the depth gradient at the center pixel.
// Returns the linear depth change per pixel in the given direction.
float get_depth_slope(float2 uv, float2 dir, float2 texel, float center_linear) {
    // Use the closest neighbor in this direction to estimate the surface slope.
    float d_pos = linearize_depth(sample_depth(uv + dir * texel));
    float d_neg = linearize_depth(sample_depth(uv - dir * texel));

    // Pick the smaller difference — avoids using a neighbor across a depth edge.
    float diff_pos = d_pos - center_linear;
    float diff_neg = center_linear - d_neg;

    if (abs(diff_pos) < abs(diff_neg))
        return diff_pos;
    return -diff_neg;
}

float compute_gtao(float2 uv, float2 texel) {
    float depth_center = sample_depth(uv);
    if (depth_center >= 0.9999)
        return 1.0;

    float center_linear = linearize_depth(depth_center);
    float ao = 0.0;

    for (int dir_index = 0; dir_index < GTAO_DIRECTION_COUNT; ++dir_index) {
        float horizon = 0.0;
        float2 dir = get_gtao_direction(dir_index);

        // Expected depth change per pixel along this direction (surface slope).
        float slope = get_depth_slope(uv, dir, texel, center_linear);

        for (int step_index = 1; step_index <= GTAO_STEP_COUNT; ++step_index) {
            float step_scale = GTAO_RADIUS_PIXELS * (float(step_index) / float(GTAO_STEP_COUNT));
            float2 sample_uv = uv + dir * texel * step_scale;
            float sample_raw = sample_depth(sample_uv);
            if (sample_raw >= 0.9999)
                continue;

            float sample_linear = linearize_depth(sample_raw);
            // Subtract the expected depth at this distance along the surface.
            // On a flat angled plane, the sample depth matches the slope prediction
            // and dz becomes ~0 — no false occlusion.
            float expected = center_linear + slope * step_scale;
            float dz = expected - sample_linear;

            // Skip if sample is on or below the surface plane, or beyond thickness.
            if (dz <= GTAO_BIAS || dz > GTAO_THICKNESS)
                continue;

            // Non-linear falloff: sqrt gives strong response at small dz (contact shadows)
            // while flattening for larger dz (gentle medium-range AO).
            float t = saturate((dz - GTAO_BIAS) / GTAO_RADIUS_WORLD);
            float occlusion = sqrt(t);
            // Fade near the thickness limit to suppress silhouette halos.
            occlusion *= 1.0 - smoothstep(GTAO_THICKNESS * 0.5, GTAO_THICKNESS, dz);
            horizon = max(horizon, occlusion);
        }

        ao += horizon;
    }

    return saturate(1.0 - (ao / float(GTAO_DIRECTION_COUNT)) * GTAO_STRENGTH);
}

[shader("fragment")]
float4 frag_main(VertexOutput input) : SV_Target {
    return scene_color.Sample(input.uv);
}
