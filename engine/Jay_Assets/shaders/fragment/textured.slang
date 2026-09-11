#include "jay.slang"

struct Textured_Params {
    float4 base_color;
    float2 uv_shift;
    float4x4 temp;
};

float4 main(
    Vertex_Output input,
    Textured_Params params,
    Texture2D albedo,
    Texture2D normal,
    SamplerState sampler) // for now default SGPU sampler
                          // idk, feels like having image+sampler abstraction
                          // is nice, we'll see
{
    float4 sampled_normal = normal.Sample(sampler, input.uv);
    float3 light = normalize(float3(0.5, -0.5, 1.0));

    float lighting = 0.55 + 0.45 * max(0.0, dot(sampled_normal.xyz, light));

    float4 color = albedo.Sample(sampler, input.uv + params.uv_shift);
    return float4(color.rgb * params.base_color.rgb * lighting, params.base_color.a);
}
