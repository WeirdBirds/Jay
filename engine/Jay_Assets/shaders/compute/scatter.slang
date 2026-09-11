#include "jay.slang"

[shader("compute")]
[numthreads(64, 1, 1)]
void main(uint3 dispatch_id : SV_DispatchThreadID) {

    Draw_Params* params = cp.get();

    uint instance_id = dispatch_id.x;
    if (instance_id >= params.instance_count) return;

    if (params.visible_flags[instance_id] == 0) return;

    uint group_id = params.instance_groups[instance_id];

    uint slot;
    InterlockedAdd(params.group_write_cursor[group_id], 1, slot);

    uint dst = params.group_offsets[group_id] + slot;
    params.visible_instances[dst] = instance_id;
#if DEBUG
    if (params.counters != nullptr) InterlockedAdd(params.counters[23u], 1u);   // debug: instances drawn by this chain (slot outside hiz per-dispatch range)
#endif
}
