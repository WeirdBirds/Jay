#include "jay.slang"

[shader("compute")]
[numthreads(64, 1, 1)]
void main(uint3 dispatch_id : SV_DispatchThreadID) {

    Draw_Params* params = cp.get();

    uint index = dispatch_id.x;

    // Zero this frame's counter slot before its chains add to it (per-frame
    // ring, read by the CPU three frames later). Gated by reset_counters:
    // chain A sets it, chain B leaves it clear so the stats written earlier
    // in the frame (hiz_build base/mip/zero, pass-A rejected/history)
    // survive until readback.
#if DEBUG
    if (params.reset_counters != 0u && params.counters != nullptr && index < 32u) params.counters[index] = 0u;
#endif

    if (index < params.group_count) {
        params.group_counts[index] = 0;
        params.group_offsets[index] = 0;
        params.group_write_cursor[index] = 0;
        // Uncompacted command slot: the CPU draws group g from slot g, so an
        // empty group must be a no-op draw (index_count 0), never stale data.
        params.draw_commands[index].index_count = 0;
        params.draw_commands[index].instance_count = 0;
        params.draw_commands[index].first_index = 0;
        params.draw_commands[index].vertex_offset = 0;
        params.draw_commands[index].first_instance = 0;
    }

    if (index == 0) {
        params.total_visible[0] = 0;
        params.draw_count[0] = 0;
    }
}
