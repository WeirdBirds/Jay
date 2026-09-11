#include "jay.slang"

[shader("fragment")]
float4 main(float4 position : SV_Position) : SV_Target0 {
    Fragment_Params* params = fp.get();
    uint2 pixel = uint2(position.xy);
    float4 accumulated = g_textures_2d[params->translucent_color].Load(int3(pixel, 0));
    float coverage = g_textures_2d[params->translucent_coverage].Load(int3(pixel, 0)).x;
    float alpha = 1.0 - coverage;
    float3 color = accumulated.rgb / max(accumulated.a, 1e-5);
    return float4(color, alpha);
}
