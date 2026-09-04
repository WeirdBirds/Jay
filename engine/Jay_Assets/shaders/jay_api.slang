#include "common.slang"

// Stage constants — JAY_STAGE is injected by the engine at compile time
// (see shader_stage_value in sgpu/shader_compiler.jai, path convention
// /shaders/vertex/ -> 0, /shaders/fragment/ -> 1, /shaders/compute/ -> 2).
#define JAY_STAGE_VERTEX   0
#define JAY_STAGE_FRAGMENT 1
#define JAY_STAGE_COMPUTE  2

#ifndef JAY_STAGE
    #error "JAY_STAGE is not defined. The engine must inject it at compile time (JAY_STAGE_VERTEX=0, JAY_STAGE_FRAGMENT=1, JAY_STAGE_COMPUTE=2)."
#endif

// Per-stage push constant — exactly one declaration per module.
// Layout matches sgpu pipeline.jai ranges: vertex 0, fragment 8, compute 16.
#if JAY_STAGE == JAY_STAGE_VERTEX
    [[vk::push_constant]]
    Vertex_Data<Vertex_Params> vp;
#elif JAY_STAGE == JAY_STAGE_FRAGMENT
    [[vk::push_constant]]
    Fragment_Data<Fragment_Params> fp;
#elif JAY_STAGE == JAY_STAGE_COMPUTE
    [[vk::push_constant]]
    Compute_Data<Draw_Params> p;
#else
    #error "JAY_STAGE has an invalid value."
#endif

// Bindless heap (set 0 — matches sgpu bindless.jai):
//   binding 0: sampled images (element index = gpu_texture_view handle)
//   binding 2: samplers       (element index = gpu_sampler handle)
[[vk::binding(0, 0)]]
Texture2D g_textures_2d[];
[[vk::binding(2, 0)]]
SamplerState g_samplers[];

#include "jay_material.slang"
