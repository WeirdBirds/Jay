#include "../jay_api.slang"

[shader("compute")]
[numthreads(64, 1, 1)]
void main(uint3 dispatch_id : SV_DispatchThreadID) {

    Draw_Params* params = p.get();

    uint group_id = dispatch_id.x;
    if (group_id >= params.group_count) return;

    uint count = params.group_counts[group_id];
    if (count == 0) return;

    uint draw_index;
    InterlockedAdd(params.draw_count[0], 1, draw_index);
    InterlockedAdd(params.counters[18u], 1u); // debug: draw commands emitted

    Draw_Group group = params.groups[group_id];
    Mesh mesh = params.meshes[group.mesh_id];

    Draw_Indexed_Command cmd;
    cmd.index_count    = mesh.index_count;
    cmd.instance_count = count;
    cmd.first_index    = mesh.first_index;
    cmd.vertex_offset  = mesh.vertex_offset;
    cmd.first_instance = params.group_offsets[group_id];

    params.draw_commands[draw_index] = cmd;
}
