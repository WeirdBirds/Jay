struct Weighted_OIT_Output {
    float4 accumulation : SV_Target0;
    float revealage : SV_Target1;
};

Weighted_OIT_Output weighted_oit(float4 color, float depth) {
    float weight = clamp(
        pow(min(1.0, color.a * 10.0) + 0.01, 3.0) * 1e4 * pow(0.1 + depth * 0.9, 3.0),
        1e-2,
        3e3);
    Weighted_OIT_Output output;
    output.accumulation = float4(color.rgb * color.a, color.a) * weight;
    output.revealage = color.a;
    return output;
}

namespace Jay {
    // Compiler-private material blob helpers. Shader authors use ordinary
    // function parameters; generated _jay_main resolves these once.
    // Layout: [params byte size][slot count][slots...][params bytes].
#if JAY_STAGE == JAY_STAGE_FRAGMENT
    uint64_t material_blob(uint instance_id) {
        Fragment_Params* params = fp.get();
        return params->instances[instance_id].material;
    }
#endif

    uint resource_count(uint64_t blob) { return ((uint*)blob)[1]; }

    // Slots start after the 8-byte header: slot i lives at u32 index 2+i.
    uint slot_index(uint64_t blob, uint i) { return ((uint*)blob)[2u + i]; }

    // Byte address of the params region. Slots-first keeps params facing a
    // single computed offset; resources stay countable by the author.
    uint64_t params_blob(uint64_t blob) {
        return blob + 8u + resource_count(blob) * 4u;
    }

}
