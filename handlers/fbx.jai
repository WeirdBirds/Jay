
#import "Basic";
#import "File";
#import "String";
#import "Jay_Math";
#import "Jay_Render";

FBX_MAGIC :: "Kaydara FBX Binary  \0\x1a\0";

FBX_Parser :: struct {
    data:    string;
    offset:  s64;
    version: u32;
}

FBX_Node_Header :: struct {
    end_offset:       s64;
    property_count:   s64;
    property_bytes:   s64;
    name:             string;
}

FBX_Geometry :: struct {
    positions:       [..] Vec3;
    polygon_indices: [..] s32;
    normals:         [..] Vec3;
    normal_indices:  [..] s32;
    uvs:             [..] Vec2;
    uv_indices:      [..] s32;

    normal_mapping:   string;
    normal_reference: string;
    uv_mapping:       string;
    uv_reference:     string;
}

import :: (in_path: string) -> Mesh_Data {
    data := read_entire_file(in_path);

    if !is_binary_fbx(data) {
        log_error("FBX importer only supports binary FBX: %", in_path);
        return .{};
    }

    parser := FBX_Parser.{
        data    = data,
        offset  = 27,
        version = read_u32(data, 23),
    };

    vertices: [..] Vertex;
    indices:  [..] u32;

    while can_read_node_header(*parser) {
        if !parse_fbx_node(*parser, *vertices, *indices) then break;
    }

    if vertices.count == 0 || indices.count == 0 {
        log_error("FBX contains no supported mesh geometry: %", in_path);
        return .{};
    }

    generate_missing_normals(*vertices, indices);

    result: Mesh_Data;
    result.vertices = vertices;
    result.indices  = indices;
    return result;
}

is_binary_fbx :: (data: string) -> bool {
    if data.count < 27 then return false;
    for i: 0 .. FBX_MAGIC.count - 1 {
        if data[i] != FBX_MAGIC[i] then return false;
    }
    return true;
}

can_read_node_header :: (p: *FBX_Parser) -> bool {
    header_size := get_node_header_size(p.version);
    return p.offset + header_size <= p.data.count;
}

get_node_header_size :: (version: u32) -> s64 {
    if version >= 7500 then return 25;
    return 13;
}

parse_fbx_node :: (p: *FBX_Parser, vertices: *[..]Vertex, indices: *[..]u32) -> bool {
    header := read_node_header(p);
    if header.end_offset == 0 then return false;
    if header.end_offset > p.data.count {
        log_error("FBX node '%' extends past file end", header.name);
        p.offset = p.data.count;
        return false;
    }

    if header.name == "Geometry" {
        geom: FBX_Geometry;
        parse_geometry_children(p, header.end_offset, *geom);
        append_geometry_mesh(*geom, vertices, indices);
        p.offset = header.end_offset;
        return true;
    }

    skip_properties(p, header.property_count);
    while p.offset < header.end_offset {
        if !parse_fbx_node(p, vertices, indices) then break;
    }
    p.offset = header.end_offset;
    return true;
}

read_node_header :: (p: *FBX_Parser) -> FBX_Node_Header {
    h: FBX_Node_Header;

    if p.version >= 7500 {
        h.end_offset     = cast(s64) read_u64(p.data, p.offset + 0);
        h.property_count = cast(s64) read_u64(p.data, p.offset + 8);
        h.property_bytes = cast(s64) read_u64(p.data, p.offset + 16);
        name_len         := cast(s64) read_u8(p.data, p.offset + 24);
        p.offset += 25;
        h.name = read_string_slice(p.data, p.offset, name_len);
        p.offset += name_len;
    } else {
        h.end_offset     = cast(s64) read_u32(p.data, p.offset + 0);
        h.property_count = cast(s64) read_u32(p.data, p.offset + 4);
        h.property_bytes = cast(s64) read_u32(p.data, p.offset + 8);
        name_len         := cast(s64) read_u8(p.data, p.offset + 12);
        p.offset += 13;
        h.name = read_string_slice(p.data, p.offset, name_len);
        p.offset += name_len;
    }

    return h;
}

parse_geometry_children :: (p: *FBX_Parser, end_offset: s64, geom: *FBX_Geometry) {
    skip_properties(p, 0);

    while p.offset < end_offset {
        child := read_node_header(p);
        if child.end_offset == 0 then break;

        if child.name == "Vertices" {
            read_vec3_array_property(p, *geom.positions);
        } else if child.name == "PolygonVertexIndex" {
            read_s32_array_property(p, *geom.polygon_indices);
        } else if child.name == "LayerElementNormal" {
            parse_layer_element_normal(p, child.end_offset, geom);
            p.offset = child.end_offset;
            continue;
        } else if child.name == "LayerElementUV" {
            parse_layer_element_uv(p, child.end_offset, geom);
            p.offset = child.end_offset;
            continue;
        } else {
            skip_properties(p, child.property_count);
        }

        p.offset = child.end_offset;
    }
}

parse_layer_element_normal :: (p: *FBX_Parser, end_offset: s64, geom: *FBX_Geometry) {
    skip_properties(p, 1);

    while p.offset < end_offset {
        child := read_node_header(p);
        if child.end_offset == 0 then break;

        if child.name == "Normals" {
            read_vec3_array_property(p, *geom.normals);
        } else if child.name == "NormalsIndex" {
            read_s32_array_property(p, *geom.normal_indices);
        } else if child.name == "MappingInformationType" {
            geom.normal_mapping = read_first_string_property(p);
        } else if child.name == "ReferenceInformationType" {
            geom.normal_reference = read_first_string_property(p);
        } else {
            skip_properties(p, child.property_count);
        }

        p.offset = child.end_offset;
    }
}

parse_layer_element_uv :: (p: *FBX_Parser, end_offset: s64, geom: *FBX_Geometry) {
    skip_properties(p, 1);

    while p.offset < end_offset {
        child := read_node_header(p);
        if child.end_offset == 0 then break;

        if child.name == "UV" {
            read_vec2_array_property(p, *geom.uvs);
        } else if child.name == "UVIndex" {
            read_s32_array_property(p, *geom.uv_indices);
        } else if child.name == "MappingInformationType" {
            geom.uv_mapping = read_first_string_property(p);
        } else if child.name == "ReferenceInformationType" {
            geom.uv_reference = read_first_string_property(p);
        } else {
            skip_properties(p, child.property_count);
        }

        p.offset = child.end_offset;
    }
}

append_geometry_mesh :: (geom: *FBX_Geometry, vertices: *[..]Vertex, indices: *[..]u32) {
    if geom.positions.count == 0 || geom.polygon_indices.count == 0 then return;

    face: [..]u32;
    polygon_vertex: s64 = 0;

    for raw_index: geom.polygon_indices {
        source_index := raw_index;
        end_polygon := false;
        if source_index < 0 {
            source_index = -source_index - 1;
            end_polygon = true;
        }

        vertex_index := append_fbx_vertex(geom, source_index, polygon_vertex, vertices);
        array_add(*face, vertex_index);

        if end_polygon {
            triangulate_face(face, indices);
            array_resize(*face, 0);
        }

        polygon_vertex += 1;
    }
}

append_fbx_vertex :: (geom: *FBX_Geometry, position_index: s32, polygon_vertex: s64, vertices: *[..]Vertex) -> u32 {
    vtx: Vertex;
    if position_index >= 0 && position_index < geom.positions.count {
        vtx.position = geom.positions[position_index];
    }

    vtx.normal = get_mapped_normal(geom, cast(s64) position_index, polygon_vertex);
    vtx.uv     = get_mapped_uv(geom, cast(s64) position_index, polygon_vertex);

    array_add(vertices, vtx);
    return cast(u32) (vertices.count - 1);
}

triangulate_face :: (face: []u32, indices: *[..]u32) {
    if face.count < 3 then return;
    for i: 1 .. face.count - 2 {
        array_add(indices, face[0]);
        array_add(indices, face[i]);
        array_add(indices, face[i + 1]);
    }
}

get_mapped_normal :: (geom: *FBX_Geometry, vertex_index: s64, polygon_vertex: s64) -> Vec3 {
    index := get_layer_index(geom.normal_mapping, geom.normal_reference, geom.normal_indices, vertex_index, polygon_vertex);
    if index >= 0 && index < geom.normals.count then return geom.normals[index];
    return .{};
}

get_mapped_uv :: (geom: *FBX_Geometry, vertex_index: s64, polygon_vertex: s64) -> Vec2 {
    index := get_layer_index(geom.uv_mapping, geom.uv_reference, geom.uv_indices, vertex_index, polygon_vertex);
    if index >= 0 && index < geom.uvs.count then return geom.uvs[index];
    return .{};
}

get_layer_index :: (mapping: string, reference: string, indices: [..]s32, vertex_index: s64, polygon_vertex: s64) -> s64 {
    direct_index := vertex_index;
    if mapping == "ByPolygonVertex" || mapping.count == 0 then direct_index = polygon_vertex;

    if reference == "IndexToDirect" || reference == "Index" {
        if direct_index >= 0 && direct_index < indices.count then return indices[direct_index];
        return -1;
    }

    return direct_index;
}

generate_missing_normals :: (vertices: *[..]Vertex, indices: []u32) {
    needs_normals := false;
    for vtx: vertices.* {
        if length(vtx.normal) <= 0.000001 {
            needs_normals = true;
            break;
        }
    }

    if !needs_normals then return;

    accum: [..]Vec3;
    array_resize(*accum, vertices.count);

    i: s64 = 0;
    while i <= indices.count - 3 {
        i0 := indices[i];
        i1 := indices[i + 1];
        i2 := indices[i + 2];

        p0 := vertices.*[i0].position;
        p1 := vertices.*[i1].position;
        p2 := vertices.*[i2].position;

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

    for *vtx, idx: vertices.* {
        len := length(accum[idx]);
        if len > 0.000001 then vtx.normal = accum[idx] / len;
    }
}

read_vec3_array_property :: (p: *FBX_Parser, out: *[..]Vec3) {
    values: [..]float32;
    read_float_array_property(p, *values);

    i: s64 = 0;
    while i <= values.count - 3 {
        array_add(out, Vec3.{ values[i + 2], values[i + 0], values[i + 1] });
        i += 3;
    }
}

read_vec2_array_property :: (p: *FBX_Parser, out: *[..]Vec2) {
    values: [..]float32;
    read_float_array_property(p, *values);

    i: s64 = 0;
    while i <= values.count - 2 {
        array_add(out, Vec2.{ values[i + 0], values[i + 1] });
        i += 2;
    }
}

read_float_array_property :: (p: *FBX_Parser, out: *[..]float32) {
    if p.offset >= p.data.count then return;
    kind := read_u8(p.data, p.offset);
    p.offset += 1;

    if kind != #char "d" && kind != #char "f" {
        skip_property_payload(p, kind);
        return;
    }

    count := cast(s64) read_u32(p.data, p.offset + 0);
    encoding := read_u32(p.data, p.offset + 4);
    byte_count := cast(s64) read_u32(p.data, p.offset + 8);
    p.offset += 12;

    if encoding != 0 {
        log_error("Compressed FBX arrays are not supported yet");
        p.offset += byte_count;
        return;
    }

    stride: s64 = 4;
    if kind == #char "d" then stride = 8;

    for i: 0 .. count - 1 {
        item_offset := p.offset + i * stride;
        value: float32;
        if kind == #char "d" {
            value = cast(float32) read_f64(p.data, item_offset);
        } else {
            value = read_f32(p.data, item_offset);
        }
        array_add(out, value);
    }

    p.offset += byte_count;
}

read_s32_array_property :: (p: *FBX_Parser, out: *[..]s32) {
    if p.offset >= p.data.count then return;
    kind := read_u8(p.data, p.offset);
    p.offset += 1;

    if kind != #char "i" {
        skip_property_payload(p, kind);
        return;
    }

    count := cast(s64) read_u32(p.data, p.offset + 0);
    encoding := read_u32(p.data, p.offset + 4);
    byte_count := cast(s64) read_u32(p.data, p.offset + 8);
    p.offset += 12;

    if encoding != 0 {
        log_error("Compressed FBX arrays are not supported yet");
        p.offset += byte_count;
        return;
    }

    for i: 0 .. count - 1 {
        array_add(out, read_s32(p.data, p.offset + i * 4));
    }

    p.offset += byte_count;
}

read_first_string_property :: (p: *FBX_Parser) -> string {
    if p.offset >= p.data.count then return "";
    kind := read_u8(p.data, p.offset);
    p.offset += 1;

    if kind != #char "S" {
        skip_property_payload(p, kind);
        return "";
    }

    count := cast(s64) read_u32(p.data, p.offset);
    p.offset += 4;
    result := read_string_slice(p.data, p.offset, count);
    p.offset += count;
    return result;
}

skip_properties :: (p: *FBX_Parser, count: s64) {
    for 0 .. count - 1 {
        if p.offset >= p.data.count then return;
        kind := read_u8(p.data, p.offset);
        p.offset += 1;
        skip_property_payload(p, kind);
    }
}

skip_property_payload :: (p: *FBX_Parser, kind: u8) {
    if kind == #char "Y" { p.offset += 2; return; }
    if kind == #char "C" { p.offset += 1; return; }
    if kind == #char "I" { p.offset += 4; return; }
    if kind == #char "F" { p.offset += 4; return; }
    if kind == #char "D" { p.offset += 8; return; }
    if kind == #char "L" { p.offset += 8; return; }

    if kind == #char "S" || kind == #char "R" {
        count := cast(s64) read_u32(p.data, p.offset);
        p.offset += 4 + count;
        return;
    }

    if kind == #char "f" || kind == #char "d" || kind == #char "l" || kind == #char "i" || kind == #char "b" {
        byte_count := cast(s64) read_u32(p.data, p.offset + 8);
        p.offset += 12 + byte_count;
        return;
    }
}

read_string_slice :: (data: string, offset: s64, count: s64) -> string {
    return string.{ data = data.data + offset, count = count };
}

read_u8 :: (data: string, offset: s64) -> u8 {
    return cast(u8) data[offset];
}

read_u32 :: (data: string, offset: s64) -> u32 {
    return (cast(u32) read_u8(data, offset + 0)) |
           (cast(u32) read_u8(data, offset + 1) << 8) |
           (cast(u32) read_u8(data, offset + 2) << 16) |
           (cast(u32) read_u8(data, offset + 3) << 24);
}

read_u64 :: (data: string, offset: s64) -> u64 {
    lo := cast(u64) read_u32(data, offset + 0);
    hi := cast(u64) read_u32(data, offset + 4);
    return lo | (hi << 32);
}

read_s32 :: (data: string, offset: s64) -> s32 {
    return cast(s32) read_u32(data, offset);
}

read_f32 :: (data: string, offset: s64) -> float32 {
    ptr := cast(*float32) (data.data + offset);
    return ptr.*;
}

read_f64 :: (data: string, offset: s64) -> float64 {
    ptr := cast(*float64) (data.data + offset);
    return ptr.*;
}
