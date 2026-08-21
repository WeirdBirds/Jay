#include "../jay_api.slang"

[shader("compute")]
[numthreads(64, 1, 1)]
void main(uint3 dispatch_id : SV_DispatchThreadID) {

    Draw_Params* params = p.get();

    uint index = dispatch_id.x;

    // Zero this frame's counter slot before its chains add to it (per-frame
    // ring, read by the CPU three frames later).
    if (index < 32u) params.counters[index] = 0u;

    if (index < params.group_count) {
        params.group_counts[index] = 0;
        params.group_offsets[index] = 0;
        params.group_write_cursor[index] = 0;
    }

    if (index == 0) {
        params.total_visible[0] = 0;
        params.draw_count[0] = 0;
    }
}
