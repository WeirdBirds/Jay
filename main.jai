#import "Basic"()(MEMORY_DEBUGGER = true);
#import "Jay_Render";
#import "Jay_Core";
#import "Random";

Demo_Scene :: struct {
    after: Jay_Render;

    
    Opaque_Material :: Material(
        vertex = "/shaders/vertex/opaque.slang",
        fragment = "/shaders/fragment/opaque.slang"
    );

    begin :: (engine: *Engine) {
        if !render.data_initialized return;

        mesh := get_asset(Mesh_Data, "/meshes/cow.obj");
        mesh_id := gpu_upload_mesh(*render.data, mesh);

        colors := Vec4.[
            .{x=0.8, y=0.3, z=0.2, w=1},
            .{x=0.3, y=0.8, z=0.2, w=1},
            .{x=0.2, y=0.3, z=0.8, w=1},
        ];

        materials: [3]Material_Id;
        for i: 0..materials.count - 1 {
            recipe: Opaque_Material;
            recipe.fragment.opaque.base_color = colors[i];
            materials[i] = upload_material(*render.data, *recipe);
        }

        group_id := new_draw_group(*render.data, mesh_id);
        for i: 0..100 {
            for j: 0..100 {
                size: float32 = xx (random_get_zero_to_one_new() + 0.1) * 0.5;
                transform := to_matrix(Transform.{
                    translation = Vec3.{xx (i - 50), xx (j - 50), xx random_get_zero_to_one_new() * 20.0},
                    rotation = to_quat(Radians.{0, 0, xx (i / (j + 1))}),
                    scale = Vec3.new(size),
                });
                new_mesh_instance(
                    *render.data,
                    group_id,
                    transform,
                    Vec4.new(get_translation(transform), size * 6.13),
                    materials[(i + j) % materials.count],
                );
            }
        }
        refresh_gpu_roots(*render.data);
        log("Assets loaded");
    }
}

main :: () {
    engine: Engine(Packages(Jay_Render, Demo_Scene));
    run(*engine);
}
