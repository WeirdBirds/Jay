struct VertexInput {
    float3 position    : POSITION;
    float3 color       : COLOR;
    float2 uv          : TEXCOORD0;
    float  plane_coord : TEXCOORD1;
};

struct ControlPoint {
    float3 position    : POSITION;
    float3 color       : COLOR;
    float2 uv          : TEXCOORD0;
    float  plane_coord : TEXCOORD1;
};

struct PixelInput {
    float3 color       : COLOR;
    float2 uv          : TEXCOORD0;
    float  plane_coord : TEXCOORD1;
    float3 world_pos   : TEXCOORD2;
    float4 sv_position : SV_Position;
};

struct Globals {
    row_major float4x4 view;
    row_major float4x4 proj;
    float2 resolution;
    float time;
    float _padding0;
    float4 camera_pos;
};

struct Object_Data {
    row_major float4x4 model;
    int texture_index;
};

struct HullConstants {
    float tess_outer[4] : SV_TessFactor;
    float tess_inner[2] : SV_InsideTessFactor;
};

struct AxisSubdivision {
    float world_min;
    float fine_min;
    float fine_max;
    float world_max;
    float left_segments;
    float fine_segments;
    float right_segments;
    float total_segments;
};

static const float WORLD_TEXTURE_REPEAT_UNITS = 1.0;
static const float WORLD_TEXTURE_SCALE = 1.0 / WORLD_TEXTURE_REPEAT_UNITS;
static const int WORLD_GRID_SIZE = 4096;
static const int WORLD_GRID_HEIGHT = 512;
static const float WORLD_HALF = 0.5 * float(WORLD_GRID_SIZE);
static const float WORLD_HEIGHT_F = float(WORLD_GRID_HEIGHT);
static const float2 WALL_GRID_EXTENT = float2(float(WORLD_GRID_SIZE), float(WORLD_GRID_HEIGHT));
static const float2 FLOOR_GRID_EXTENT = float2(float(WORLD_GRID_SIZE), float(WORLD_GRID_SIZE));
static const float LOCAL_TESS_RADIUS = 1;
static const float EPSILON = 1e-5;

int clamp_voxel_axis(int value, int limit)
{
    return clamp(value, 0, limit - 1);
}

float clamp_sample_coord(float value, uint texture_size)
{
    float half_texel = 0.5 / float(texture_size);
    return clamp(value, half_texel, 1.0 - half_texel);
}

float snap_to_grid(float value)
{
    return value >= 0.0 ? floor(value + 0.5) : ceil(value - 0.5);
}

float cell_uv_component(float value)
{
    float snapped = snap_to_grid(value);
    if (abs(value - snapped) <= EPSILON)
        return abs(snapped) <= EPSILON ? 0.0 : 1.0;

    return frac(value);
}

AxisSubdivision make_axis_subdivision(float camera_axis, float axis_min, float axis_max, bool enable_fine_grid)
{
    AxisSubdivision result;
    result.world_min = axis_min;
    result.world_max = axis_max;

    if (!enable_fine_grid)
    {
        result.fine_min = axis_min;
        result.fine_max = axis_max;
        result.left_segments = 0.0;
        result.fine_segments = 1.0;
        result.right_segments = 0.0;
        result.total_segments = 1.0;
        return result;
    }

    float fine_min = clamp(floor(camera_axis - LOCAL_TESS_RADIUS), axis_min, axis_max - 1.0);
    float fine_max = clamp(ceil(camera_axis + LOCAL_TESS_RADIUS), axis_min + 1.0, axis_max);

    result.fine_min = fine_min;
    result.fine_max = fine_max;
    result.left_segments = fine_min > axis_min ? 1.0 : 0.0;
    result.fine_segments = max(fine_max - fine_min, 1.0);
    result.right_segments = fine_max < axis_max ? 1.0 : 0.0;
    result.total_segments = result.left_segments + result.fine_segments + result.right_segments;
    return result;
}

float map_axis(float t, float4 world_bounds, float4 segment_counts)
{
    float world_min = world_bounds.x;
    float fine_min  = world_bounds.y;
    float fine_max  = world_bounds.z;
    float world_max = world_bounds.w;

    float left_segments  = segment_counts.x;
    float fine_segments  = segment_counts.y;
    float right_segments = segment_counts.z;
    float total_segments = max(segment_counts.w, 1.0);

    if (total_segments <= 1.0 + EPSILON)
        return lerp(world_min, world_max, saturate(t));

    float left_end = left_segments / total_segments;
    float fine_end = (left_segments + fine_segments) / total_segments;

    if (left_segments > 0.0 && t <= left_end + EPSILON)
    {
        float local_t = left_end > EPSILON ? saturate(t / left_end) : 0.0;
        return lerp(world_min, fine_min, local_t);
    }

    if (fine_segments > 0.0 && t <= fine_end + EPSILON)
    {
        float fine_span = fine_segments / total_segments;
        float local_t = fine_span > EPSILON ? saturate((t - left_end) / fine_span) : 0.0;
        return lerp(fine_min, fine_max, local_t);
    }

    float right_span = right_segments / total_segments;
    float local_t = right_span > EPSILON ? saturate((t - fine_end) / right_span) : 1.0;
    return lerp(fine_max, world_max, local_t);
}

[[vk::binding(0, 0)]] ConstantBuffer<Globals> globals;
[[vk::binding(1, 0)]] StructuredBuffer<Object_Data> objects;
[[vk::binding(3, 0)]] Sampler2D textures[];

[shader("vertex")]
ControlPoint vert_main(VertexInput input)
{
    ControlPoint output;
    output.position = floor(input.position);
    output.color = input.color;
    output.uv = input.uv;
    output.plane_coord = input.plane_coord;
    return output;
}

HullConstants patch_constants(InputPatch<ControlPoint, 4> patch)
{
    HullConstants result;

    float3 plane_normal = patch[0].color;
    float3 camera_pos = globals.camera_pos.xyz;

    AxisSubdivision axis0;
    AxisSubdivision axis1;
    bool enable_fine_grid = false;

    if (abs(plane_normal.x) > 0.5)
    {
        enable_fine_grid = abs(patch[0].position.x - camera_pos.x) <= LOCAL_TESS_RADIUS;
        axis0 = make_axis_subdivision(camera_pos.y, -WORLD_HALF, WORLD_HALF, enable_fine_grid);
        axis1 = make_axis_subdivision(camera_pos.z, 0.0, WORLD_HEIGHT_F, enable_fine_grid);
    }
    else if (abs(plane_normal.y) > 0.5)
    {
        enable_fine_grid = abs(patch[0].position.y - camera_pos.y) <= LOCAL_TESS_RADIUS;
        axis0 = make_axis_subdivision(camera_pos.x, -WORLD_HALF, WORLD_HALF, enable_fine_grid);
        axis1 = make_axis_subdivision(camera_pos.z, 0.0, WORLD_HEIGHT_F, enable_fine_grid);
    }
    else
    {
        enable_fine_grid = abs(patch[0].position.z - camera_pos.z) <= LOCAL_TESS_RADIUS;
        axis0 = make_axis_subdivision(camera_pos.x, -WORLD_HALF, WORLD_HALF, enable_fine_grid);
        axis1 = make_axis_subdivision(camera_pos.y, -WORLD_HALF, WORLD_HALF, enable_fine_grid);
    }

    result.tess_outer[0] = axis1.total_segments;
    result.tess_outer[1] = axis0.total_segments;
    result.tess_outer[2] = axis1.total_segments;
    result.tess_outer[3] = axis0.total_segments;
    result.tess_inner[0] = axis1.total_segments;
    result.tess_inner[1] = axis0.total_segments;

    return result;
}

[shader("hull")]
[outputcontrolpoints(4)]
[domain("quad")]
[partitioning("integer")]
[outputtopology("triangle_cw")]
[patchconstantfunc("patch_constants")]
ControlPoint hull_main(InputPatch<ControlPoint, 4> patch, uint control_point_id : SV_OutputControlPointID)
{
    return patch[control_point_id];
}

[shader("domain")]
[domain("quad")]
PixelInput domain_main(HullConstants patch_data,
                       const OutputPatch<ControlPoint, 4> patch,
                       float2 domain_location : SV_DomainLocation)
{
    PixelInput output;

    float3 plane_normal = patch[0].color;
    float3 camera_pos = globals.camera_pos.xyz;

    AxisSubdivision axis0_subdivision;
    AxisSubdivision axis1_subdivision;
    bool enable_fine_grid = false;

    if (abs(plane_normal.x) > 0.5)
    {
        enable_fine_grid = abs(patch[0].position.x - camera_pos.x) <= LOCAL_TESS_RADIUS;
        axis0_subdivision = make_axis_subdivision(camera_pos.y, -WORLD_HALF, WORLD_HALF, enable_fine_grid);
        axis1_subdivision = make_axis_subdivision(camera_pos.z, 0.0, WORLD_HEIGHT_F, enable_fine_grid);
    }
    else if (abs(plane_normal.y) > 0.5)
    {
        enable_fine_grid = abs(patch[0].position.y - camera_pos.y) <= LOCAL_TESS_RADIUS;
        axis0_subdivision = make_axis_subdivision(camera_pos.x, -WORLD_HALF, WORLD_HALF, enable_fine_grid);
        axis1_subdivision = make_axis_subdivision(camera_pos.z, 0.0, WORLD_HEIGHT_F, enable_fine_grid);
    }
    else
    {
        enable_fine_grid = abs(patch[0].position.z - camera_pos.z) <= LOCAL_TESS_RADIUS;
        axis0_subdivision = make_axis_subdivision(camera_pos.x, -WORLD_HALF, WORLD_HALF, enable_fine_grid);
        axis1_subdivision = make_axis_subdivision(camera_pos.y, -WORLD_HALF, WORLD_HALF, enable_fine_grid);
    }

    float4 axis0_world = float4(axis0_subdivision.world_min, axis0_subdivision.fine_min, axis0_subdivision.fine_max, axis0_subdivision.world_max);
    float4 axis1_world = float4(axis1_subdivision.world_min, axis1_subdivision.fine_min, axis1_subdivision.fine_max, axis1_subdivision.world_max);
    float4 axis0_counts = float4(axis0_subdivision.left_segments, axis0_subdivision.fine_segments, axis0_subdivision.right_segments, axis0_subdivision.total_segments);
    float4 axis1_counts = float4(axis1_subdivision.left_segments, axis1_subdivision.fine_segments, axis1_subdivision.right_segments, axis1_subdivision.total_segments);

    float axis0 = map_axis(domain_location.x, axis0_world, axis0_counts);
    float axis1 = map_axis(domain_location.y, axis1_world, axis1_counts);

    float3 world_pos;
    float2 plane_uv;

    if (abs(plane_normal.x) > 0.5)
    {
        world_pos = float3(patch[0].position.x, axis0, axis1);
        world_pos.y = snap_to_grid(world_pos.y);
        world_pos.z = snap_to_grid(world_pos.z);
        plane_uv = float2((world_pos.y + WORLD_HALF) / float(WORLD_GRID_SIZE), world_pos.z / WORLD_HEIGHT_F);
    }
    else if (abs(plane_normal.y) > 0.5)
    {
        world_pos = float3(axis0, patch[0].position.y, axis1);
        world_pos.x = snap_to_grid(world_pos.x);
        world_pos.z = snap_to_grid(world_pos.z);
        plane_uv = float2((world_pos.x + WORLD_HALF) / float(WORLD_GRID_SIZE), world_pos.z / WORLD_HEIGHT_F);
    }
    else
    {
        world_pos = float3(axis0, axis1, patch[0].position.z);
        world_pos.x = snap_to_grid(world_pos.x);
        world_pos.y = snap_to_grid(world_pos.y);
        plane_uv = float2((world_pos.x + WORLD_HALF) / float(WORLD_GRID_SIZE), (world_pos.y + WORLD_HALF) / float(WORLD_GRID_SIZE));
    }

    output.sv_position = mul(globals.proj, mul(globals.view, float4(world_pos, 1.0)));
    output.color = plane_normal;
    output.uv = plane_uv;
    output.plane_coord = patch[0].plane_coord;
    output.world_pos = world_pos;
    return output;
}

[shader("fragment")]
float4 frag_main(PixelInput inVert, bool is_front_face : SV_IsFrontFace) : SV_Target
{
    float2 base_uv;
    float2 cell_uv;
    if (abs(inVert.color.x) > 0.5)
    {
        base_uv = float2(inVert.world_pos.y, inVert.world_pos.z);
        cell_uv = float2(cell_uv_component(base_uv.x), cell_uv_component(base_uv.y));
    }
    else if (abs(inVert.color.y) > 0.5)
    {
        base_uv = float2(inVert.world_pos.x, inVert.world_pos.z);
        cell_uv = float2(cell_uv_component(base_uv.x), cell_uv_component(base_uv.y));
    }
    else
    {
        base_uv = float2(inVert.world_pos.x, inVert.world_pos.y);
        cell_uv = float2(cell_uv_component(base_uv.x), cell_uv_component(base_uv.y));
    }

    int texture_index = objects[0].texture_index;
    uint texture_width = 1;
    uint texture_height = 1;
    textures[texture_index].GetDimensions(texture_width, texture_height);

    float2 half_texel = 0.5 / float2(float(texture_width), float(texture_height));
    cell_uv = clamp(cell_uv, half_texel, float2(1.0, 1.0) - half_texel);

    float2 uv_ddx = ddx(base_uv);
    float2 uv_ddy = ddy(base_uv);
    return textures[texture_index].SampleGrad(cell_uv, uv_ddx, uv_ddy);
    //return float4(cell_uv, 0, 1);
}
