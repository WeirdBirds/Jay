#include "../jay_api.slang"

[shader("compute")]
[numthreads(64, 1, 1)]
void main(uint3 dispatch_id : SV_DispatchThreadID) {

    Draw_Params* params = p.get();

    uint group_id = dispatch_id.x;
    if (group_id >= params.group_count) return;

    uint count = params.group_counts[group_id];
    if (count == 0) return;

    // Uncompacted slot: command for group g lives at slot g, so the CPU can
    // draw per (domain, pipeline) group without knowing GPU compaction order.
    // The draw_count atomic survives for stats only.
    InterlockedAdd(params.draw_count[0], 1u);
#if JAY_DEBUG
    if (params.counters != nullptr) InterlockedAdd(params.counters[18u], 1u); // debug: draw commands emitted
#endif

    Draw_Group group = params.groups[group_id];
    Mesh mesh = params.meshes[group.mesh_id];

    Draw_Indexed_Command cmd;
    cmd.index_count    = mesh.index_count;
    cmd.instance_count = count;
    cmd.first_index    = mesh.first_index;
    cmd.vertex_offset  = mesh.vertex_offset;
    cmd.first_instance = params.group_offsets[group_id];

    params.draw_commands[group_id] = cmd;
}
