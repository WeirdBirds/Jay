struct Compute_Data<T> {
    [[vk::offset(16)]]
        T* data;
    [ForceInline] T* get() { return data; }
};

struct Vertex_Data<T> {
    [[vk::offset(0)]]
        T* data;
    [ForceInline] T* get() { return data; }
};

struct Fragment_Data<T> {
    [[vk::offset(8)]]
        T* data;
    [ForceInline] T* get() { return data; }
};

struct Bounds {
    float4 center_radius; 
}

struct Mesh_Instance {
    uint mesh_id;
    uint flags;
    uint64_t material;
}

struct Mesh {     
    uint first_index;
    uint index_count;
    int  vertex_offset;
}

struct Draw_Group {
    uint mesh_id;
    uint padding0;
    uint padding1;
    uint padding2;
}

struct Draw_Indexed_Command { 
    uint index_count;
    uint instance_count;
    uint first_index;
    int  vertex_offset;
    uint first_instance;
}

struct Draw_Params {
    uint group_count;
    uint instance_count;
    uint cull_mode;           // 0 = pass A (frustum + history), 1 = pass B (rescue retest)
    uint history_enabled;     // camera-motion gate: 0 = disable history test (frustum only)
    uint reset_counters;      // 1 = reset dispatch also zeroes the HiZ stats ring (chain A only;
                              //     chain B must NOT wipe what chain A / hiz_build already wrote)

    float4 frustum_planes[6];

    // Culling helpers (Z-up left-handed, reverse-Z: near -> 1.0, far -> 0.0).
    float4x4 view_projection; // full VP (matches the render pass)
    float4x4 view;            // view matrix (sphere -> view-space depth)
    float2 hiz_base_size;     // pyramid base dims
    float2 ndc_coeffs;        // reverse-Z coefficients: revz(d) = coeffs.y / d - coeffs.x
    float hiz_epsilon;        // depth slack against the tile min (never culls past it)
    float pad_hiz;
    uint hiz_levels;
    uint first_frame;         // 1 => zero occluded_flags before culling

    uint hiz_view_indices[16]; // storage-view index per pyramid level

    uint* occluded_flags;     // persistent GPU-only: 1 = rejected last frame (history)
    uint* counters;           // per-frame stats ring (HiZ_Counters: rejected/rescued/confirmed/history)

    Mesh_Instance* instances;
    float4x4* transforms;
    Bounds* bounds;
    Mesh* meshes;
    Draw_Group* groups;
    uint* instance_group_static;

    uint* visible_flags;
    uint* instance_groups;
    uint* group_counts;
    uint* group_offsets;
    uint* group_write_cursor;
    uint* total_visible;
    uint* visible_instances;
    Draw_Indexed_Command* draw_commands;
    uint* draw_count;
}

struct Vertex {
    float3 position;
    float3 normal;
    float3 color;
    float2 uv;
}

struct Vertex_Params {
    float4x4 view_projection;
    Vertex* vertices;
    Mesh_Instance* instances;
    float4x4* transforms;
    uint* visible_instances;
}

struct Vertex_Output {
    float4 position   : SV_Position;
    float3 normal     : NORMAL;
    float3 color      : COLOR0;
    float2 uv         : TEXCOORD0;
    uint   instance_id : TEXCOORD1;
};

struct Fragment_Params {
    Mesh_Instance* instances;
}

