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

struct Material {
    float4 base_color;
    uint texture_index;
    uint sampler_index;
    uint flags;
    uint padding;
}

struct Bounds {
    float4 center_radius; 
}

struct Mesh_Instance {
    uint mesh_id;
    uint flags;
    uint material_index;
    uint padding;
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
    uint padding0;
    uint padding1;

    float4 frustum_planes[6];

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
    Material* materials;
}

