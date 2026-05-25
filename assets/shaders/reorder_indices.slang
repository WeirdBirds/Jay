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

[[vk::push_constant]] PopulatePush push;
[[vk::binding(1, 0)]] RWStructuredBuffer<uint> bucket_counts;
[[vk::binding(2, 0)]] RWStructuredBuffer<uint> bucket_heads;
[[vk::binding(3, 0)]] RWStructuredBuffer<uint> sorted_indices;

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

uint depth_bucket(float depth) {
    float span = max(push.far_plane - push.near_plane, 0.0001);
    float t = saturate((depth - push.near_plane) / span);
    uint bucket = (uint)(t * float(push.bucket_count));
    return min(bucket, push.bucket_count - 1);
}

uint first_vertex_for_plane(uint plane_id) {
    return plane_id * 4;
}

void clear_sorted_indices(uint plane_id) {
    uint base = plane_id * push.plane_index_count;
    [unroll]
    for (uint i = 0; i < 4; ++i) {
        sorted_indices[base + i] = 0;
    }
}

void write_sorted_indices(uint dst_plane, uint src_plane) {
    uint dst_base = dst_plane * push.plane_index_count;
    uint src_base = first_vertex_for_plane(src_plane);
    sorted_indices[dst_base + 0] = src_base + 0;
    sorted_indices[dst_base + 1] = src_base + 1;
    sorted_indices[dst_base + 2] = src_base + 2;
    sorted_indices[dst_base + 3] = src_base + 3;
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
            clear_sorted_indices(id);

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

    uint bucket = depth_bucket(plane_depth(id));

    if (push.mode == MODE_COUNT) {
        InterlockedAdd(bucket_counts[bucket], 1);
        return;
    }

    if (push.mode == MODE_SCATTER) {
        uint dst_plane;
        InterlockedAdd(bucket_heads[bucket], 1, dst_plane);
        write_sorted_indices(dst_plane, id);
    }
}
