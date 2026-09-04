#include "../jay_api.slang"

struct Opaque_Params {
    float4 base_color;
};

Jay::Params<Opaque_Params> opaque;

[shader("fragment")]
float4 main(Vertex_Output input) : SV_Target0 {
    Fragment_Params* params = fp.get();
    Mesh_Instance instance = params.instances[input.instance_id];
    Opaque_Params material = opaque.get((Opaque_Params*)instance.material);

    float3 normal = normalize(input.normal);
    float3 light = normalize(float3(0.5, -0.5, 1.0));
    float lighting = 0.2 + 0.8 * max(0.0, dot(normal, light));
    return float4(material.base_color.rgb * lighting, material.base_color.a);
}
