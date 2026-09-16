#import "Basic"()(MEMORY_DEBUGGER = true);
#import "Jay_Render"(DEBUG = true, RENDER_CAPTURE = true);
#import "Jay_Core";
#import "Jay_ECS";

Color_Material :: Material(
        "/shaders/vertex/opaque.slang",
        "/shaders/fragment/textured.slang",
        .TRANSLUCENT
    );

Demo_Scene :: struct {

    after: Jay_Render;

    begin :: (engine: *Engine) {

        mesh_handle := retain(Mesh_Data, Name.static("/meshes/cam.fbx"));
        mesh := get_asset(mesh_handle, Mesh_Data);

        
        Translucent_Color_Material :: Material(
            "/shaders/vertex/opaque.slang",
            "/shaders/fragment/opaque.slang",
            .TRANSLUCENT,
        );
        colored := Color_Material.{
            fragment = .{
                params = .{
                    base_color = Vec4.{1, 0.2, 0.2, 1},
                },
                albedo = Name.static("/textures/Camera_Base_color.png"),
                normal = Name.static("/textures/Camera_Normal_DirectX.png")
            }, 
        };

        translucent_colored := Translucent_Color_Material.{
            fragment = .{
                params = .{
                    base_color = Vec4.{1, 1, 1, 0.25},
                }
            }
        };


        // One mesh, one opaque material, one translucent material.

        colored_h := make_material(colored);
        material_id := get_material_id(colored_h);
        group_id := new_draw_group(*render.data, mesh.mesh_id, Color_Material.MATERIAL_INDEX, Color_Material.domain);

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

        translucent_h := make_material(translucent_colored);
        translucent_material_id := get_material_id(translucent_h);
        translucent_group_id := new_draw_group(
            *render.data, mesh.mesh_id, Translucent_Color_Material.MATERIAL_INDEX,
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
    engine: Engine(Packages(Jay_Render, Demo_Scene, Jay_ECS(Systems, test, on_test_changed)));
    run(*engine);
}

test :: () {
    new_entity(Test_Struct);
} @run_on:begin

count := 0;

on_test_changed :: (e: Entity, event: Component_Event(Test_Struct)) {
    
    log("%", event.last_value.a);
    log("%", event.new_value.a);

    if count > 5 then destroy(e);
    count += 1;
} @run_on:changed(Test_Struct)

Test_Struct :: struct {
    a: Any;
}

Systems :: struct {
    system1 :: (e: Entity, t: Test_Struct) {
        new: Test_Struct;
        new.a = Color_Material.{
            fragment = .{
                params = .{
                    base_color = Vec4.{xx count, 1, 1, 0.8},
                },
                albedo = Name.static("/textures/Camera_Base_color.png"),
                normal = Name.static("/textures/Camera_Normal_DirectX.png")
            }, 
        };
        set(e, new);
    }
}
