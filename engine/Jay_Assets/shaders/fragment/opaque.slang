#include "../jay_api.slang"

struct Opaque_Params {
    float4 base_color;
};

float4 main(Vertex_Output input, Opaque_Params params) {
    float3 normal = normalize(input.normal);
    float3 light = normalize(float3(0.5, -0.5, 1.0));
    float lighting = 0.2 + 0.8 * max(0.0, dot(normal, light));
    return float4(params.base_color.rgb * lighting, params.base_color.a);
}
