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
//   from this frame's real depth (hiz_sphere_visible). Survivors are added
//   back to the draw lists before the frame presents: no result reaches the
//   screen unless the current-frame occlusion pyramid agrees.
//
// Counters (HiZ_Counters ring): [3] rejected_A (predicted), [4] rescued_B,
// [5] confirmed_B, [6] history tests run. Conservation invariant:
// rejected_A == rescued_B + confirmed_B.
// The ring is zeroed once per frame by chain A's reset dispatch
// (Draw_Params.reset_counters); chain B's reset must leave it alone.
//
// Reverse-Z, Z-up left-handed, depth test GREATER, conservative reduction
// MIN: the pyramid tile value is the farthest occluder surface, so a tile can
// never hide anything it does not actually cover.

#include "../jay_api.slang"

// Bindless heap (set 0 — matches sgpu bindless.jai):
//   binding 1: storage images (element index = gpu_texture_view handle)
[[vk::binding(1, 0)]]
RWTexture2D<float> g_rw_textures_2d[];

[ForceInline]
bool sphere_inside_frustum(float4 center_radius, float4 frustum_planes[6]) {
    for (uint i = 0; i < 6; i++) {
        float4 plane = frustum_planes[i];
        float d = dot(plane.xyz, center_radius.xyz) + plane.w;
        if (d < -center_radius.w) return false;
    }
    return true;
}

// Conservative same-frame pyramid test. The pyramid stores the tile MIN =
// the farthest occluder surface in the tile (the strongest occluder). The
// sphere can only be hidden when every pixel of its projection loses the
// GREATER depth test: the strongest tile min across the sphere's screen AABB
// beats the sphere's best possible depth (its nearest surface). Any other
// outcome errs visible, which is the safe direction — a false-visible result
// is corrected for free, a false-occluded one would pop geometry.
[ForceInline]
bool hiz_sphere_visible(Bounds b, Draw_Params* p) {
    // View-space depth of the center: the view matrix rows are the basis
    // vectors with forward along -Z (GL-style projection, w = -z), so the
    // forward distance is the negated z. depth = revz(d) is depth-buffer
    // value (near -> 1.0, far -> 0.0), and the depth test is GREATER.
    float4 cv = mul(p->view, float4(b.center_radius.xyz, 1.0));
    float d = -cv.z;
    float r = b.center_radius.w;
    if (d - r <= 0.0) return true;   // camera inside the sphere: always visible

    // Reverse-Z depth of the sphere's nearest surface (its best case).
    float best = p->ndc_coeffs.y / (d - r) - p->ndc_coeffs.x;

    // Projected center in NDC.
    float4 c_clip = mul(p->view_projection, float4(b.center_radius.xyz, 1.0));
    float2 c_ndc = c_clip.xy / c_clip.w;

    // NDC half-extent per axis: project the center displaced along that view
    // axis by the radius. The view rows are the basis (row 0 = right,
    // row 1 = up). The clip w stays at the center depth, so the NDC offset is
    // exact for the sampled axis displacement.
    float3 right = float3(p->view[0][0], p->view[0][1], p->view[0][2]);
    float3 up    = float3(p->view[1][0], p->view[1][1], p->view[1][2]);
    float4 c_r = mul(p->view_projection, float4(b.center_radius.xyz + right * r, 1.0));
    float4 c_u = mul(p->view_projection, float4(b.center_radius.xyz + up * r, 1.0));
    float2 r_ndc = float2(abs(c_r.x / c_r.w - c_ndc.x),
                          abs(c_u.y / c_u.w - c_ndc.y));

    float2 min_ndc = max(c_ndc - r_ndc, float2(-1.0, -1.0));
    float2 max_ndc = min(c_ndc + r_ndc, float2(1.0, 1.0));
    if (min_ndc.x >= max_ndc.x || min_ndc.y >= max_ndc.y) return true;

    // NDC -> pyramid base texels, then to the level where the AABB fits in a
    // ~4x4 block. A sub-texel AABB samples the single covering texel.
    float2 base = p->hiz_base_size;
    float2 t_min = (min_ndc * 0.5 + 0.5) * base;
    float2 t_max = (max_ndc * 0.5 + 0.5) * base;
    float2 span = t_max - t_min;
    // Smallest level whose tiles are <= 2x2 over the AABB: need
    // span / 2^level <= 2, i.e. level >= log2(span / 2). Ceil, no skip —
    // the old uint(lf)+1 jumped one level too far (span 8 -> level 2),
    // over-coarsening the test.
    float lf = log2(max(span.x, span.y) * 0.5);
    uint level = lf > 0.0 ? uint(ceil(lf)) : 0u;
    if (level >= p->hiz_levels) level = p->hiz_levels - 1u;
    float scale = exp2(float(level));
    float2 ls = base / scale;
    uint x0 = uint(max(t_min.x / scale, 0.0));
    uint y0 = uint(max(t_min.y / scale, 0.0));
    uint x1 = uint(min(t_max.x / scale, ls.x - 1.0));
    uint y1 = uint(min(t_max.y / scale, ls.y - 1.0));

    // Conservative overlap: sample every tile the projected disk actually
    // touches. Centre-only sampling misses tiles where the disk overlaps the
    // tile but its centre is outside, which makes a sky tile's 0.0 disappear
    // from the min and causes false occlusion (popping). Square AABB sampling
    // does the opposite (too many sky tiles, no culling). Overlap is the safe
    // middle.
    float2 c_l = (c_ndc * 0.5 + 0.5) * base / scale;   // disk centre in level tiles
    float2 r_l = r_ndc * base / scale;                 // disk half-extent in level tiles
    float2 r_inv = float2(1.0, 1.0) / max(r_l, float2(1e-4, 1e-4));

    float strongest = 1.0;
    bool any_covered = false;
    for (uint y = y0; y <= y1; y++) {
        for (uint x = x0; x <= x1; x++) {
            // Closest point on this tile to the disk centre.
            float2 closest = clamp(c_l, float2(float(x), float(y)), float2(float(x)+1.0, float(y)+1.0));
            float2 d2 = (closest - c_l) * r_inv;
            if (dot(d2, d2) > 1.0) continue;   // no overlap
            any_covered = true;
            float v = g_rw_textures_2d[p->hiz_view_indices[level]][int2(int(x), int(y))];
            strongest = min(strongest, v);
        }
    }

    // No tile overlapped: the sphere projects smaller than the sampling
    // grid — never claim occlusion from an empty footprint.
    if (!any_covered) return true;

    bool hidden = best <= strongest + p->hiz_epsilon;
    if (!hidden) return true;
    // Second level (coarser) for conservatism: hidden only if both levels agree
    if (level + 1 < p->hiz_levels) {
        uint level2 = level + 1;
        float scale2 = exp2(float(level2));
        float2 ls2 = base / scale2;
        uint x02 = uint(max(t_min.x / scale2, 0.0));
        uint y02 = uint(max(t_min.y / scale2, 0.0));
        uint x12 = uint(min(t_max.x / scale2, ls2.x - 1.0));
        uint y12 = uint(min(t_max.y / scale2, ls2.y - 1.0));
        float strongest2 = 1.0;
        bool any2 = false;
        for (uint y = y02; y <= y12; y++) {
            for (uint x = x02; x <= x12; x++) {
                float2 closest = clamp(c_l, float2(float(x), float(y)), float2(float(x)+1.0, float(y)+1.0));
                float2 d2 = (closest - c_l) * r_inv;
                if (dot(d2, d2) > 1.0) continue;
                any2 = true;
                float v = g_rw_textures_2d[p->hiz_view_indices[level2]][int2(int(x), int(y))];
                strongest2 = min(strongest2, v);
            }
        }
        if (!any2) return true;
        hidden = best <= strongest2 + p->hiz_epsilon;
        if (!hidden) return true;
    }
    return false;
}

[shader("compute")]
[numthreads(64, 1, 1)]
void main(uint3 dispatch_id : SV_DispatchThreadID) {
    Draw_Params* params = p.get();

    uint instance_id = dispatch_id.x;
    if (instance_id >= params->instance_count) return;

    Bounds b = params->bounds[instance_id];

    if (params->cull_mode == 0u) {
        // Pass A: frustum, then the history prediction against the pyramid as
        // it stands (last frame's depth, since the rebuild happens after the
        // render that follows this chain). A hidden sphere is a PREDICTION
        // only — it is flagged so pass B re-tests it against the fresh
        // pyramid before this frame presents.
        if (params->first_frame != 0u) {
            params->occluded_flags[instance_id] = 0u;
        }

        if ((params->instances[instance_id].flags & 1u) != 0u) {
            // Dead slot. Clear any stale reject left over from before the
            // instance was destroyed — otherwise pass B keeps rescuing and
            // re-confirming a ghost every frame the rescue chain runs.
            params->visible_flags[instance_id] = 0u;
            params->occluded_flags[instance_id] = 0u;
            return;
        }
        if (!sphere_inside_frustum(b.center_radius, params->frustum_planes)) {
            params->occluded_flags[instance_id] = 0u;
            params->visible_flags[instance_id] = 0u;
            return;
        }

        if (params->history_enabled != 0u) {
            InterlockedAdd(params->counters[6u], 1u);   // history test run
            if (!hiz_sphere_visible(b, params)) {
                // Predicted occluded — pass B retests against the fresh
                // pyramid before anything reaches the screen.
                InterlockedAdd(params->counters[3u], 1u);   // rejected_A
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

    // Pass B: rescue retest of the pass-A predictions against the fresh
    // pyramid. Instances visible in A never carry a flag; CLEAR their stale
    // pass-A visibility bit — otherwise this chain's scatter would re-add
    // every pass-A survivor into the rescue draw list at wrong offsets
    // (group scratch was just reset; masked in single-group scenes).
    if (params->occluded_flags[instance_id] == 0u) {
        params->visible_flags[instance_id] = 0u;
        return;
    }

    // The instance left the frustum: clear the flag and drop it. Retesting a
    // frustum-out object every frame would be pure waste.
    if (!sphere_inside_frustum(b.center_radius, params->frustum_planes)) {
        params->occluded_flags[instance_id] = 0u;
        return;
    }

    if (hiz_sphere_visible(b, params)) {
        // Rescued: re-add to the draw lists with the current-frame pyramid.
        uint group_id = params->instance_group_static[instance_id];
        params->visible_flags[instance_id] = 1u;
        params->instance_groups[instance_id] = group_id;

        uint slot;
        InterlockedAdd(params->group_counts[group_id], 1u, slot);
        InterlockedAdd(params->counters[4u], 1u);   // rescued_B
        params->occluded_flags[instance_id] = 0u;
    } else {
        // Confirmed hidden by this frame's real depth.
        params->visible_flags[instance_id] = 0u;
        InterlockedAdd(params->counters[5u], 1u);   // confirmed_B
        params->occluded_flags[instance_id] = 1u;
    }
}