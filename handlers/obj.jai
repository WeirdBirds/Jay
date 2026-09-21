#import "Basic";
#import "File";
#import "String";
#import "Jay_Math";
#import "Jay_Render";

import :: (in_path: string) -> Mesh_Data {
    data := read_entire_file(in_path);

    positions: [..] Vec3;
    uvs:       [..] Vec2;
    normals:   [..] Vec3;

    verts: [..] Vertex;
    idxs:  [..] u32;

    lines := split(data, #char "\n");
    for lines {
        line := trim(it);
        if line.count == 0 then continue;
        if line.data[0] == #char "#" then continue;

        tokens := split(line, " ");
        if tokens.count == 0 then continue;

        kind := tokens[0];
        if kind == "v" {
            x, _ := string_to_float(tokens[1]);
            y, _ := string_to_float(tokens[2]);
            z, _ := string_to_float(tokens[3]);
            array_add(*positions, Vec3.{ z, x, y });
        } else if kind == "vt" {
            u, _ := string_to_float(tokens[1]);
            v, _ := string_to_float(tokens[2]);
            array_add(*uvs, Vec2.{ u, v });
        } else if kind == "vn" {
            x, _ := string_to_float(tokens[1]);
            y, _ := string_to_float(tokens[2]);
            z, _ := string_to_float(tokens[3]);
            array_add(*normals, Vec3.{ z, x, y });
        } else if kind == "f" {
            ref_count := tokens.count - 1;
            start_idx := verts.count;

            for i: 0 .. ref_count - 1 {
                ref := tokens[i + 1];
                parts := split(ref, "/");

                vi, _, _ := string_to_int(parts[0]);
                vi -= 1;
                pos := positions[vi];

                uv: Vec2;
                if parts.count > 1 && parts[1].count > 0 {
                    vti, _, _ := string_to_int(parts[1]);
                    vti -= 1;
                    uv = uvs[vti];
                }

                n: Vec3;
                if parts.count > 2 && parts[2].count > 0 {
                    ni, _, _ := string_to_int(parts[2]);
                    ni -= 1;
                    n = normals[ni];
                }

                vtx: Vertex;
                vtx.position = pos;
                vtx.normal   = n;
                vtx.uv       = uv;
                array_add(*verts, vtx);
            }

            if ref_count == 3 {
                array_add(*idxs, xx (start_idx));
                array_add(*idxs, xx (start_idx + 1));
                array_add(*idxs, xx (start_idx + 2));
            } else if ref_count == 4 {
                // Triangulate quad: 0-1-2 and 0-2-3
                array_add(*idxs, xx (start_idx));
                array_add(*idxs, xx (start_idx + 1));
                array_add(*idxs, xx (start_idx + 2));

                array_add(*idxs, xx (start_idx));
                array_add(*idxs, xx (start_idx + 2));
                array_add(*idxs, xx (start_idx + 3));
            }
        }
    }

    if normals.count == 0 {
        log("OBJ has no normals — generating from faces");

        accum: [..] Vec3;
        array_resize(*accum, verts.count);

        i: s64 = 0;
        while i <= idxs.count - 3 {
            i0 := idxs[i];
            i1 := idxs[i + 1];
            i2 := idxs[i + 2];

            p0 := verts[i0].position;
            p1 := verts[i1].position;
            p2 := verts[i2].position;

            n := cross(p1 - p0, p2 - p0);
            len := length(n);
            if len > 0.000001 {
                n /= len;
                accum[i0] += n;
                accum[i1] += n;
                accum[i2] += n;
            }

            i += 3;
        }

        for *vtx, idx: verts {
            len := length(accum[idx]);
            if len > 0.000001 {
                vtx.normal = accum[idx] / len;
            }
        }
    }

    if verts.count == 0 || idxs.count == 0 return .{};

    result: Mesh_Data;
    result.vertices = verts;
    result.slot_count = 1;
    result.indices[0] = idxs;
    if !validate_mesh_import(*result) {
        array_free(verts);
        array_free(idxs);
        return .{};
    }
    return result;
}
