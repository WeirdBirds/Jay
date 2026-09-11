// hiz_downsample.slang — Hi-Z pyramid construction.
//
// Reverse-Z semantics (Z-up left-handed projection: near -> 1.0, far -> 0.0,
// depth test GREATER): the conservative tile value is the MINIMUM depth over
// the tile, i.e. the tile's farthest occluder surface. A surface at depth d
// hides everything with reverse-Z depth < d.
//
// Mode 0 writes the pyramid base from the full-resolution depth buffer:
// each base texel = min of the corresponding 2x2 full-res depth values.
// Uncovered source pixels are the depth-clear value 0.0, so the min collapses
// to 0 and the tile can never occlude — conservative, never unsafe.
//
// Mode N (N >= 1) min-reduces mip N-1 into mip N. Levels are sized
// (ceil half of the parent, rounded to even), so every interior reduction is
// an exact 2x2 block. A block whose start lies past the source extent is a
// padding texel: it is written as 0.0 (unusable as occluder). A block that
// only partially overlaps the source clamps its samples to the edge, which
// duplicates valid samples — min(a, a) = a, so the result is exact for the
// covered source texels.

struct HiZ_Params {
    uint depth_view_index;   // sampled R32 view of the full-res depth buffer
    uint sampler_index;      // nearest / clamp-to-edge sampler
    uint src_view_index;     // storage view of source mip (mode >= 1)
    uint dst_view_index;     // storage view of destination mip
    uint src_width;
    uint src_height;
    uint dst_width;
    uint dst_height;
    uint mode;               // 0 = base from depth, 1 = mip-to-mip, 2 = reset
    uint dispatch_index;     // which dispatch this is (0 = base, 1..N = mips)
    uint* counters;          // [0] base_texels, [1] mip_texels, [2] zero_tiles, [7+di] per-dispatch
};

// Bindless heap (set 0 — matches sgpu bindless.jai):
//   binding 0: sampled images (element index = gpu_texture_view handle)
//   binding 1: storage images
//   binding 2: samplers
[[vk::binding(0, 0)]]
Texture2D g_textures_2d[];
[[vk::binding(1, 0)]]
RWTexture2D<float> g_rw_textures_2d[];
[[vk::binding(2, 0)]]
SamplerState g_samplers[];

// Single Gpu_Ptr pushed by gpu_dispatch at the compute stage offset (16).
struct HiZ_Root {
    [[vk::offset(16)]]
    HiZ_Params* data;
};

[[vk::push_constant]]
HiZ_Root root;

[shader("compute")]
[numthreads(8, 8, 1)]
void main(uint3 dispatch_id : SV_DispatchThreadID) {
    HiZ_Params* params = root.data;

    uint x = dispatch_id.x;
    uint y = dispatch_id.y;

    if (x >= params.dst_width || y >= params.dst_height) return;

    uint sx0 = x * 2u;
    uint sy0 = y * 2u;

    float value;

    if (sx0 >= params.src_width || sy0 >= params.src_height) {
        // Padding block: nothing real to reduce. Write 0 (far in reverse-Z)
        // so the tile can never occlude.
        value = 0.0;
    } else {
        uint sx1 = min(sx0 + 1u, params.src_width - 1u);
        uint sy1 = min(sy0 + 1u, params.src_height - 1u);

        if (params.mode == 0u) {
            float2 scale = float2(float(params.src_width), float(params.src_height));
            float2 uv00 = (float2(float(sx0), float(sy0)) + 0.5) / scale;
            float2 uv10 = (float2(float(sx1), float(sy0)) + 0.5) / scale;
            float2 uv01 = (float2(float(sx0), float(sy1)) + 0.5) / scale;
            float2 uv11 = (float2(float(sx1), float(sy1)) + 0.5) / scale;

            float d00 = g_textures_2d[params.depth_view_index].SampleLevel(
                g_samplers[params.sampler_index], uv00, 0.0).x;
            float d10 = g_textures_2d[params.depth_view_index].SampleLevel(
                g_samplers[params.sampler_index], uv10, 0.0).x;
            float d01 = g_textures_2d[params.depth_view_index].SampleLevel(
                g_samplers[params.sampler_index], uv01, 0.0).x;
            float d11 = g_textures_2d[params.depth_view_index].SampleLevel(
                g_samplers[params.sampler_index], uv11, 0.0).x;

            value = min(min(d00, d10), min(d01, d11));
#if DEBUG
            if (value == 0.0 && params.counters != nullptr) {
                InterlockedAdd(params.counters[2], 1u);
            }
#endif
        } else {
            int2 i00 = int2(int(sx0), int(sy0));
            int2 i10 = int2(int(sx1), int(sy0));
            int2 i01 = int2(int(sx0), int(sy1));
            int2 i11 = int2(int(sx1), int(sy1));

            float a = g_rw_textures_2d[params.src_view_index][i00];
            float b = g_rw_textures_2d[params.src_view_index][i10];
            float c = g_rw_textures_2d[params.src_view_index][i01];
            float d = g_rw_textures_2d[params.src_view_index][i11];

            value = min(min(a, b), min(c, d));
        }
    }

#if DEBUG
    if (params.counters != nullptr) {
        if (params.mode == 0u) {
            InterlockedAdd(params.counters[0], 1u);
        } else {
            InterlockedAdd(params.counters[1], 1u);
        }
        InterlockedAdd(params.counters[7u + params.dispatch_index], 1u);
    }
#endif

    g_rw_textures_2d[params.dst_view_index][int2(int(x), int(y))] = value;
}
