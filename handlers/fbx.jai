
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
    failed:  bool;
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

    has_material_layer: bool;
    material_mapping:   string;
    material_reference: string;
    material_indices:   [..]s32;
}

FBX_Geometry_Record :: struct {
    id: u64;
    geometry: FBX_Geometry;
}

FBX_Model :: struct {
    id: u64;
    geometry_id: u64;
    parent_id: u64;
    translation: Vec3;
    rotation: Vec3;
    scale: Vec3 = .{1, 1, 1};
    material_ids: [..]u64;
}

FBX_Connection :: struct {
    source_id: u64;
    destination_id: u64;
}

FBX_Material_Slot :: struct {
    material_id: u64;
    indices: [..]u32;
}

import :: (in_path: string) -> Mesh_Data {
    data := read_entire_file(in_path);
    defer free(data);

    if !is_binary_fbx(data) {
        log_error("FBX importer only supports binary FBX: %", in_path);
        return .{};
    }

    parser := FBX_Parser.{
        data    = data,
        offset  = 27,
        version = read_u32(data, 23),
    };

    geometries:  [..] FBX_Geometry_Record;
    models:      [..] FBX_Model;
    connections: [..] FBX_Connection;
    material_ids: [..] u64;
    defer {
        for record: geometries {
            array_free(record.geometry.positions);
            array_free(record.geometry.polygon_indices);
            array_free(record.geometry.normals);
            array_free(record.geometry.normal_indices);
            array_free(record.geometry.uvs);
            array_free(record.geometry.uv_indices);
            array_free(record.geometry.material_indices);
        }
        for model: models array_free(model.material_ids);
        array_free(geometries);
        array_free(models);
        array_free(connections);
        array_free(material_ids);
    }

    while can_read_node_header(*parser) {
        if !parse_fbx_node(*parser, *geometries, *models, *connections, *material_ids) then break;
    }
    if parser.failed return .{};

    resolve_fbx_connections(geometries, *models, connections, material_ids);

    vertices: [..]Vertex;
    slots: [..]FBX_Material_Slot;
    result: Mesh_Data;
    success := false;
    defer {
        if !success {
            array_free(vertices);
            for slot: slots array_free(slot.indices);
        }
        array_free(slots);
    }

    for *record: geometries {
        bound := false;
        for *model: models {
            if model.geometry_id != record.id continue;
            bound = true;
            if !append_geometry_mesh(*record.geometry, model, models, *vertices, *slots) return .{};
        }
        if !bound {
            if !append_geometry_mesh(*record.geometry, null, models, *vertices, *slots) return .{};
        }
    }

    if vertices.count == 0 || slots.count == 0 {
        log_error("FBX contains no supported mesh geometry: %", in_path);
        return .{};
    }
    if slots.count > result.indices.count {
        log_error("FBX has % material slots; mesh capacity is %", slots.count, result.indices.count);
        return .{};
    }
    for slot, i: slots {
        generate_missing_normals(*vertices, slot.indices);
        result.indices[i] = slot.indices;
    }

    result.vertices = vertices;
    result.slot_count = cast(u32) slots.count;
    if !validate_mesh_import(*result) return .{};
    success = true;
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

parse_fbx_node :: (p: *FBX_Parser, geometries: *[..]FBX_Geometry_Record, models: *[..]FBX_Model, connections: *[..]FBX_Connection, material_ids: *[..]u64) -> bool {
    header := read_node_header(p);
    if header.end_offset == 0 then return false;
    if header.end_offset > p.data.count {
        log_error("FBX node '%' extends past file end", header.name);
        p.offset = p.data.count;
        p.failed = true;
        return false;
    }

    if header.name == "Geometry" {
        record: FBX_Geometry_Record;
        record.id = read_u64_property(p);
        parse_geometry_children(p, header.end_offset, header.property_count - 1, *record.geometry);
        array_add(geometries, record);
        p.offset = header.end_offset;
        return true;
    }

    if header.name == "Material" {
        // Only identity is needed to merge geometry. Material properties stay in the caller.
        array_add(material_ids, read_u64_property(p));
        p.offset = header.end_offset;
        return true;
    }

    if header.name == "Model" {
        model := parse_fbx_model(p, header.end_offset, header.property_count);
        array_add(models, model);
        p.offset = header.end_offset;
        return true;
    }

    if header.name == "C" {
        connection := parse_fbx_connection(p, header.property_count);
        if connection.source_id != 0 && connection.destination_id != 0 then array_add(connections, connection);
        p.offset = header.end_offset;
        return true;
    }

    skip_properties(p, header.property_count);
    while p.offset < header.end_offset {
        if !parse_fbx_node(p, geometries, models, connections, material_ids) then break;
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

parse_fbx_model :: (p: *FBX_Parser, end_offset: s64, property_count: s64) -> FBX_Model {
    model: FBX_Model;
    model.id = read_u64_property(p);
    skip_properties(p, property_count - 1);

    while p.offset < end_offset {
        child := read_node_header(p);
        if child.end_offset == 0 then break;
        if child.name == "Properties70" {
            parse_fbx_model_properties(p, child.end_offset, child.property_count, *model);
        } else {
            skip_properties(p, child.property_count);
        }
        p.offset = child.end_offset;
    }
    return model;
}

parse_fbx_model_properties :: (p: *FBX_Parser, end_offset: s64, property_count: s64, model: *FBX_Model) {
    skip_properties(p, property_count);
    while p.offset < end_offset {
        property := read_node_header(p);
        if property.end_offset == 0 then break;
        if property.name == "P" {
            name := read_first_string_property(p);
            skip_properties(p, 3);
            if name == "Lcl Translation" {
                model.translation = read_vec3_properties(p);
            } else if name == "Lcl Rotation" {
                model.rotation = read_vec3_properties(p);
            } else if name == "Lcl Scaling" {
                model.scale = read_vec3_properties(p);
            }
        } else {
            skip_properties(p, property.property_count);
        }
        p.offset = property.end_offset;
    }
}

parse_fbx_connection :: (p: *FBX_Parser, property_count: s64) -> FBX_Connection {
    connection: FBX_Connection;
    kind := read_first_string_property(p);
    if kind != "OO" return connection;
    connection.source_id = read_u64_property(p);
    connection.destination_id = read_u64_property(p);
    skip_properties(p, property_count - 3);
    return connection;
}

resolve_fbx_connections :: (geometries: []FBX_Geometry_Record, models: *[..]FBX_Model, connections: []FBX_Connection, material_ids: []u64) {
    for connection: connections {
        if find_fbx_geometry(geometries, connection.source_id) {
            model := find_fbx_model_by_id(models.*, connection.destination_id);
            if model then model.geometry_id = connection.source_id;
        } else if array_find(material_ids, connection.source_id) {
            model := find_fbx_model_by_id(models.*, connection.destination_id);
            // Connection order defines the model-local material index table.
            if model then array_add(*model.material_ids, connection.source_id);
        } else if find_fbx_model_by_id(models.*, connection.source_id) {
            model := find_fbx_model_by_id(models.*, connection.source_id);
            model.parent_id = connection.destination_id;
        }
    }
}

find_fbx_geometry :: (geometries: []FBX_Geometry_Record, id: u64) -> bool {
    for record: geometries if record.id == id then return true;
    return false;
}

find_fbx_model_by_id :: (models: []FBX_Model, id: u64) -> *FBX_Model {
    for *model: models if model.id == id then return model;
    return null;
}

parse_geometry_children :: (p: *FBX_Parser, end_offset: s64, property_count: s64, geom: *FBX_Geometry) {
    skip_properties(p, property_count);

    while p.offset < end_offset {
        child := read_node_header(p);
        if child.end_offset == 0 then break;

        if child.name == {
            case "Vertices"; {
                read_vec3_array_property(p, *geom.positions);
            }

            case "PolygonVertexIndex"; {
                read_s32_array_property(p, *geom.polygon_indices);
            }

            case "LayerElementNormal"; {
                parse_layer_element_normal(p, child.end_offset, child.property_count, geom);
                p.offset = child.end_offset;
                continue;
            }

            case "LayerElementUV"; {
                parse_layer_element_uv(p, child.end_offset, child.property_count, geom);
                p.offset = child.end_offset;
                continue;
            }
            case "LayerElementMaterial"; {
                parse_layer_element_material(p, child.end_offset, child.property_count, geom);
            }
            case; {
                skip_properties(p, child.property_count);
            }
        } 



        p.offset = child.end_offset;
    }
}

parse_layer_element_normal :: (p: *FBX_Parser, end_offset: s64, property_count: s64, geom: *FBX_Geometry) {
    skip_properties(p, property_count);

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

parse_layer_element_uv :: (p: *FBX_Parser, end_offset: s64, property_count: s64, geom: *FBX_Geometry) {
    skip_properties(p, property_count);

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


parse_layer_element_material :: (p: *FBX_Parser, end_offset: s64, property_count: s64, geom: *FBX_Geometry) {
    if geom.has_material_layer {
        log_error("FBX has multiple material layers; only one is supported");
        p.failed = true;
        return;
    }
    geom.has_material_layer = true;
    skip_properties(p, property_count);

    while p.offset < end_offset {
        child := read_node_header(p);
        if child.end_offset == 0 then break;

        if child.name == "MappingInformationType" {
            geom.material_mapping = read_first_string_property(p);
        } else if child.name == "ReferenceInformationType" {
            geom.material_reference = read_first_string_property(p);
        } else if child.name == "Materials" {
            read_s32_array_property(p, *geom.material_indices);
        } else {
            skip_properties(p, child.property_count);
        }
        p.offset = child.end_offset;
    }
}

append_geometry_mesh :: (geom: *FBX_Geometry, model: *FBX_Model, models: []FBX_Model, vertices: *[..]Vertex, slots: *[..]FBX_Material_Slot) -> bool {
    if geom.positions.count == 0 || geom.polygon_indices.count == 0 then return true;

    polygon_count: s64;
    for index: geom.polygon_indices if index < 0 then polygon_count += 1;
    if geom.has_material_layer {
        if geom.material_reference != "IndexToDirect" && geom.material_reference != "Index" {
            log_error("FBX unsupported material reference: %", geom.material_reference);
            return false;
        }
        expected: s64;
        if geom.material_mapping == "AllSame" {
            expected = 1;
        } else if geom.material_mapping == "ByPolygon" {
            expected = polygon_count;
        } else {
            log_error("FBX unsupported material mapping: %", geom.material_mapping);
            return false;
        }
        if geom.material_indices.count != expected {
            log_error("FBX material assignment count mismatch: expected %, got %", expected, geom.material_indices.count);
            return false;
        }
    } else if model && model.material_ids.count > 1 {
        log_error("FBX model % has multiple materials but no polygon assignments", model.id);
        return false;
    }

    face: [..]u32;
    defer array_free(face);
    polygon: s64;

    for raw_index, polygon_vertex: geom.polygon_indices {
        source_index := raw_index;
        end_polygon := source_index < 0;
        if end_polygon then source_index = ~source_index;
        if source_index >= geom.positions.count {
            log_error("FBX polygon vertex % is outside the position array", source_index);
            return false;
        }

        vertex_index := append_fbx_vertex(geom, model, models, source_index, polygon_vertex, vertices);
        array_add(*face, vertex_index);
        if !end_polygon continue;
        if face.count < 3 {
            log_error("FBX polygon % has fewer than three vertices", polygon);
            return false;
        }

        material_id, valid := get_polygon_material(geom, model, polygon);
        if !valid return false;
        slot: *FBX_Material_Slot;
        for *candidate: slots.* {
            if candidate.material_id == material_id {
                slot = candidate;
                break;
            }
        }
        if !slot {
            array_add(slots, .{material_id = material_id});
            slot = *slots.*[slots.count - 1];
        }
        triangulate_face(face, *slot.indices);
        array_resize(*face, 0);
        polygon += 1;
    }

    if face.count != 0 {
        log_error("FBX polygon is missing its final vertex marker");
        return false;
    }
    return true;
}

get_polygon_material :: (geom: *FBX_Geometry, model: *FBX_Model, polygon: s64) -> (id: u64, valid: bool) {
    if !geom.has_material_layer {
        if model && model.material_ids.count == 1 return model.material_ids[0], true;
        return 0, true;
    }

    assignment := ifx geom.material_mapping == "AllSame" then 0 else polygon;
    index := geom.material_indices[assignment];
    // FBX -1 means unassigned. All unassigned polygons share one caller-owned slot.
    if index == -1 return 0, true;
    if index < -1 || !model || index >= model.material_ids.count {
        log_error("FBX polygon % references invalid model-local material index %", polygon, index);
        return 0, false;
    }
    return model.material_ids[index], true;
}

append_fbx_vertex :: (geom: *FBX_Geometry, model: *FBX_Model, models: []FBX_Model, position_index: s32, polygon_vertex: s64, vertices: *[..]Vertex) -> u32 {
    vtx: Vertex;
    if position_index >= 0 && position_index < geom.positions.count {
        vtx.position = geom.positions[position_index];
    }

    vtx.normal = get_mapped_normal(geom, cast(s64) position_index, polygon_vertex);
    vtx.uv     = get_mapped_uv(geom, cast(s64) position_index, polygon_vertex);
    if model {
        vtx.position = apply_fbx_model_transform(vtx.position, model, models);
        vtx.normal = normalize(apply_fbx_model_rotation(vtx.normal, model, models));
    }

    array_add(vertices, vtx);
    return cast(u32) (vertices.count - 1);
}

// FBX stores source positions as X/Y/Z. Geometry decoding maps those to
// Jay's X-forward/Y-right/Z-up form: source(x,y,z) -> jay(z,x,y).
// Apply model transforms in source space, then map back; models can also
// form a parent chain through OO connections.
apply_fbx_model_transform :: (point: Vec3, model: *FBX_Model, models: []FBX_Model) -> Vec3 {
    source := apply_fbx_source_transform(Vec3.{point.y, point.z, point.x}, model, models);
    return Vec3.{source.z, source.x, source.y};
}

apply_fbx_source_transform :: (point: Vec3, model: *FBX_Model, models: []FBX_Model) -> Vec3 {
    result := apply_fbx_rotation(point * model.scale, model.rotation) + model.translation;
    if model.parent_id != 0 {
        parent := find_fbx_model_by_id(models, model.parent_id);
        if parent then return apply_fbx_source_transform(result, parent, models);
    }
    return result;
}

apply_fbx_model_rotation :: (normal: Vec3, model: *FBX_Model, models: []FBX_Model) -> Vec3 {
    source := apply_fbx_source_rotation(Vec3.{normal.y, normal.z, normal.x}, model, models);
    return Vec3.{source.z, source.x, source.y};
}

apply_fbx_source_rotation :: (normal: Vec3, model: *FBX_Model, models: []FBX_Model) -> Vec3 {
    result := apply_fbx_rotation(normal, model.rotation);
    if model.parent_id != 0 {
        parent := find_fbx_model_by_id(models, model.parent_id);
        if parent then return apply_fbx_source_rotation(result, parent, models);
    }
    return result;
}

apply_fbx_rotation :: (point: Vec3, rotation: Vec3) -> Vec3 {
    // Jay's Euler convention is Rz(yaw) * Ry(-pitch) * Rx(-roll).
    // Negating FBX X/Y gives standard FBX XYZ Euler composition.
    m := to_matrix(Euler.{-rotation.x, -rotation.y, rotation.z});
    return Vec3.{
        m._11 * point.x + m._12 * point.y + m._13 * point.z,
        m._21 * point.x + m._22 * point.y + m._23 * point.z,
        m._31 * point.x + m._32 * point.y + m._33 * point.z,
    };
}

// FBX source winding is counter-clockwise after conversion to Jay's basis.
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
    defer array_free(accum);

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
        if length(vtx.normal) > 0.000001 continue;
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
        // FBX U/V uses image-space V opposite to stb_image's scanline order.
        // Preserve U; invert V. Triangle winding never changes UV indices.
        array_add(out, Vec2.{ values[i + 0], 1.0 - values[i + 1] });
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

read_u64_property :: (p: *FBX_Parser) -> u64 {
    if p.offset >= p.data.count then return 0;
    kind := read_u8(p.data, p.offset);
    p.offset += 1;
    if kind != #char "L" {
        skip_property_payload(p, kind);
        return 0;
    }
    result := read_u64(p.data, p.offset);
    p.offset += 8;
    return result;
}

read_float_property :: (p: *FBX_Parser) -> float32 {
    if p.offset >= p.data.count then return 0;
    kind := read_u8(p.data, p.offset);
    p.offset += 1;
    if kind == #char "D" {
        result := cast(float32) read_f64(p.data, p.offset);
        p.offset += 8;
        return result;
    }
    if kind == #char "F" {
        result := read_f32(p.data, p.offset);
        p.offset += 4;
        return result;
    }
    skip_property_payload(p, kind);
    return 0;
}

read_vec3_properties :: (p: *FBX_Parser) -> Vec3 {
    return .{ read_float_property(p), read_float_property(p), read_float_property(p) };
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

// NOTE: cast() is greedy in Jai — cast(u32) x << 8 parses as
// cast(u32)(x << 8), which overflows in u8 and yields 0. Parenthesize
// the cast before shifting, or every multi-byte read keeps only byte 0
// (this made version read 20 instead of 7700 and derailed all headers).
read_u32 :: (data: string, offset: s64) -> u32 {
    return (cast(u32) read_u8(data, offset + 0)) |
           ((cast(u32) read_u8(data, offset + 1)) << 8) |
           ((cast(u32) read_u8(data, offset + 2)) << 16) |
           ((cast(u32) read_u8(data, offset + 3)) << 24);
}

read_u64 :: (data: string, offset: s64) -> u64 {
    lo := cast(u64) read_u32(data, offset + 0);
    hi := cast(u64) read_u32(data, offset + 4);
    return lo | (hi << 32);
}

// PolygonVertexIndex uses negative terminators, so the u32 bits must be
// reinterpreted, not range-checked: plain cast() panics on values > S32_MAX.
read_s32 :: (data: string, offset: s64) -> s32 {
    return cast,no_check(s32) read_u32(data, offset);
}

read_f32 :: (data: string, offset: s64) -> float32 {
    ptr := cast(*float32) (data.data + offset);
    return ptr.*;
}

read_f64 :: (data: string, offset: s64) -> float64 {
    ptr := cast(*float64) (data.data + offset);
    return ptr.*;
}
