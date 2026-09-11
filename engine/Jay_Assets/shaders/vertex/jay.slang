#include "../common.slang"

[[vk::push_constant]]
Vertex_Data<Vertex_Params> vp;

namespace Jay {
    uint64_t material_blob(uint instance_id) {
        Vertex_Params* params = vp.get();
        return params->instances[instance_id].material;
    }
}
