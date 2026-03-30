struct PopulatePush {
    uint   mode;
    uint   total_planes;
    uint   bucket_count;
    uint   plane_index_count;
    uint   world_size;
    uint   world_height;
    uint   _padding0;
    uint   _padding1;
    float  tan_half_fov_h;
    float  tan_half_fov_v;
    float  near_plane;
    float  far_plane;
    float4 camera_pos;
    float4 camera_forward;
    float4 camera_right;
    float4 camera_up;
};

struct DrawIndexedIndirectCommand {
    uint indexCount;
    uint instanceCount;
    uint firstIndex;
    int  vertexOffset;
    uint firstInstance;
};

[[vk::push_constant]] PopulatePush push;
[[vk::binding(1, 0)]] RWStructuredBuffer<uint> bucket_counts;
[[vk::binding(2, 0)]] RWStructuredBuffer<uint> bucket_heads;
[[vk::binding(3, 0)]] RWStructuredBuffer<DrawIndexedIndirectCommand> indirect_commands;

static const uint MODE_CLEAR   = 0;
static const uint MODE_COUNT   = 1;
static const uint MODE_PREFIX  = 2;
static const uint MODE_SCATTER = 3;

uint x_plane_count() {
    return push.world_size + 1;
}

uint y_plane_count() {
    return push.world_size + 1;
}

uint z_plane_count() {
    return push.world_height + 1;
}

float half_world_x() {
    return float(push.world_size) * 0.5;
}

float half_world_y() {
    return float(push.world_size) * 0.5;
}

float world_height() {
    return float(push.world_height);
}

float3 to_view(float3 world_pos) {
    float3 delta = world_pos - push.camera_pos.xyz;
    return float3(
        dot(delta, push.camera_right.xyz),
        dot(delta, push.camera_up.xyz),
        dot(delta, push.camera_forward.xyz));
}

float side_limit_x(float z) {
    return max(z, push.near_plane) * push.tan_half_fov_h;
}

float side_limit_y(float z) {
    return max(z, push.near_plane) * push.tan_half_fov_v;
}

bool quad_visible(float3 p0, float3 p1, float3 p2, float3 p3) {
    float3 v0 = to_view(p0);
    float3 v1 = to_view(p1);
    float3 v2 = to_view(p2);
    float3 v3 = to_view(p3);

    if (v0.z < push.near_plane && v1.z < push.near_plane &&
        v2.z < push.near_plane && v3.z < push.near_plane) return false;

    if (v0.z > push.far_plane && v1.z > push.far_plane &&
        v2.z > push.far_plane && v3.z > push.far_plane) return false;

    if (v0.x < -side_limit_x(v0.z) && v1.x < -side_limit_x(v1.z) &&
        v2.x < -side_limit_x(v2.z) && v3.x < -side_limit_x(v3.z)) return false;

    if (v0.x > side_limit_x(v0.z) && v1.x > side_limit_x(v1.z) &&
        v2.x > side_limit_x(v2.z) && v3.x > side_limit_x(v3.z)) return false;

    if (v0.y < -side_limit_y(v0.z) && v1.y < -side_limit_y(v1.z) &&
        v2.y < -side_limit_y(v2.z) && v3.y < -side_limit_y(v3.z)) return false;

    if (v0.y > side_limit_y(v0.z) && v1.y > side_limit_y(v1.z) &&
        v2.y > side_limit_y(v2.z) && v3.y > side_limit_y(v3.z)) return false;

    return true;
}

float plane_depth(uint plane_id) {
    float3 center;
    uint x_count = x_plane_count();
    uint y_count = y_plane_count();

    if (plane_id < x_count) {
        float x = float(plane_id) - half_world_x();
        center = float3(x, 0.0, world_height() * 0.5);
    } else if (plane_id < x_count + y_count) {
        uint y_plane = plane_id - x_count;
        float y = float(y_plane) - half_world_y();
        center = float3(0.0, y, world_height() * 0.5);
    } else {
        uint z_plane = plane_id - x_count - y_count;
        center = float3(0.0, 0.0, float(z_plane));
    }

    return dot(center - push.camera_pos.xyz, push.camera_forward.xyz);
}

bool plane_visible(uint plane_id, out float depth) {
    uint x_count = x_plane_count();
    uint y_count = y_plane_count();
    float half_x = half_world_x();
    float half_y = half_world_y();
    float height = world_height();

    depth = plane_depth(plane_id);

    if (plane_id < x_count) {
        float x = float(plane_id) - half_x;
        return quad_visible(
            float3(x, -half_y, 0.0),
            float3(x, -half_y, height),
            float3(x,  half_y, height),
            float3(x,  half_y, 0.0));
    }

    if (plane_id < x_count + y_count) {
        uint y_plane = plane_id - x_count;
        float y = float(y_plane) - half_y;
        return quad_visible(
            float3(-half_x, y, 0.0),
            float3(-half_x, y, height),
            float3( half_x, y, height),
            float3( half_x, y, 0.0));
    }

    uint z_plane = plane_id - x_count - y_count;
    float z = float(z_plane);
    return quad_visible(
        float3(-half_x, -half_y, z),
        float3(-half_x,  half_y, z),
        float3( half_x,  half_y, z),
        float3( half_x, -half_y, z));
}

uint depth_bucket(float depth) {
    float span = max(push.far_plane - push.near_plane, 0.0001);
    float t = saturate((depth - push.near_plane) / span);
    uint bucket = (uint)(t * float(push.bucket_count));
    return min(bucket, push.bucket_count - 1);
}

uint first_index_for_plane(uint plane_id) {
    return plane_id * push.plane_index_count;
}

void clear_command(uint command_id) {
    indirect_commands[command_id].indexCount = 0;
    indirect_commands[command_id].instanceCount = 0;
    indirect_commands[command_id].firstIndex = 0;
    indirect_commands[command_id].vertexOffset = 0;
    indirect_commands[command_id].firstInstance = 0;
}

[shader("compute")]
[numthreads(64, 1, 1)]
void main(uint3 tid : SV_DispatchThreadID) {
    uint id = tid.x;

    if (push.mode == MODE_CLEAR) {
        if (id < push.bucket_count) {
            bucket_counts[id] = 0;
            bucket_heads[id] = 0;
        }

        if (id < push.total_planes)
            clear_command(id);

        return;
    }

    if (push.mode == MODE_PREFIX) {
        if (id != 0) return;

        uint running = 0;
        for (uint bucket = 0; bucket < push.bucket_count; ++bucket) {
            bucket_heads[bucket] = running;
            running += bucket_counts[bucket];
        }
        return;
    }

    if (id >= push.total_planes) return;

    float depth;
    if (!plane_visible(id, depth)) return;

    uint bucket = depth_bucket(depth);

    if (push.mode == MODE_COUNT) {
        InterlockedAdd(bucket_counts[bucket], 1);
        return;
    }

    if (push.mode == MODE_SCATTER) {
        uint dst;
        InterlockedAdd(bucket_heads[bucket], 1, dst);

        indirect_commands[dst].indexCount = push.plane_index_count;
        indirect_commands[dst].instanceCount = 1;
        indirect_commands[dst].firstIndex = first_index_for_plane(id);
        indirect_commands[dst].vertexOffset = 0;
        indirect_commands[dst].firstInstance = 0;
    }
}
