#import "Basic"()(MEMORY_DEBUGGER = true);
#import "Jay_Render"(DEBUG = true, RENDER_CAPTURE = true);
#import "Jay_Core";
#import "Jay_ECS";

Camera_Material :: Material(
    "/shaders/vertex/opaque.slang",
    "/shaders/fragment/textured.slang",
);

Camera_Glass_Material :: Material(
    "/shaders/vertex/opaque.slang",
    "/shaders/fragment/textured.slang",
    .TRANSLUCENT
);

Demo_Scene :: struct {

    after: Jay_Render;

    begin :: (engine: *Engine) {

        mesh_handle := retain(Mesh_Data, Name.static("/meshes/cam.fbx"));
        mesh := get_asset(mesh_handle, Mesh_Data);

        body := Camera_Material.{
            fragment = .{
                params = .{
                    base_color = Vec4.{1, 1, 1, 1},
                },
                albedo = Name.static("/textures/Camera_Base_color.png"),
                normal = Name.static("/textures/Camera_Normal_DirectX.png")
            }, 
        };
 
        glass := Camera_Glass_Material.{
            fragment = .{
                params = .{
                    base_color = Vec4.{1, 1, 1, 1},
                },
                albedo = Name.static("/textures/Lens_Roughness.png"),
                normal = Name.static("/textures/Camera_Normal_DirectX.png")
            }, 
        };

        body_h := make_material(body);
        glass_h := make_material(glass);

        material_ids: [2]Material_Id;
        material_ids[0] = get_material_id(body_h);
        material_ids[1] = get_material_id(glass_h);

        pipelines: [2]u32;
        pipelines[0] = Camera_Material.MATERIAL_INDEX;
        pipelines[1] = Camera_Glass_Material.MATERIAL_INDEX;

        domains: [2]Material_Domain;
        domains[0] = Camera_Material.domain;
        domains[1] = Camera_Glass_Material.domain;

        transform := to_matrix(Transform.{
            translation = Vec3.new(-0.1, 2.5, -3.5),
            rotation = to_quat(Euler.{-45,-45,15}),
            scale = Vec3.new(0.02),
        });

        for slot_index: 0..mesh.slot_count - 1 {
            group_id := new_draw_group(
                *render.data,
                mesh,
                slot_index,
                pipelines[slot_index],
                domains[slot_index],
            );
            new_mesh_instance(
                *render.data,
                group_id,
                transform,
                Vec4.new(get_translation(transform), 1),
                material_ids[slot_index],
            );
        }
    }
}

main :: () {
    engine: Engine(Packages(Jay_Render, Demo_Scene, Jay_ECS(Systems, Render_System_Group, test)));
    run(*engine);

    report_memory_leaks();
}

test :: () {
    
    body := Camera_Material.{
        fragment = .{
            params = .{
                base_color = Vec4.{1, 1, 1, 1},
            },
            albedo = Name.static("/textures/Camera_Base_color.png"),
            normal = Name.static("/textures/Camera_Normal_DirectX.png")
        },
    };
    // new_entity(Mesh_Component.{0, Name.static("/meshes/cam.fbx"), make_material(colored)});
} @run_on:begin

count := 1;

Systems :: struct {
    system1 :: (e: Entity, t: Mesh_Component) {
        
        glass := Camera_Glass_Material.{
            fragment = .{
                params = .{
                    base_color = Vec4.{1, 1, 1, 0.25},
                }
            }
        };

        // set(e, Mesh_Component.{count, Name.static("/meshes/cam.fbx"), make_material(colored)});

        if count > 5 then destroy(e);
        count += 1;
            
    }
}
