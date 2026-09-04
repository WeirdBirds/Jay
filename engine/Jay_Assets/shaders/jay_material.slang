namespace Jay {
    // Compile-time material declaration. It has no runtime storage or binding.
    // The caller passes its per-instance material address to get().
    struct Params<T> {
        T get(T* data) { return *data; }
    }

    struct Sampler {
        uint index;
    }

    struct Texture2D {
        uint index;
        float4 sample(float2 uv, Sampler sampler) {
            return g_textures_2d[index].Sample(g_samplers[sampler.index], uv);
        }
    }
}
