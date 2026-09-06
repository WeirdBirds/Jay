#include "../jay_api.slang"

[shader("fragment")]
float4 main(float4 position : SV_Position) : SV_Target0 {
    Fragment_Params* params = fp.get();
    uint2 pixel = uint2(position.xy);
    float4 accumulated = g_textures_2d[params->oit_accumulator].Load(int3(pixel, 0));
    float revealage = g_textures_2d[params->oit_revealage].Load(int3(pixel, 0)).x;
    float alpha = 1.0 - revealage;
    float3 color = accumulated.rgb / max(accumulated.a, 1e-5);
    return float4(color, alpha);
}
