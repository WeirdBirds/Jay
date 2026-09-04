# Jay_Render Material System Plan

Goal: make user-defined materials pleasant from Jai and Slang while keeping Jay_Render SGPU-friendly. Shader authors declare material inputs once. Jai material structs are generated from Slang reflection. Renderer owns packing, resource tables, GPU pointers, layout validation, and indirect draw integration.

## Goals

- CPU side must feel like normal Jai data initialization.
- Shader side must feel like normal shader authoring, not Vulkan descriptor plumbing.
- Slang reflection is source of truth for generated material schema.
- Generated Jai structs are material recipe structs, not byte-for-byte GPU layout mirrors.
- Material data must work with GPU-driven / indirect drawing.
- No per-material descriptor binding path. Material selection happens through a per-instance `Material*` GPU pointer into the material constants heap.
- Engine-owned vertex/fragment/global params remain separate and are not part of this material API.

## Non-goals

- Do not expose descriptor sets, bindings, UBO/SSBO names, push constants, or Vulkan layout details to material users.
- Do not require Jai structs to match Slang memory layout exactly.
- Do not let indirect draw choose shaders dynamically. Pipelines are still grouped and bound by command recording.
- Do not make native Slang primitives (`Texture2D`, `ConstantBuffer`, etc.) the public material contract. Use Jay-owned semantic primitives instead.

## User-facing CPU API

User declares a material type from shader assets:

```jai
PBR_Material :: Material(
    vertex   = Name.from_path("/shaders/pbr_vs.slang"),
    fragment = Name.from_path("/shaders/pbr_fs.slang"),
);
```

`Material(...)` expands/generates a concrete Jai struct from reflected shader material schema:

```jai
PBR_Material :: struct {
    vertex:   PBR_Vertex_Material;    // Generated only if shader declares material fields for vertex stage.
    fragment: PBR_Fragment_Material;  // Generated from fragment material schema.
}
```

Example use:

```jai
material: PBR_Material = .{
    fragment = .{
        pbr = .{
            base_color = .{1, 0, 0, 1},
            roughness = 0.55,
            metallic = 0.0,
        },
        albedo = Name.from_path("/textures/brick_albedo.png"),
        normal = Name.from_path("/textures/brick_normal.png"),
    },
};

material_ptr := upload_material(material);
spawn_mesh(mesh, transform, material_ptr);
```

Generated material values are recipes/descriptors. They contain scalar params and asset `Name`s. They do not contain renderer handles, hidden runtime state, GPU pointers, or ownership. After `upload_material` returns, the Jai material value may be freed.

User does not see offsets, GPU heaps, bindless indices, descriptor layouts, or packing rules.

## User-facing Slang API

Jay provides a shader module, likely `jay_material.slang`, with namespace `Jay`.

Shader material fields use Jay semantic primitives:

```slang
import jay_material;

struct PBR_Params {
    float4 base_color;
    float roughness;
    float metallic;
    float normal_strength;
};

Jay::Params<PBR_Params> pbr;
Jay::Texture2D albedo;
Jay::Texture2D normal;
Jay::Sampler sampler;
```

Shader usage should stay ergonomic:

```slang
PBR_Params pbr_params = pbr.get();
float4 albedo_value = albedo.sample(sampler, uv);
```

The `Jay::` primitives are not new GPU objects. They are semantic front-end types. Jay lowers them to pointers, offsets, bindless indices, tables, and generated load/sample helpers.

## Material primitive list

| Primitive | Generated Jai field | GPU representation | Purpose |
| --- | --- | --- | --- |
| `Jay::Params<T>` | `T` | pointer/offset into material constants heap | Small fixed material constants |
| `Jay::Array<T>` | `[]T` | pointer/offset + count | Variable per-material data |
| `Jay::Ref<T>` | `Name` | pointer/index to shared uploaded blob | Large/shared material asset |
| `Jay::Texture2D` | `Name` | bindless texture index | Single 2D texture asset |
| `Jay::Texture2D_Array` | `[]Name` or `Name` texture-array asset | resource table range or texture-array index | Multiple 2D texture assets / texture-array asset |
| `Jay::TextureCube` | `Name` | bindless texture index | Cubemap texture asset |
| `Jay::Sampler` | `Name` or `Sampler_Desc` | bindless/static sampler index | Configurable sampler asset/description |
| `Jay::SampledTexture2D` | `Sampled_Texture2D_Recipe` (`texture: Name`, `sampler: Name` or desc) | texture index + sampler index | Convenience texture asset + sampler |

V1 minimum:

- `Jay::Params<T>`
- `Jay::Texture2D`
- `Jay::Sampler` or default sampler path
- optionally `Jay::SampledTexture2D`

Later:

- `Jay::Array<T>`
- `Jay::Texture2D_Array`
- `Jay::TextureCube`
- `Jay::Ref<T>`

Important rule: `Jay::Array<T>` is for plain data. Resource arrays should use explicit resource primitives like `Jay::Texture2D_Array`, not `Jay::Array<Jay::Texture2D>`.

## Slang declaration convention

Each shader stage declares material fields as top-level `Jay::` primitives:

```slang
Jay::Params<Wind_Params> wind;
Jay::Params<PBR_Params> pbr;
Jay::Texture2D albedo;
```

Reflection rule: top-level globals whose type is in `Jay::` namespace and matches a material primitive become material fields. Other top-level shader globals remain engine/shader internals and are ignored by material generation unless another engine system claims them.

Generated Jai separates fields by shader stage based on which shader asset declares them:

```jai
material.vertex.wind
material.fragment.pbr
material.fragment.albedo
```

If vertex and fragment declare the same field name, no conflict exists because generated fields live under separate `vertex` and `fragment` structs. Duplicate names inside the same stage are an error.

Reusable shader modules should expose structs, not loose globals:

```slang
// pbr.slang
struct PBR_Params {
    float4 base_color;
    float roughness;
    float metallic;
};

// terrain.slang
struct Terrain_Layer {
    float4 tint;
    float scale;
};
```

Composed material fields:

```slang
import pbr;
import terrain;

Jay::Params<PBR_Params> pbr;
Jay::Array<Terrain_Layer> layers;
Jay::Texture2D_Array layer_textures;
```

## Reflection and codegen pipeline

Jay_Render compiles each `.slang` source directly through `compile_pipeline_shader`. Material reflection must share that path and return reflection with the compiled SPIR-V; it must not restore a generic Slang asset handler.

Required output per shader asset:

```jai
Shader_Compile_Output :: struct {
    spirv: []u8;
    reflection: Shader_Reflection;
}

Shader_Reflection :: struct {
    entry_points: []Shader_Entry_Reflection;
    material_fields: []Material_Field_Reflection;
    layout_hash: u64;
}
```

Each reflected field stores semantic kind and backend layout:

```jai
Material_Field_Kind :: enum {
    Params;
    Array;
    Ref;
    Texture2D;
    Texture2D_Array;
    TextureCube;
    Sampler;
    SampledTexture2D;
}

Material_Field_Reflection :: struct {
    stage: Shader_Stage;
    name: Name;
    source_name: string;
    kind: Material_Field_Kind;
    value_type_name: string;      // T in Jay::Params<T>, Jay::Array<T>, etc.
    reflected_type: Type_Info;    // serialized schema, not Jai Type_Info directly

    // For packed data fields.
    size: u32;
    alignment: u32;
    fields: []Packed_Field;       // nested fields with offsets/sizes from Slang layout

    // For resources.
    binding_index: u32;
    binding_space: u32;
    resource_slot: u32;           // generated stable slot inside material resource table
}
```

Material type codegen consumes vertex+fragment shader reflection and emits:

- Jai material struct.
- Jai nested structs for reflected `T` if not already present/generated.
- default initializer helpers if useful.
- `upload_material` specialization.
- pack functions for every `Jay::Params<T>` and `Jay::Array<T>` element type.
- resource slot metadata.
- layout hash constants.

Generated Jai structs are material recipes. They are temporary CPU-side descriptions: scalar data plus asset `Name`s. Packer writes scalar params to reflected GPU offsets instead of relying on byte-identical Jai layout. Resource fields are resolved by `Name` during upload.

## Generated packer model

For each `Jay::Params<T>`, generator emits a packer:

```jai
pack_PBR_Params :: (src: *PBR_Params, dst: []u8, layout: *Packed_Type_Layout) {
    write_field(dst, layout, #name "base_color", src.base_color);
    write_field(dst, layout, #name "roughness", src.roughness);
    write_field(dst, layout, #name "metallic", src.metallic);
    write_field(dst, layout, #name "normal_strength", src.normal_strength);
}
```

`write_field` uses Slang-reflected offsets/sizes for the target backend. This avoids byte-for-byte Jai/Slang struct mirroring.

For arrays:

```jai
pack_array_T :: (src: []T, allocator: Allocator) -> Gpu_Slice {
    bytes := alloc(allocator, src.count * reflected_stride_of_T);
    for item, i: src pack_T(*item, bytes[i * stride ..]);
    return .{ ptr = to_gpu_ptr(allocator, bytes), count = src.count, stride = stride };
}
```

## Runtime renderer data model

Split schema, recipe, and uploaded GPU record.

- `Material_Type`: reflected shader schema + pipeline key. Long-lived.
- generated `PBR_Material`: temporary recipe with params and asset `Name`s. Can die after upload.
- `Uploaded_Material`: renderer-owned cached GPU record behind a `Material_Id`.

```jai
Material_Type :: struct {
    id: u32;
    name: Name;

    vertex_shader: Name;
    fragment_shader: Name;
    pipeline_id: u32;

    layout: Material_Layout;
    layout_hash: u64;
}

Uploaded_Material :: struct {
    type_id: u32;
    material_ptr: Gpu_Ptr;   // GPU pointer to packed constants in the material constants heap
    item_hash: u64;          // canonical material recipe hash

    constants_allocation: Gpu_Allocation;
    resource_base: u32;
    resource_count: u32;

    dependencies: []u64;     // item hashes retained during upload: textures, samplers, arrays, etc.
}
```

All uploadable assets share one metadata table:

```jai
Uploaded_Metadata :: struct {
    id: u32;
    ref_count: u32;
}

uploaded_metadata: Table<u64, Uploaded_Metadata>; // item_hash -> id + ref_count
```

`item_hash` is the canonical identity of an uploadable item:

- texture item hash = texture asset `Name` hash
- mesh item hash = mesh asset `Name` hash
- shader item hash = shader asset `Name` hash
- sampler item hash = sampler asset `Name` hash or sampler description hash
- material item hash = generated material recipe hash

Material recipe hash must include domain/type/layout data so it is globally unique:

- material type id and layout hash
- packed scalar params or source scalar values
- texture/sampler asset `Name`s
- array contents or array asset `Name`s

If an identical uploaded item already exists, renderer increments its metadata `ref_count` and returns the existing id. If not, renderer uploads/creates the item, inserts `item_hash -> id + ref_count`, and returns the new id.

Because hash collisions are theoretically possible, debug builds may keep enough canonical payload data to verify equality after hash match.

GPU-visible material model:

Materials are packed constant blobs allocated in the material constants heap. Each instance holds a direct GPU pointer to its material blob — no indirection through a global material table:

```jai
// V1 packed material (matches slang `Material` in common.slang, 28 bytes)
Material :: struct {
    base_color:    Vec4;
    texture_index: u32;
    sampler_index: u32;
    flags:         u32;
}
```

```slang
struct Material {
    float4 base_color;
    uint texture_index;
    uint sampler_index;
    uint flags;
}

struct Mesh_Instance {
    uint mesh_id;
    uint flags;
    Material* material;   // Gpu_Ptr into the material constants heap
}
```

Instance and draw-group records carry the pointer directly:

```jai
// renderer-owned state
Draw_Group {
    mesh_id:  u32;
    material: Gpu_Ptr;
}

Mesh_Instance {
    mesh_id:  u32;
    flags:    u32;
    material: Gpu_Ptr;
}
```

Resource table entries:

```jai
MaterialResource :: struct {
    kind: Material_Resource_Kind;
    index: u32;                  // bindless texture index, sampler index, etc.
}
```

Material upload resolves `Name` fields through the shared uploaded metadata table. Example: `Jay::Texture2D albedo` becomes Jai `albedo: Name`; upload resolves that `Name` hash to an uploaded texture id, uploading the texture first if missing, and stores the texture's bindless index in the material resource table.

For `Jay::SampledTexture2D`, either store two adjacent resource entries or a packed pair:

```jai
SampledTextureData :: struct {
    texture_index: u32;
    sampler_index: u32;
}
```

## Use of `Gpu_Heap`

`Gpu_Heap` is the natural allocator for material constants and variable material data.

Create dedicated heaps:

```jai
material_constants_allocator = Gpu_Heap(MATERIAL_CONSTANTS_BUDGET, 16);
material_array_allocator     = Gpu_Heap(MATERIAL_ARRAY_BUDGET, 16);
```

Upload path:

```jai
item_hash := hash_material_recipe(recipe);
if meta := table_find(*uploaded_metadata, item_hash) {
    meta.ref_count += 1;
    return meta.material_ptr;
}

// Resolve dependencies through same uploaded_metadata table.
// Example: texture_id := upload_texture(recipe.fragment.albedo);

ptr := alloc(material_constants_allocator, layout.constants_size);
pack_material_constants(recipe, ptr, layout);

material_ptr := to_gpu_ptr(material_constants_allocator, ptr);

table_add(*uploaded_metadata, item_hash, .{ id = material_ptr, ref_count = 1 });
```

Upload is not a deep copy of arbitrary CPU objects. It consumes a material recipe, resolves asset names, uploads missing dependencies, packs scalar params, and creates or reuses a GPU material record. The original recipe can be freed after `upload_material` returns.

Caveat: `Gpu_Heap` resize can move allocations. Material system must either:

1. avoid resize for material constants, or
2. update `material_ptr` immediately after any move, or
3. store offsets and update offsets after move.

V1 recommendation: no resize for material constants. Uploaded materials are immutable records. To change material values, upload a new recipe and switch instances to the returned `Material_Id`; release the old id when no longer used.

## Material lifetime and deduplication

Material recipes have call-site lifetime only:

```jai
iron_id := upload_material(PBR_Material.{
    fragment = .{
        pbr = .{ roughness = 0.32, metallic = 1.0 },
        albedo = Name.from_path("/textures/iron.png"),
    },
});
```

After `upload_material` returns, the `PBR_Material` value can be discarded. Renderer-owned lifetime starts at the returned `Material_Id`.

Reference-counted API:

```jai
upload_material  :: (recipe: $M) -> Material_Id; // create or reuse, ref_count++
release_material :: (id: Material_Id);           // ref_count--, deferred free when zero
```

When `release_material(id)` reaches zero:

1. remove `item_hash -> id` from `uploaded_metadata`;
2. release texture/sampler dependencies by decrementing their `uploaded_metadata` refcounts;
3. enqueue constants/array/resource-table allocations for deferred free after `FRAME_COUNT` frames;
4. free the constants allocation when safe.

If two equal recipes are uploaded, both calls return the same `Material_Id` and increment the same refcount. Equality is based on the canonical material item hash, not pointer identity.

## Indirect draw integration

Indirect draw does not choose shaders. Command recording still binds one pipeline at a time. Material system participates through grouping; the instance carries a direct `Material*` pointer.

Per instance:

```jai
Mesh_Instance :: struct {
    mesh_id:  u32;
    flags:    u32;
    material: Gpu_Ptr;   // *Material into the material constants heap
}
```

GPU grouping key should include pipeline/material type, not material instance values:

```text
group_key = pipeline_id + mesh_id + material_type_id
```

Material instance values differ through the `material` pointer, so many materials can share one pipeline group.

Frame command recording:

```jai
for group in draw_groups {
    gpu_set_pipeline(cmd, group.pipeline_id);
    gpu_draw_indexed_indirect_count(
        cmd,
        frame.vertex_params_gpu,
        data.fragment_params_gpu,
        index_data_gpu,
        group.draw_commands,
        group.draw_count,
        group.max_draws
    );
}
```

Shader access path (current V1 implementation):

```slang
uint visible_instance = params.visible_instances[instance_id];
Mesh_Instance inst = params.instances[visible_instance];
Material mat = *inst.material;
```

Vertex shader passes the culled instance id (not the raw draw instance id — it indexes `visible_instances`) to the fragment stage as a flat varying:

```slang
struct VS_Out {
    float4 position : SV_Position;
    uint instance_id : TEXCOORD1;   // flat (auto-decorated for uint varyings)
};
```

Fragment shader loads the material through the per-instance pointer:

Fragment shader loads material data:

```slang
Fragment_Params* params = fp.get();
Mesh_Instance inst = params.instances[input.instance_id];
Material mat = *inst.material;
```

Packed constants beyond V1's `Material` (e.g. `Jay::Params<T>`) live at the same pointer; resource slots resolve through the material resource table using `mat.texture_index`/`mat.sampler_index` or future table pointers.

User-facing wrapper should hide this behind generated helpers where possible:

```slang
PBR_Params pbr = material.pbr.get();
float4 color = material.albedo.sample(material.sampler, uv);
```

## Generated Slang helper model

Because `Jay::` primitives are semantic wrappers, they need shader support code.

V1 can use generated helper functions per material type:

```slang
PBR_Params Jay_load_PBR_Params(Material* mat);
Texture2D Jay_get_PBR_albedo(Material* mat);
SamplerState Jay_get_PBR_sampler(Material* mat);
```

Wrapper methods can call these helpers if Slang generic/member support allows it. If method-based wrappers are awkward, V1 can use explicit functions:

```slang
PBR_Params pbr = Jay::get(material.pbr);
float4 color = Jay::sample(material.albedo, material.sampler, uv);
```

Implementation choice depends on Slang capabilities around generic structs, methods, operator lowering, and reflection visibility. Public design should keep `Jay::` primitive names stable even if helper implementation changes.

## Resource tables and bindless model

All material resources use global descriptor arrays / SGPU resource tables.

Example tables:

```slang
Texture2D global_textures_2d[];
TextureCube global_textures_cube[];
SamplerState global_samplers[];
StructuredBuffer<MaterialResource> material_resources;
```

Material lookup is direct — the instance holds `Material*` (no `materials[]` table):

```slang
Material* mat_ptr = inst.material;
MaterialResource res = material_resources[mat_ptr->texture_index];
Texture2D tex = global_textures_2d[res.index];
```

Generated constants define stable slots:

```slang
static const uint PBR_SLOT_ALBEDO = 0;
static const uint PBR_SLOT_NORMAL = 1;
static const uint PBR_SLOT_SAMPLER = 2;
```

## Layout hash and validation

Every material type gets a layout hash from reflection.

Hash should include:

- vertex shader name/hash
- fragment shader name/hash
- entry point names
- top-level material field names and stages
- Jay primitive kinds
- value type names
- packed field names/types/offsets/sizes/alignments
- resource slots/kinds
- relevant Slang target/backend info

Generated Jai contains:

```jai
PBR_MATERIAL_LAYOUT_HASH :: 0x12345678abcdef00;
```

Shader asset reflection contains same hash. At compile-time if possible, otherwise startup/runtime:

```jai
assert(PBR_MATERIAL_LAYOUT_HASH == shader_reflection.layout_hash);
```

Failure means generated Jai material code is stale relative to shader reflection.

## Error handling and validation

Generator should fail loudly for unsupported material fields:

- unsupported `Jay::` primitive
- unsupported field type inside `Jay::Params<T>`
- resource arrays nested inside plain arrays
- duplicate material field names within one shader stage
- vertex/fragment material type conflict
- layout hash mismatch

Errors should reference shader path, reflected field path, and suggested fix.

Example:

```text
Material reflection error in /shaders/pbr_fs.slang:
layers: Jay::Array<Jay::Texture2D> is unsupported.
Use Jay::Texture2D_Array for arrays of textures.
```

## Implementation stages

### Stage 1: Reflection metadata

- Extend direct Slang compilation to return reflection metadata.
- Detect top-level `Jay::Params<T>`, `Jay::Texture2D`, `Jay::Sampler` fields.
- Keep `Shader_Reflection` with the direct compile output.
- Generate and store layout hash.

### Stage 2: Jai codegen

- Implement `Material(vertex, fragment)` compile-time generator.
- Generate Jai recipe structs.
- Generate packers for `Jay::Params<T>`.
- Generate resource slot tables.
- Add layout hash validation.

### Stage 3: Runtime material upload

- Add `Material_Type` registry.
- Add `Uploaded_Material` management (keyed by `material_ptr`).
- Add shared `uploaded_metadata: Table<u64, Uploaded_Metadata>` for all uploadable assets.
- Add material constants `Gpu_Heap` (already present: `Render_Data.material_allocator`).
- Add material resource table.
- Implement `upload_material` and `release_material`.

### Stage 4: Shader access library

- Add `jay_material.slang` with `Jay::` primitive declarations.
- Add generated or generic load/sample helpers.
- Connect helpers to existing SGPU buffers: instances, material pointers, resource tables, global texture/sampler arrays.

### Stage 5: Indirect draw integration

- `Mesh_Instance` carries `material: Gpu_Ptr` (done in the current implementation).
- Include `pipeline_id`/`material_type_id` in draw group construction.
- Bind pipeline per group.
- Pass culled instance id from vertex to fragment; fragment dereferences `instances[id].material`.
- Validate many material instances can draw under one pipeline group.

### Stage 6: More primitives

- Add `Jay::SampledTexture2D` sugar.
- Add `Jay::Array<T>`.
- Add `Jay::Texture2D_Array`.
- Add `Jay::TextureCube`.
- Add `Jay::Ref<T>` when shared large blobs are needed.

## Open decisions

- Exact Slang syntax for namespace use: likely `Jay::Params<T>`, verify with current Slang compiler.
- Whether public shader usage can be method-style (`pbr.get()`) or function-style (`Jay::get(pbr)`).
- Whether generated Jai structs are emitted into source files or injected through `#insert` at compile time.
- Whether Slang reflection is produced by CLI JSON, C API binding, or a custom handler wrapper.
- Whether material records expose `Gpu_Ptr` directly or hide it behind a handle. User API unaffected.

## Recommended defaults

- Use namespace `Jay` and primitive names like `Jay::Params<T>`.
- Use top-level `Jay::` globals as material fields. No `ParameterBlock` material root for V1.
- Use generated Jai recipe structs, never byte-identical GPU mirrors.
- Use reflected offsets for packing.
- Use `Gpu_Heap` for material constants.
- Store `Material*` (`Gpu_Ptr`) per instance, pointing into the material constants heap.
- Group indirect draws by pipeline/material type/mesh, not by material instance.
- Keep resource arrays explicit (`Jay::Texture2D_Array`) instead of nesting resources in `Jay::Array<T>`.
