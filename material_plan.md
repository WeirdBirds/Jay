# Jay_Render Material System

## Goal

Material shaders use normal Slang function arguments. Jay_Render reflects those arguments, generates a private fragment entry point, and packs one material blob per uploaded recipe.

Shader authors do not declare Jay marker globals. They do not access instance records, material blobs, resource slots, descriptor bindings, or GPU pointers.

## Shader API

A fragment material function is an ordinary, non-entry Slang function. Its first argument is always `Vertex_Output`. Later arguments define the material schema in declaration order.

```slang
#include "jay.slang"

struct Textured_Params {
    float4 base_color;
};

float4 main(
    Vertex_Output input,
    Textured_Params params,
    Texture2D albedo,
    Texture2D normal,
    SamplerState sampler)
{
    float4 sampled_normal = normal.Sample(sampler, input.uv);
    float3 light = normalize(float3(0.5, -0.5, 1.0));
    float lighting = 0.55 + 0.45 * max(0.0, dot(sampled_normal.xyz, light));

    float4 color = albedo.Sample(sampler, input.uv);
    return float4(color.rgb * params.base_color.rgb * lighting, params.base_color.a);
}
```

Material stages accept reflected struct parameters, `Texture2D` parameters, and `SamplerState` parameters. Structs contain fixed material constants. Texture and sampler arguments resolve through the material blob's bindless resource slots.

Unsupported function parameter types fail material generation with a shader-path error. Arrays, cubemaps, shared references, and resource arrays remain future work. The renderer does not silently fall back to marker globals or a second material path.

## Generated Entry Point

Jay_Render reflects `main`, then compiles a virtual sibling source. The authored `main` remains ordinary code. Only generated `_jay_main` is a shader entry point.

```slang
#include "textured.slang"

[shader("fragment")]
float4 _jay_main(Vertex_Output input) : SV_Target0 {
    uint64_t blob = Jay::material_blob(input.instance_id);

    return main(
        input,
        *(Textured_Params*)Jay::params_blob(blob),
        g_textures_2d[Jay::slot_index(blob, 0)],
        g_textures_2d[Jay::slot_index(blob, 1)],
        g_samplers[Jay::slot_index(blob, 2)]);
}
```

The wrapper resolves the blob once per fragment. Native texture and sampler values then move through the ordinary Slang call. Slang 2026 supports this SPIR-V path.

## CPU Recipe API

`Material(vertex, fragment, domain)` reflects vertex and fragment shader sources at compile time. Generated wrappers preserve each authored `main` signature while supplying reflected material arguments.

For the fragment function above, generated Jai recipe fields are:

```jai
recipe.fragment.params.base_color = Vec4.{1, 1, 1, 1};
recipe.fragment.albedo = Name.static("/textures/base_color.png");
recipe.fragment.normal = Name.static("/textures/normal.png");
```

`upload_material` resolves texture names through the asset system, writes bindless indices and packed constants into one GPU allocation, and returns a direct `Material_Id` GPU pointer. Identical packed recipes deduplicate.

## Blob Layout

Each stage region is:

```text
u32 params_byte_count
u32 resource_slot_count
u32 resource_slots[resource_slot_count]
u8  packed_params[params_byte_count]
```

Resource slot order follows function argument order, skipping the first `Vertex_Output` argument and struct parameter. The generated wrapper uses the same order. Slang reflection remains source of truth for struct field types and packed offsets.

## Renderer Contract

Each `Mesh_Instance` stores one direct material blob pointer. GPU culling preserves the visible instance ID. The vertex shader forwards it to the fragment shader. Generated `_jay_main` uses that ID to load the correct material blob.

Draw groups select a domain-local pipeline and mesh. They do not select a material instance. Many material blobs may share one pipeline.

Opaque and translucent domains remain explicit in `Material(..., domain)`. Opaque renders first with depth writes. Translucent uses weighted order-independent accumulation: it stores weighted premultiplied color in `R16G16B16A16_SFLOAT`, stores remaining coverage in `R16_SFLOAT`, then composites once over opaque color. Translucent material draw order does not affect this result. The method is approximate, but needs one translucent draw pass and one fullscreen composite pass.

## Validation

Each material change must verify:

1. Reflection sees `main` parameter order and resource kinds.
2. Generated wrapper compiles as `_jay_main` with current Slang.
3. Generated Jai recipe fields and blob slot order match wrapper arguments.
4. A fresh shader package loads at runtime.
5. A real scene renders through the public material API.

## Future Work

Add vertex material arguments, multiple packed struct arguments with reflected offsets, `TextureCube`, texture arrays, resource arrays, configurable samplers, and shared large data. Each extension must preserve this one function-parameter schema and one generated entry-wrapper path.
