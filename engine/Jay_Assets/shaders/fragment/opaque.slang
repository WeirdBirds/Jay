#include "../jay_api.slang"

[shader("fragment")]
float4 main(Vertex_Output input) : SV_Target0 {
    Fragment_Params* params = fp.get();
    Mesh_Instance instance = params.instances[input.instance_id];
    Material mat = *instance.material;

    float3 N = normalize(input.normal);
    float3 L = normalize(float3(0.5, -0.5, 1.0));
    float ndotl = max(0.0, dot(N, L));

    float lighting = 0.2 + 0.8 * ndotl;   // ← ambient 30% so never black

    return float4(mat.base_color.rgb * lighting, mat.base_color.a);
}
