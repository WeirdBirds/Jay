#import "Basic"()(MEMORY_DEBUGGER = true);
#import "Jay_Render"(DEBUG = true, RENDER_CAPTURE = true);
#import "Jay_Core";
#import "Random";

Demo_Scene :: struct {

    after: Jay_Render;

    begin :: (engine: *Engine) {

        mesh := get_asset(Mesh_Data, "/meshes/cam.fbx");

        Textured_Material :: Material(
            "/shaders/vertex/opaque.slang",
            "/shaders/fragment/textured.slang",
        );

        textured := Textured_Material.{
            fragment = .{
                params = .{
                    base_color = Vec4.{1, 1, 1, 1},
                },
                albedo = Name.static("/textures/Camera_Base_color.png"),
                normal = Name.static("/textures/Camera_Normal_DirectX.png"),
            }
        };

        // This ugly id management is temporarily. Do not worry about it

        mesh_id := gpu_upload_mesh(*render.data, mesh);
        material_id := upload_material(*render.data, *textured);
        group_id := new_draw_group(*render.data, mesh_id, Textured_Material.MATERIAL_INDEX);

        transform := to_matrix(Transform.{
            translation = Vec3.new(-0.1, 2.5, -3.5),
            rotation = to_quat(Euler.{-45,-45,15}),
            scale = Vec3.new(0.03),
        });

        new_mesh_instance(
            *render.data,
            group_id,
            transform,
            Vec4.new(get_translation(transform), 1),
            material_id,
        );
    }
}

main :: () {
    engine: Engine(Packages(Jay_Render, Demo_Scene));
    run(*engine);
}
