#include "common.slang"

namespace Jay {
    struct Params<T> { T* data;  T get() { return *data; } }
    struct Texture2D { uint* index; float4 sample(float2 uv, Sampler s) { ... g_textures_2d[*index] ... } }
    struct Sampler   { uint* index; /* resolve g_samplers[*index] */ }
}

