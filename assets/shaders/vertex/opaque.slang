#include "../common.slang"

[[vk::push_constant]]
Vertex_Data<Vertex_Params> vp;

[shader("vertex")]
Vertex_Output main(uint vertex_id : SV_VulkanVertexID, uint instance_id : SV_VulkanInstanceID) {
    Vertex_Params* params = vp.get();

    uint visible_instance = params.visible_instances[instance_id];
    Mesh_Instance instance = params.instances[visible_instance];
    Vertex vertex = params.vertices[vertex_id];
    float4x4 transform = params.transforms[visible_instance];

    Vertex_Output output;
    output.position = mul(params.view_projection, mul(transform, float4(vertex.position, 1.0)));
    output.normal = vertex.normal;
    output.color = vertex.color;
    output.uv = vertex.uv;
    output.material_id = instance.material_id;
    return output;
}
