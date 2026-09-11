#include "../common.slang"

[[vk::push_constant]]
Fragment_Data<Fragment_Params> fp;

[[vk::binding(0, 0)]]
Texture2D g_textures_2d[];
[[vk::binding(2, 0)]]
SamplerState g_samplers[];

namespace Jay {
    uint64_t material_blob(uint instance_id) {
        Fragment_Params* params = fp.get();
        return params->instances[instance_id].material;
    }
}
