#import "Basic"()(MEMORY_DEBUGGER = true);
#import "Jay_Render"(DEBUG = true, RENDER_CAPTURE = true);
#import "Jay_Core";

Demo_Scene :: struct {

    after: Jay_Render;

    begin :: (engine: *Engine) {

        mesh := get_asset(Mesh_Data, "/meshes/cam.fbx");

        Color_Material :: Material(
            "/shaders/vertex/opaque.slang",
            "/shaders/fragment/opaque.slang",
        );

        Translucent_Color_Material :: Material(
            "/shaders/vertex/opaque.slang",
            "/shaders/fragment/opaque.slang",
            .TRANSLUCENT,
        );

        colored := Color_Material.{
            fragment = .{
                params = .{
                    base_color = Vec4.{1, 0, 1, 0.8},
                }
            }
        };

        translucent_colored := Translucent_Color_Material.{
            fragment = .{
                params = .{
                    base_color = Vec4.{1, 0.3, 0.2, 0.35},
                }
            }
        };

        // One mesh, one opaque material, one translucent material.

        mesh_id := gpu_upload_mesh(*render.data, mesh);
        material_id := upload_material(*render.data, colored);
        group_id := new_draw_group(*render.data, mesh_id, Color_Material.MATERIAL_INDEX, Color_Material.domain);

        transform := to_matrix(Transform.{
            translation = Vec3.new(-0.1, 2.5, -3.5),
            rotation = to_quat(Euler.{-45,-45,15}),
            scale = Vec3.new(0.02),
        });

        new_mesh_instance(
            *render.data,
            group_id,
            transform,
            Vec4.new(get_translation(transform), 1),
            material_id,
        );

        translucent_material_id := upload_material(*render.data, translucent_colored);
        translucent_group_id := new_draw_group(
            *render.data, mesh_id, Translucent_Color_Material.MATERIAL_INDEX,
            Translucent_Color_Material.domain);
        translucent_transform := to_matrix(Transform.{
            translation = Vec3.new(0.15, 2.35, -3.35),
            rotation = to_quat(Euler.{-45, -45, 15}),
            scale = Vec3.new(0.03),
        });
        new_mesh_instance(
            *render.data,
            translucent_group_id,
            translucent_transform,
            Vec4.new(get_translation(translucent_transform), 1),
            translucent_material_id,
        );
    }
}

main :: () {
    engine: Engine(Packages(Jay_Render, Demo_Scene));
    run(*engine);
}
