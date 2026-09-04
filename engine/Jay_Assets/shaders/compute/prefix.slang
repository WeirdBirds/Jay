#include "../jay_api.slang"

[shader("compute")]
[numthreads(1, 1, 1)]
void main(uint3 dispatch_id : SV_DispatchThreadID) {

    Draw_Params* params = p.get();

    uint sum = 0;

    for (uint group_id = 0; group_id < params.group_count; group_id++) {
        uint count = params.group_counts[group_id];

        params.group_offsets[group_id] = sum;
        params.group_write_cursor[group_id] = 0;

        sum += count;
    }

    params.total_visible[0] = sum;
#if JAY_DEBUG
    // Debug slot [19] holds the pass-A visible total (the Frame log's vis).
    // Chain B reports nothing here — its prefix would overwrite pass A's number.
    if (params.cull_mode == 0u && params.counters != nullptr) {
        params.counters[19u] = sum;
    }
#endif
}
