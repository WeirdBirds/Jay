// count_cull.slang — two-pass depth-aware culling.
//
// Each instance carries a persistent occluded_flags bit. The two dispatch
// chains run in the same frame:
//
//   Pass A (cull_mode 0) — frustum test, then the history prediction:
//   instances whose last-frame rescue CONFIRMED occlusion (flag == 1) and
//   whose camera motion is under the gate (history_enabled) are predicted
//   occluded and skipped. Every reject here is only a PREDICTION — nothing
//   is ever committed to the frame on the strength of it.
//
//   Pass B (cull_mode 1) — same-frame rescue. Every pass-A reject carries a
//   flag, so pass B retests exactly that set against the fresh pyramid built
//   from this frame's real depth (hiz_box_visible). Survivors are added
//   back to the draw lists before the frame presents: no result reaches the
//   screen unless the current-frame occlusion pyramid agrees.
//
// Counters (HiZ_Counters ring): [3] rejected_A (predicted), [4] rescued_B,
// [5] confirmed_B, [6] history tests run. Conservation invariant:
// rejected_A == rescued_B + confirmed_B.
//
// Reverse-Z, Z-up left-handed, depth test GREATER, conservative reduction
// MIN: the pyramid tile value is the farthest occluder surface, so a tile can
// never hide anything it does not actually cover.
//
// Bounds are now world-space AABBs (center + half extents), tight around the
// cow mesh. Sphere was 10x too fat (radius 6.13*size), box hugs legs/belly
// gap is still free because occluders are exact depth, not boxes.

#include "../jay_api.slang"

// Bindless heap (set 0 — matches sgpu bindless.jai):
//   binding 1: storage images (element index = gpu_texture_view handle)
[[vk::binding(1, 0)]]
RWTexture2D<float> g_rw_textures_2d[];

[ForceInline]
bool box_inside_frustum(Bounds b, float4 frustum_planes[6]) {
    float3 c = b.center.xyz;
    float3 e = b.extents.xyz;
    for (uint i = 0; i < 6; i++) {
        float4 plane = frustum_planes[i];
        float3 n = plane.xyz;
        float d = dot(n, c) + plane.w;
        float r = abs(n.x)*e.x + abs(n.y)*e.y + abs(n.z)*e.z;
        if (d < -r) return false;
    }
    return true;
}

// Box HZB test — projects 8 corners, NDC AABB, samples overlapping tiles.
// Gap under belly is free because pyramid stores actual triangle depth (0 = far).
[ForceInline]
bool hiz_box_visible(Bounds b, Draw_Params* p) {
    float3 c = b.center.xyz;
    float3 e = b.extents.xyz;
    // Closest point to camera in view space
    float4 cv_c = mul(p->view, float4(c, 1.0));
    float d_center = -cv_c.z;
    float r_view = abs(p->view[2][0])*e.x + abs(p->view[2][1])*e.y + abs(p->view[2][2])*e.z;
    float d_closest = d_center - r_view;
    if (d_closest <= 0.0) return true;
    float best = p->ndc_coeffs.y / d_closest - p->ndc_coeffs.x;
    // 8 corners -> NDC bounds
    float2 ndc_min = float2(1.0, 1.0);
    float2 ndc_max = float2(-1.0, -1.0);
    for (uint i = 0; i < 8; i++) {
        float3 corner = c + float3((i & 1) != 0 ? e.x : -e.x, (i & 2) != 0 ? e.y : -e.y, (i & 4) != 0 ? e.z : -e.z);
        float4 clip = mul(p->view_projection, float4(corner, 1.0));
        if (clip.w <= 0.0) return true;
        float2 ndc = clip.xy / clip.w;
        ndc_min = min(ndc_min, ndc);
        ndc_max = max(ndc_max, ndc);
    }
    float2 min_ndc = max(ndc_min, float2(-1.0, -1.0));
    float2 max_ndc = min(ndc_max, float2(1.0, 1.0));
    if (min_ndc.x >= max_ndc.x || min_ndc.y >= max_ndc.y) return true;
    float2 base = p->hiz_base_size;
    float2 t_min = (min_ndc * 0.5 + 0.5) * base;
    float2 t_max = (max_ndc * 0.5 + 0.5) * base;
    float2 span = t_max - t_min;
    float lf = log2(max(span.x, span.y) / 4.0);
    uint level = lf > 0.0 ? uint(lf) + 1u : 0u;
    if (level >= p->hiz_levels) level = p->hiz_levels - 1u;
    float scale = exp2(float(level));
    float2 ls = base / scale;
    uint x0 = uint(max(t_min.x / scale, 0.0));
    uint y0 = uint(max(t_min.y / scale, 0.0));
    uint x1 = uint(min(t_max.x / scale, ls.x - 1.0));
    uint y1 = uint(min(t_max.y / scale, ls.y - 1.0));
    float strongest = 1.0;
    bool any_covered = false;
    for (uint y = y0; y <= y1; y++) {
        for (uint x = x0; x <= x1; x++) {
            any_covered = true;
            float v = g_rw_textures_2d[p->hiz_view_indices[level]][int2(int(x), int(y))];
            strongest = min(strongest, v);
        }
    }
    if (!any_covered) return true;
    return best > strongest + p->hiz_epsilon;
}

[shader("compute")]
[numthreads(64, 1, 1)]
void main(uint3 dispatch_id : SV_DispatchThreadID) {
    Draw_Params* params = p.get();

    uint instance_id = dispatch_id.x;
    if (instance_id >= params->instance_count) return;

    if ((params->instances[instance_id].flags & 1u) != 0u) {
        params->visible_flags[instance_id] = 0u;
        return;
    }

    Bounds b = params->bounds[instance_id];

    if (params->cull_mode == 0u) {
        if (params->first_frame != 0u) {
            params->occluded_flags[instance_id] = 0u;
        }

        if (!box_inside_frustum(b, params->frustum_planes)) {
            params->occluded_flags[instance_id] = 0u;
            params->visible_flags[instance_id] = 0u;
            return;
        }

        if (params->history_enabled != 0u) {
            InterlockedAdd(params->counters[6u], 1u);
            if (!hiz_box_visible(b, params)) {
                InterlockedAdd(params->counters[3u], 1u);
                params->occluded_flags[instance_id] = 1u;
                params->visible_flags[instance_id] = 0u;
                return;
            }
        }

        params->occluded_flags[instance_id] = 0u;

        uint group_id = params->instance_group_static[instance_id];
        if (group_id >= params->group_count) {
            params->visible_flags[instance_id] = 0u;
            return;
        }

        params->visible_flags[instance_id] = 1u;
        params->instance_groups[instance_id] = group_id;

        uint slot;
        InterlockedAdd(params->group_counts[group_id], 1u, slot);
        return;
    }

    if (params->occluded_flags[instance_id] == 0u) return;

    if (!box_inside_frustum(b, params->frustum_planes)) {
        params->occluded_flags[instance_id] = 0u;
        return;
    }

    if (hiz_box_visible(b, params)) {
        uint group_id = params->instance_group_static[instance_id];
        params->visible_flags[instance_id] = 1u;
        params->instance_groups[instance_id] = group_id;

        uint slot;
        InterlockedAdd(params->group_counts[group_id], 1u, slot);
        InterlockedAdd(params->counters[4u], 1u);
        params->occluded_flags[instance_id] = 0u;
    } else {
        params->visible_flags[instance_id] = 0u;
        InterlockedAdd(params->counters[5u], 1u);
        params->occluded_flags[instance_id] = 1u;
    }
}
