#include "../common.slang"

[[vk::push_constant]]
Compute_Data< Draw_Params> p;

[ForceInline]
bool sphere_inside_frustum(float4 center_radius, float4 frustum_planes[6]) {
    for (uint i = 0; i < 6; i++) {
        float4 plane = frustum_planes[i];
        float d = dot(plane.xyz, center_radius.xyz) + plane.w;
        if (d < -center_radius.w) return false;
    }
    return true;
}

[shader("compute")]
[numthreads(64, 1, 1)]
void main(uint3 dispatch_id : SV_DispatchThreadID) {
    
    Draw_Params* params = p.get();

    uint instance_id = dispatch_id.x;
    if (instance_id >= params.instance_count) return;

    // Read bounds for this instance
    Bounds bounds = params.bounds[instance_id];

    if (!sphere_inside_frustum(bounds.center_radius, params.frustum_planes)) {
        params.visible_flags[instance_id] = 0;
        return;
    }

    uint group_id = params.instance_group_static[instance_id];
    if (group_id >= params.group_count) {
        params.visible_flags[instance_id] = 0;
        return;
    }

    params.visible_flags[instance_id] = 1;
    params.instance_groups[instance_id] = group_id;

    uint slot;
    InterlockedAdd(params.group_counts[group_id], 1, slot);
}
