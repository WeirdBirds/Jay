struct VertexInput {
    float3 position : POSITION;
    float3 color    : COLOR;
    float2 uv       : TEXCOORD;
};

struct VertexOutput {
    float3 color;
    float2 uv;
    float3 world_pos;
    float4 sv_position : SV_Position;
    int texture_index;
};

struct Globals {
    row_major float4x4 view;
    row_major float4x4 proj;
    float2 resolution;
    float time;    
};

struct Object_Data {
    row_major float4x4 model;
    int texture_index;
};

static const float WORLD_TEXTURE_REPEAT_UNITS = 1.0;
static const float WORLD_TEXTURE_SCALE = 1.0 / WORLD_TEXTURE_REPEAT_UNITS;
static const float HEIGHT_WAVE_FREQUENCY = 0.15;

[[vk::binding(0, 0)]] ConstantBuffer<Globals> globals;
[[vk::binding(1, 0)]] StructuredBuffer<Object_Data> objects;
[[vk::binding(3, 0)]] Sampler2D textures[];

[shader("vertex")]
VertexOutput vert_main(VertexInput input, uint instance_id : SV_InstanceID) {
    VertexOutput output;

    float3 world_pos = input.position;
    output.sv_position = mul(globals.proj, mul(globals.view, float4(world_pos, 1.0)));
    output.color = input.color;
    output.uv = input.uv;
    output.world_pos = world_pos;
    output.texture_index = objects[0].texture_index;
    return output;
}

[shader("fragment")]
float4 frag_main(VertexOutput inVert) : SV_Target
{
    float2 plane_uv = inVert.uv * WORLD_TEXTURE_SCALE;
    return textures[inVert.texture_index].Sample(plane_uv);
} 
