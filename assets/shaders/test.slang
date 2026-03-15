struct VertexInput {
    float3 position : POSITION;
    float3 color    : COLOR;
};

struct VertexOutput {
    float3 color;
    float4 sv_position : SV_Position;
};

struct Globals {
    row_major float4x4 view;
    row_major float4x4 proj;
    float2 resolution;
    float time;    
};

struct Object_Data {
    row_major float4x4 model;
};

[[vk::binding(0, 0)]] ConstantBuffer<Globals> globals;
[[vk::binding(1, 0)]] StructuredBuffer<Object_Data> objects;

[shader("vertex")]
VertexOutput vert_main(VertexInput input, uint instance_id : SV_InstanceID) {
    VertexOutput output;
    float4 world_pos = mul(objects[instance_id].model, float4(input.position, 1.0));
    output.sv_position = mul(globals.proj, mul(globals.view, world_pos));
    output.color = input.color;
    return output;
}

[shader("fragment")]
float4 frag_main(VertexOutput inVert) : SV_Target
{
    float3 color = inVert.color;
    return float4(color, 1.0);
}
