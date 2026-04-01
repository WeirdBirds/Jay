//
// This file was auto-generated using the following command:
//
// jai /home/nick/Documents/Jay/engine/Jay_WASM/generate.jai
//
ptrdiff_t :: s64;




wasm_name_new :: wasm_byte_vec_new;
wasm_name_new_empty :: wasm_byte_vec_new_empty;
wasm_name_new_new_uninitialized :: wasm_byte_vec_new_uninitialized;
wasm_name_copy :: wasm_byte_vec_copy;
wasm_name_delete :: wasm_byte_vec_delete;

WASMTIME_UPDATE_DEADLINE_CONTINUE :: 0;

WASMTIME_UPDATE_DEADLINE_YIELD :: 1;

WASMTIME_EXTERN_FUNC :: 0;

WASMTIME_EXTERN_GLOBAL :: 1;

WASMTIME_EXTERN_TABLE :: 2;

WASMTIME_EXTERN_MEMORY :: 3;

WASMTIME_EXTERN_SHAREDMEMORY :: 4;

WASMTIME_I32 :: 0;

WASMTIME_I64 :: 1;

WASMTIME_F32 :: 2;

WASMTIME_F64 :: 3;

WASMTIME_V128 :: 4;

WASMTIME_FUNCREF :: 5;

WASMTIME_EXTERNREF :: 6;

WASMTIME_ANYREF :: 7;

WASMTIME_COMPONENT_VALTYPE_BOOL :: 0;

WASMTIME_COMPONENT_VALTYPE_S8 :: 1;

WASMTIME_COMPONENT_VALTYPE_S16 :: 2;

WASMTIME_COMPONENT_VALTYPE_S32 :: 3;

WASMTIME_COMPONENT_VALTYPE_S64 :: 4;

WASMTIME_COMPONENT_VALTYPE_U8 :: 5;

WASMTIME_COMPONENT_VALTYPE_U16 :: 6;

WASMTIME_COMPONENT_VALTYPE_U32 :: 7;

WASMTIME_COMPONENT_VALTYPE_U64 :: 8;

WASMTIME_COMPONENT_VALTYPE_F32 :: 9;

WASMTIME_COMPONENT_VALTYPE_F64 :: 10;

WASMTIME_COMPONENT_VALTYPE_CHAR :: 11;

WASMTIME_COMPONENT_VALTYPE_STRING :: 12;

WASMTIME_COMPONENT_VALTYPE_LIST :: 13;

WASMTIME_COMPONENT_VALTYPE_RECORD :: 14;

WASMTIME_COMPONENT_VALTYPE_TUPLE :: 15;

WASMTIME_COMPONENT_VALTYPE_VARIANT :: 16;

WASMTIME_COMPONENT_VALTYPE_ENUM :: 17;

WASMTIME_COMPONENT_VALTYPE_OPTION :: 18;

WASMTIME_COMPONENT_VALTYPE_RESULT :: 19;

WASMTIME_COMPONENT_VALTYPE_FLAGS :: 20;

WASMTIME_COMPONENT_VALTYPE_OWN :: 21;

WASMTIME_COMPONENT_VALTYPE_BORROW :: 22;

WASMTIME_COMPONENT_VALTYPE_FUTURE :: 23;

WASMTIME_COMPONENT_VALTYPE_STREAM :: 24;

WASMTIME_COMPONENT_VALTYPE_ERROR_CONTEXT :: 25;

WASMTIME_COMPONENT_ITEM_COMPONENT :: 0;

WASMTIME_COMPONENT_ITEM_COMPONENT_INSTANCE :: 1;

WASMTIME_COMPONENT_ITEM_MODULE :: 2;

WASMTIME_COMPONENT_ITEM_COMPONENT_FUNC :: 3;

WASMTIME_COMPONENT_ITEM_RESOURCE :: 4;

WASMTIME_COMPONENT_ITEM_CORE_FUNC :: 5;

WASMTIME_COMPONENT_ITEM_TYPE :: 6;

WASMTIME_COMPONENT_BOOL :: 0;

WASMTIME_COMPONENT_S8 :: 1;

WASMTIME_COMPONENT_U8 :: 2;

WASMTIME_COMPONENT_S16 :: 3;

WASMTIME_COMPONENT_U16 :: 4;

WASMTIME_COMPONENT_S32 :: 5;

WASMTIME_COMPONENT_U32 :: 6;

WASMTIME_COMPONENT_S64 :: 7;

WASMTIME_COMPONENT_U64 :: 8;

WASMTIME_COMPONENT_F32 :: 9;

WASMTIME_COMPONENT_F64 :: 10;

WASMTIME_COMPONENT_CHAR :: 11;

WASMTIME_COMPONENT_STRING :: 12;

WASMTIME_COMPONENT_LIST :: 13;

WASMTIME_COMPONENT_RECORD :: 14;

WASMTIME_COMPONENT_TUPLE :: 15;

WASMTIME_COMPONENT_VARIANT :: 16;

WASMTIME_COMPONENT_ENUM :: 17;

WASMTIME_COMPONENT_OPTION :: 18;

WASMTIME_COMPONENT_RESULT :: 19;

WASMTIME_COMPONENT_FLAGS :: 20;

WASMTIME_COMPONENT_RESOURCE :: 21;

WASMTIME_VERSION :: "42.0.1";

WASMTIME_VERSION_MAJOR :: 42;

WASMTIME_VERSION_MINOR :: 0;

WASMTIME_VERSION_PATCH :: 1;

byte_t :: u8;
float32_t :: float;
float64_t :: float64;

// Byte vectors
wasm_byte_t :: byte_t;
wasm_byte_vec_t :: struct {
    size: u64;
    data: *wasm_byte_t;
}
wasm_byte_vec_new_empty :: (out: *wasm_byte_vec_t) -> void #foreign libwasmtime;
wasm_byte_vec_new_uninitialized :: (out: *wasm_byte_vec_t, unknown0: u64) -> void #foreign libwasmtime;
wasm_byte_vec_new :: (out: *wasm_byte_vec_t, unknown0: u64, unknown1: *wasm_byte_t) -> void #foreign libwasmtime;
wasm_byte_vec_copy :: (out: *wasm_byte_vec_t, unknown0: *wasm_byte_vec_t) -> void #foreign libwasmtime;
wasm_byte_vec_delete :: (unknown0: *wasm_byte_vec_t) -> void #foreign libwasmtime;

wasm_name_t :: wasm_byte_vec_t;

wasm_config_t :: struct {}
// Configuration
wasm_config_delete :: (unknown0: *wasm_config_t) -> void #foreign libwasmtime;

// Configuration
wasm_config_new :: () -> *wasm_config_t #foreign libwasmtime;

wasm_engine_t :: struct {}
// Engine
wasm_engine_delete :: (unknown0: *wasm_engine_t) -> void #foreign libwasmtime;

// Engine
wasm_engine_new :: () -> *wasm_engine_t #foreign libwasmtime;
wasm_engine_new_with_config :: (unknown0: *wasm_config_t) -> *wasm_engine_t #foreign libwasmtime;

wasm_store_t :: struct {}
// Store
wasm_store_delete :: (unknown0: *wasm_store_t) -> void #foreign libwasmtime;

// Store
wasm_store_new :: (unknown0: *wasm_engine_t) -> *wasm_store_t #foreign libwasmtime;

// Type attributes
wasm_mutability_t :: u8;
wasm_mutability_enum :: enum u32 {
    CONST :: 0;
    VAR   :: 1;

    WASM_CONST :: CONST;
    WASM_VAR   :: VAR;
}

wasm_limits_t :: struct {
    min: u32;
    max: u32;
}

wasm_limits_max_default: u32 : 4294967295;

wasm_valtype_t :: struct {}
// Value Types
wasm_valtype_delete :: (unknown0: *wasm_valtype_t) -> void #foreign libwasmtime;
// Value Types
wasm_valtype_vec_t :: struct {
    size: u64;
    data: **wasm_valtype_t;
}
// Value Types
wasm_valtype_vec_new_empty :: (out: *wasm_valtype_vec_t) -> void #foreign libwasmtime;
// Value Types
wasm_valtype_vec_new_uninitialized :: (out: *wasm_valtype_vec_t, unknown0: u64) -> void #foreign libwasmtime;
// Value Types
wasm_valtype_vec_new :: (out: *wasm_valtype_vec_t, unknown0: u64, unknown1: **wasm_valtype_t) -> void #foreign libwasmtime;
// Value Types
wasm_valtype_vec_copy :: (out: *wasm_valtype_vec_t, unknown0: *wasm_valtype_vec_t) -> void #foreign libwasmtime;
// Value Types
wasm_valtype_vec_delete :: (unknown0: *wasm_valtype_vec_t) -> void #foreign libwasmtime;
// Value Types
wasm_valtype_copy :: (unknown0: *wasm_valtype_t) -> *wasm_valtype_t #foreign libwasmtime;

// Value Types
wasm_valkind_t :: u8;
wasm_valkind_enum :: enum u32 {
    I32       :: 0;
    I64       :: 1;
    F32       :: 2;
    F64       :: 3;
    EXTERNREF :: 128;
    FUNCREF   :: 129;

    WASM_I32       :: I32;
    WASM_I64       :: I64;
    WASM_F32       :: F32;
    WASM_F64       :: F64;
    WASM_EXTERNREF :: EXTERNREF;
    WASM_FUNCREF   :: FUNCREF;
}

wasm_valtype_new :: (unknown0: wasm_valkind_t) -> *wasm_valtype_t #foreign libwasmtime;

wasm_valtype_kind :: (unknown0: *wasm_valtype_t) -> wasm_valkind_t #foreign libwasmtime;

wasm_functype_t :: struct {}
// Function Types
wasm_functype_delete :: (unknown0: *wasm_functype_t) -> void #foreign libwasmtime;
// Function Types
wasm_functype_vec_t :: struct {
    size: u64;
    data: **wasm_functype_t;
}
// Function Types
wasm_functype_vec_new_empty :: (out: *wasm_functype_vec_t) -> void #foreign libwasmtime;
// Function Types
wasm_functype_vec_new_uninitialized :: (out: *wasm_functype_vec_t, unknown0: u64) -> void #foreign libwasmtime;
// Function Types
wasm_functype_vec_new :: (out: *wasm_functype_vec_t, unknown0: u64, unknown1: **wasm_functype_t) -> void #foreign libwasmtime;
// Function Types
wasm_functype_vec_copy :: (out: *wasm_functype_vec_t, unknown0: *wasm_functype_vec_t) -> void #foreign libwasmtime;
// Function Types
wasm_functype_vec_delete :: (unknown0: *wasm_functype_vec_t) -> void #foreign libwasmtime;
// Function Types
wasm_functype_copy :: (unknown0: *wasm_functype_t) -> *wasm_functype_t #foreign libwasmtime;

// Function Types
wasm_functype_new :: (params: *wasm_valtype_vec_t, results: *wasm_valtype_vec_t) -> *wasm_functype_t #foreign libwasmtime;

wasm_functype_params :: (unknown0: *wasm_functype_t) -> *wasm_valtype_vec_t #foreign libwasmtime;
wasm_functype_results :: (unknown0: *wasm_functype_t) -> *wasm_valtype_vec_t #foreign libwasmtime;

wasm_globaltype_t :: struct {}
// Global Types
wasm_globaltype_delete :: (unknown0: *wasm_globaltype_t) -> void #foreign libwasmtime;
// Global Types
wasm_globaltype_vec_t :: struct {
    size: u64;
    data: **wasm_globaltype_t;
}
// Global Types
wasm_globaltype_vec_new_empty :: (out: *wasm_globaltype_vec_t) -> void #foreign libwasmtime;
// Global Types
wasm_globaltype_vec_new_uninitialized :: (out: *wasm_globaltype_vec_t, unknown0: u64) -> void #foreign libwasmtime;
// Global Types
wasm_globaltype_vec_new :: (out: *wasm_globaltype_vec_t, unknown0: u64, unknown1: **wasm_globaltype_t) -> void #foreign libwasmtime;
// Global Types
wasm_globaltype_vec_copy :: (out: *wasm_globaltype_vec_t, unknown0: *wasm_globaltype_vec_t) -> void #foreign libwasmtime;
// Global Types
wasm_globaltype_vec_delete :: (unknown0: *wasm_globaltype_vec_t) -> void #foreign libwasmtime;
// Global Types
wasm_globaltype_copy :: (unknown0: *wasm_globaltype_t) -> *wasm_globaltype_t #foreign libwasmtime;

// Global Types
wasm_globaltype_new :: (unknown0: *wasm_valtype_t, unknown1: wasm_mutability_t) -> *wasm_globaltype_t #foreign libwasmtime;

wasm_globaltype_content :: (unknown0: *wasm_globaltype_t) -> *wasm_valtype_t #foreign libwasmtime;
wasm_globaltype_mutability :: (unknown0: *wasm_globaltype_t) -> wasm_mutability_t #foreign libwasmtime;

wasm_tabletype_t :: struct {}
// Table Types
wasm_tabletype_delete :: (unknown0: *wasm_tabletype_t) -> void #foreign libwasmtime;
// Table Types
wasm_tabletype_vec_t :: struct {
    size: u64;
    data: **wasm_tabletype_t;
}
// Table Types
wasm_tabletype_vec_new_empty :: (out: *wasm_tabletype_vec_t) -> void #foreign libwasmtime;
// Table Types
wasm_tabletype_vec_new_uninitialized :: (out: *wasm_tabletype_vec_t, unknown0: u64) -> void #foreign libwasmtime;
// Table Types
wasm_tabletype_vec_new :: (out: *wasm_tabletype_vec_t, unknown0: u64, unknown1: **wasm_tabletype_t) -> void #foreign libwasmtime;
// Table Types
wasm_tabletype_vec_copy :: (out: *wasm_tabletype_vec_t, unknown0: *wasm_tabletype_vec_t) -> void #foreign libwasmtime;
// Table Types
wasm_tabletype_vec_delete :: (unknown0: *wasm_tabletype_vec_t) -> void #foreign libwasmtime;
// Table Types
wasm_tabletype_copy :: (unknown0: *wasm_tabletype_t) -> *wasm_tabletype_t #foreign libwasmtime;

// Table Types
wasm_tabletype_new :: (unknown0: *wasm_valtype_t, unknown1: *wasm_limits_t) -> *wasm_tabletype_t #foreign libwasmtime;

wasm_tabletype_element :: (unknown0: *wasm_tabletype_t) -> *wasm_valtype_t #foreign libwasmtime;
wasm_tabletype_limits :: (unknown0: *wasm_tabletype_t) -> *wasm_limits_t #foreign libwasmtime;

wasm_memorytype_t :: struct {}
// Memory Types
wasm_memorytype_delete :: (unknown0: *wasm_memorytype_t) -> void #foreign libwasmtime;
// Memory Types
wasm_memorytype_vec_t :: struct {
    size: u64;
    data: **wasm_memorytype_t;
}
// Memory Types
wasm_memorytype_vec_new_empty :: (out: *wasm_memorytype_vec_t) -> void #foreign libwasmtime;
// Memory Types
wasm_memorytype_vec_new_uninitialized :: (out: *wasm_memorytype_vec_t, unknown0: u64) -> void #foreign libwasmtime;
// Memory Types
wasm_memorytype_vec_new :: (out: *wasm_memorytype_vec_t, unknown0: u64, unknown1: **wasm_memorytype_t) -> void #foreign libwasmtime;
// Memory Types
wasm_memorytype_vec_copy :: (out: *wasm_memorytype_vec_t, unknown0: *wasm_memorytype_vec_t) -> void #foreign libwasmtime;
// Memory Types
wasm_memorytype_vec_delete :: (unknown0: *wasm_memorytype_vec_t) -> void #foreign libwasmtime;
// Memory Types
wasm_memorytype_copy :: (unknown0: *wasm_memorytype_t) -> *wasm_memorytype_t #foreign libwasmtime;

// Memory Types
wasm_memorytype_new :: (unknown0: *wasm_limits_t) -> *wasm_memorytype_t #foreign libwasmtime;

wasm_memorytype_limits :: (unknown0: *wasm_memorytype_t) -> *wasm_limits_t #foreign libwasmtime;

wasm_externtype_t :: struct {}
// Extern Types
wasm_externtype_delete :: (unknown0: *wasm_externtype_t) -> void #foreign libwasmtime;
// Extern Types
wasm_externtype_vec_t :: struct {
    size: u64;
    data: **wasm_externtype_t;
}
// Extern Types
wasm_externtype_vec_new_empty :: (out: *wasm_externtype_vec_t) -> void #foreign libwasmtime;
// Extern Types
wasm_externtype_vec_new_uninitialized :: (out: *wasm_externtype_vec_t, unknown0: u64) -> void #foreign libwasmtime;
// Extern Types
wasm_externtype_vec_new :: (out: *wasm_externtype_vec_t, unknown0: u64, unknown1: **wasm_externtype_t) -> void #foreign libwasmtime;
// Extern Types
wasm_externtype_vec_copy :: (out: *wasm_externtype_vec_t, unknown0: *wasm_externtype_vec_t) -> void #foreign libwasmtime;
// Extern Types
wasm_externtype_vec_delete :: (unknown0: *wasm_externtype_vec_t) -> void #foreign libwasmtime;
// Extern Types
wasm_externtype_copy :: (unknown0: *wasm_externtype_t) -> *wasm_externtype_t #foreign libwasmtime;

// Extern Types
wasm_externkind_t :: u8;
wasm_externkind_enum :: enum u32 {
    FUNC   :: 0;
    GLOBAL :: 1;
    TABLE  :: 2;
    MEMORY :: 3;

    WASM_EXTERN_FUNC   :: FUNC;
    WASM_EXTERN_GLOBAL :: GLOBAL;
    WASM_EXTERN_TABLE  :: TABLE;
    WASM_EXTERN_MEMORY :: MEMORY;
}

wasm_externtype_kind :: (unknown0: *wasm_externtype_t) -> wasm_externkind_t #foreign libwasmtime;

wasm_functype_as_externtype :: (unknown0: *wasm_functype_t) -> *wasm_externtype_t #foreign libwasmtime;
wasm_globaltype_as_externtype :: (unknown0: *wasm_globaltype_t) -> *wasm_externtype_t #foreign libwasmtime;
wasm_tabletype_as_externtype :: (unknown0: *wasm_tabletype_t) -> *wasm_externtype_t #foreign libwasmtime;
wasm_memorytype_as_externtype :: (unknown0: *wasm_memorytype_t) -> *wasm_externtype_t #foreign libwasmtime;

wasm_externtype_as_functype :: (unknown0: *wasm_externtype_t) -> *wasm_functype_t #foreign libwasmtime;
wasm_externtype_as_globaltype :: (unknown0: *wasm_externtype_t) -> *wasm_globaltype_t #foreign libwasmtime;
wasm_externtype_as_tabletype :: (unknown0: *wasm_externtype_t) -> *wasm_tabletype_t #foreign libwasmtime;
wasm_externtype_as_memorytype :: (unknown0: *wasm_externtype_t) -> *wasm_memorytype_t #foreign libwasmtime;

wasm_functype_as_externtype_const :: (unknown0: *wasm_functype_t) -> *wasm_externtype_t #foreign libwasmtime;
wasm_globaltype_as_externtype_const :: (unknown0: *wasm_globaltype_t) -> *wasm_externtype_t #foreign libwasmtime;
wasm_tabletype_as_externtype_const :: (unknown0: *wasm_tabletype_t) -> *wasm_externtype_t #foreign libwasmtime;
wasm_memorytype_as_externtype_const :: (unknown0: *wasm_memorytype_t) -> *wasm_externtype_t #foreign libwasmtime;

wasm_externtype_as_functype_const :: (unknown0: *wasm_externtype_t) -> *wasm_functype_t #foreign libwasmtime;
wasm_externtype_as_globaltype_const :: (unknown0: *wasm_externtype_t) -> *wasm_globaltype_t #foreign libwasmtime;
wasm_externtype_as_tabletype_const :: (unknown0: *wasm_externtype_t) -> *wasm_tabletype_t #foreign libwasmtime;
wasm_externtype_as_memorytype_const :: (unknown0: *wasm_externtype_t) -> *wasm_memorytype_t #foreign libwasmtime;

wasm_importtype_t :: struct {}
// Import Types
wasm_importtype_delete :: (unknown0: *wasm_importtype_t) -> void #foreign libwasmtime;
// Import Types
wasm_importtype_vec_t :: struct {
    size: u64;
    data: **wasm_importtype_t;
}
// Import Types
wasm_importtype_vec_new_empty :: (out: *wasm_importtype_vec_t) -> void #foreign libwasmtime;
// Import Types
wasm_importtype_vec_new_uninitialized :: (out: *wasm_importtype_vec_t, unknown0: u64) -> void #foreign libwasmtime;
// Import Types
wasm_importtype_vec_new :: (out: *wasm_importtype_vec_t, unknown0: u64, unknown1: **wasm_importtype_t) -> void #foreign libwasmtime;
// Import Types
wasm_importtype_vec_copy :: (out: *wasm_importtype_vec_t, unknown0: *wasm_importtype_vec_t) -> void #foreign libwasmtime;
// Import Types
wasm_importtype_vec_delete :: (unknown0: *wasm_importtype_vec_t) -> void #foreign libwasmtime;
// Import Types
wasm_importtype_copy :: (unknown0: *wasm_importtype_t) -> *wasm_importtype_t #foreign libwasmtime;

// Import Types
wasm_importtype_new :: (module: *wasm_name_t, name: *wasm_name_t, unknown0: *wasm_externtype_t) -> *wasm_importtype_t #foreign libwasmtime;

wasm_importtype_module :: (unknown0: *wasm_importtype_t) -> *wasm_name_t #foreign libwasmtime;
wasm_importtype_name :: (unknown0: *wasm_importtype_t) -> *wasm_name_t #foreign libwasmtime;
wasm_importtype_type :: (unknown0: *wasm_importtype_t) -> *wasm_externtype_t #foreign libwasmtime;

wasm_exporttype_t :: struct {}
// Export Types
wasm_exporttype_delete :: (unknown0: *wasm_exporttype_t) -> void #foreign libwasmtime;
// Export Types
wasm_exporttype_vec_t :: struct {
    size: u64;
    data: **wasm_exporttype_t;
}
// Export Types
wasm_exporttype_vec_new_empty :: (out: *wasm_exporttype_vec_t) -> void #foreign libwasmtime;
// Export Types
wasm_exporttype_vec_new_uninitialized :: (out: *wasm_exporttype_vec_t, unknown0: u64) -> void #foreign libwasmtime;
// Export Types
wasm_exporttype_vec_new :: (out: *wasm_exporttype_vec_t, unknown0: u64, unknown1: **wasm_exporttype_t) -> void #foreign libwasmtime;
// Export Types
wasm_exporttype_vec_copy :: (out: *wasm_exporttype_vec_t, unknown0: *wasm_exporttype_vec_t) -> void #foreign libwasmtime;
// Export Types
wasm_exporttype_vec_delete :: (unknown0: *wasm_exporttype_vec_t) -> void #foreign libwasmtime;
// Export Types
wasm_exporttype_copy :: (unknown0: *wasm_exporttype_t) -> *wasm_exporttype_t #foreign libwasmtime;

// Export Types
wasm_exporttype_new :: (unknown0: *wasm_name_t, unknown1: *wasm_externtype_t) -> *wasm_exporttype_t #foreign libwasmtime;

wasm_exporttype_name :: (unknown0: *wasm_exporttype_t) -> *wasm_name_t #foreign libwasmtime;
wasm_exporttype_type :: (unknown0: *wasm_exporttype_t) -> *wasm_externtype_t #foreign libwasmtime;

// Values
wasm_ref_t :: struct {}

wasm_val_t :: struct {
    kind: wasm_valkind_t;
    of:   union {
        i32: s32;
        i64: s64;
        f32: float32_t;
        f64: float64_t;
        ref: *wasm_ref_t;
    };
}

wasm_val_delete :: (v: *wasm_val_t) -> void #foreign libwasmtime;
wasm_val_copy :: (out: *wasm_val_t, unknown0: *wasm_val_t) -> void #foreign libwasmtime;

wasm_val_vec_t :: struct {
    size: u64;
    data: *wasm_val_t;
}
wasm_val_vec_new_empty :: (out: *wasm_val_vec_t) -> void #foreign libwasmtime;
wasm_val_vec_new_uninitialized :: (out: *wasm_val_vec_t, unknown0: u64) -> void #foreign libwasmtime;
wasm_val_vec_new :: (out: *wasm_val_vec_t, unknown0: u64, unknown1: *wasm_val_t) -> void #foreign libwasmtime;
wasm_val_vec_copy :: (out: *wasm_val_vec_t, unknown0: *wasm_val_vec_t) -> void #foreign libwasmtime;
wasm_val_vec_delete :: (unknown0: *wasm_val_vec_t) -> void #foreign libwasmtime;

wasm_ref_delete :: (unknown0: *wasm_ref_t) -> void #foreign libwasmtime;
wasm_ref_copy :: (unknown0: *wasm_ref_t) -> *wasm_ref_t #foreign libwasmtime;
wasm_ref_same :: (unknown0: *wasm_ref_t, unknown1: *wasm_ref_t) -> bool #foreign libwasmtime;
wasm_ref_get_host_info :: (unknown0: *wasm_ref_t) -> *void #foreign libwasmtime;
wasm_ref_set_host_info :: (unknown0: *wasm_ref_t, unknown1: *void) -> void #foreign libwasmtime;
wasm_ref_set_host_info_with_finalizer :: (unknown0: *wasm_ref_t, unknown1: *void, unknown2: #type (unknown0: *void) -> void #c_call) -> void #foreign libwasmtime;

wasm_frame_t :: struct {}
// Frames
wasm_frame_delete :: (unknown0: *wasm_frame_t) -> void #foreign libwasmtime;
// Frames
wasm_frame_vec_t :: struct {
    size: u64;
    data: **wasm_frame_t;
}
// Frames
wasm_frame_vec_new_empty :: (out: *wasm_frame_vec_t) -> void #foreign libwasmtime;
// Frames
wasm_frame_vec_new_uninitialized :: (out: *wasm_frame_vec_t, unknown0: u64) -> void #foreign libwasmtime;
// Frames
wasm_frame_vec_new :: (out: *wasm_frame_vec_t, unknown0: u64, unknown1: **wasm_frame_t) -> void #foreign libwasmtime;
// Frames
wasm_frame_vec_copy :: (out: *wasm_frame_vec_t, unknown0: *wasm_frame_vec_t) -> void #foreign libwasmtime;
// Frames
wasm_frame_vec_delete :: (unknown0: *wasm_frame_vec_t) -> void #foreign libwasmtime;
// Frames
wasm_frame_copy :: (unknown0: *wasm_frame_t) -> *wasm_frame_t #foreign libwasmtime;

wasm_instance_t :: struct {}
wasm_frame_instance :: (unknown0: *wasm_frame_t) -> *wasm_instance_t #foreign libwasmtime;
wasm_frame_func_index :: (unknown0: *wasm_frame_t) -> u32 #foreign libwasmtime;
wasm_frame_func_offset :: (unknown0: *wasm_frame_t) -> u64 #foreign libwasmtime;
wasm_frame_module_offset :: (unknown0: *wasm_frame_t) -> u64 #foreign libwasmtime;

// Traps
wasm_message_t :: wasm_name_t;

wasm_trap_t :: struct {}
wasm_trap_delete :: (unknown0: *wasm_trap_t) -> void #foreign libwasmtime;
wasm_trap_copy :: (unknown0: *wasm_trap_t) -> *wasm_trap_t #foreign libwasmtime;
wasm_trap_same :: (unknown0: *wasm_trap_t, unknown1: *wasm_trap_t) -> bool #foreign libwasmtime;
wasm_trap_get_host_info :: (unknown0: *wasm_trap_t) -> *void #foreign libwasmtime;
wasm_trap_set_host_info :: (unknown0: *wasm_trap_t, unknown1: *void) -> void #foreign libwasmtime;
wasm_trap_set_host_info_with_finalizer :: (unknown0: *wasm_trap_t, unknown1: *void, unknown2: #type (unknown0: *void) -> void #c_call) -> void #foreign libwasmtime;
wasm_trap_as_ref :: (unknown0: *wasm_trap_t) -> *wasm_ref_t #foreign libwasmtime;
wasm_ref_as_trap :: (unknown0: *wasm_ref_t) -> *wasm_trap_t #foreign libwasmtime;
wasm_trap_as_ref_const :: (unknown0: *wasm_trap_t) -> *wasm_ref_t #foreign libwasmtime;
wasm_ref_as_trap_const :: (unknown0: *wasm_ref_t) -> *wasm_trap_t #foreign libwasmtime;

wasm_trap_new :: (store: *wasm_store_t, unknown0: *wasm_message_t) -> *wasm_trap_t #foreign libwasmtime;

wasm_trap_message :: (unknown0: *wasm_trap_t, out: *wasm_message_t) -> void #foreign libwasmtime;
wasm_trap_origin :: (unknown0: *wasm_trap_t) -> *wasm_frame_t #foreign libwasmtime;
wasm_trap_trace :: (unknown0: *wasm_trap_t, out: *wasm_frame_vec_t) -> void #foreign libwasmtime;

wasm_foreign_t :: struct {}
// Foreign Objects
wasm_foreign_delete :: (unknown0: *wasm_foreign_t) -> void #foreign libwasmtime;
// Foreign Objects
wasm_foreign_copy :: (unknown0: *wasm_foreign_t) -> *wasm_foreign_t #foreign libwasmtime;
// Foreign Objects
wasm_foreign_same :: (unknown0: *wasm_foreign_t, unknown1: *wasm_foreign_t) -> bool #foreign libwasmtime;
// Foreign Objects
wasm_foreign_get_host_info :: (unknown0: *wasm_foreign_t) -> *void #foreign libwasmtime;
// Foreign Objects
wasm_foreign_set_host_info :: (unknown0: *wasm_foreign_t, unknown1: *void) -> void #foreign libwasmtime;
// Foreign Objects
wasm_foreign_set_host_info_with_finalizer :: (unknown0: *wasm_foreign_t, unknown1: *void, unknown2: #type (unknown0: *void) -> void #c_call) -> void #foreign libwasmtime;
// Foreign Objects
wasm_foreign_as_ref :: (unknown0: *wasm_foreign_t) -> *wasm_ref_t #foreign libwasmtime;
// Foreign Objects
wasm_ref_as_foreign :: (unknown0: *wasm_ref_t) -> *wasm_foreign_t #foreign libwasmtime;
// Foreign Objects
wasm_foreign_as_ref_const :: (unknown0: *wasm_foreign_t) -> *wasm_ref_t #foreign libwasmtime;
// Foreign Objects
wasm_ref_as_foreign_const :: (unknown0: *wasm_ref_t) -> *wasm_foreign_t #foreign libwasmtime;

// Foreign Objects
wasm_foreign_new :: (unknown0: *wasm_store_t) -> *wasm_foreign_t #foreign libwasmtime;

wasm_module_t :: struct {}
// Modules
wasm_module_delete :: (unknown0: *wasm_module_t) -> void #foreign libwasmtime;
// Modules
wasm_module_copy :: (unknown0: *wasm_module_t) -> *wasm_module_t #foreign libwasmtime;
// Modules
wasm_module_same :: (unknown0: *wasm_module_t, unknown1: *wasm_module_t) -> bool #foreign libwasmtime;
// Modules
wasm_module_get_host_info :: (unknown0: *wasm_module_t) -> *void #foreign libwasmtime;
// Modules
wasm_module_set_host_info :: (unknown0: *wasm_module_t, unknown1: *void) -> void #foreign libwasmtime;
// Modules
wasm_module_set_host_info_with_finalizer :: (unknown0: *wasm_module_t, unknown1: *void, unknown2: #type (unknown0: *void) -> void #c_call) -> void #foreign libwasmtime;
// Modules
wasm_module_as_ref :: (unknown0: *wasm_module_t) -> *wasm_ref_t #foreign libwasmtime;
// Modules
wasm_ref_as_module :: (unknown0: *wasm_ref_t) -> *wasm_module_t #foreign libwasmtime;
// Modules
wasm_module_as_ref_const :: (unknown0: *wasm_module_t) -> *wasm_ref_t #foreign libwasmtime;
// Modules
wasm_ref_as_module_const :: (unknown0: *wasm_ref_t) -> *wasm_module_t #foreign libwasmtime;
wasm_shared_module_t :: struct {}
// Modules
wasm_shared_module_delete :: (unknown0: *wasm_shared_module_t) -> void #foreign libwasmtime;
// Modules
wasm_module_share :: (unknown0: *wasm_module_t) -> *wasm_shared_module_t #foreign libwasmtime;
// Modules
wasm_module_obtain :: (unknown0: *wasm_store_t, unknown1: *wasm_shared_module_t) -> *wasm_module_t #foreign libwasmtime;

// Modules
wasm_module_new :: (unknown0: *wasm_store_t, binary: *wasm_byte_vec_t) -> *wasm_module_t #foreign libwasmtime;

wasm_module_validate :: (unknown0: *wasm_store_t, binary: *wasm_byte_vec_t) -> bool #foreign libwasmtime;

wasm_module_imports :: (unknown0: *wasm_module_t, out: *wasm_importtype_vec_t) -> void #foreign libwasmtime;
wasm_module_exports :: (unknown0: *wasm_module_t, out: *wasm_exporttype_vec_t) -> void #foreign libwasmtime;

wasm_module_serialize :: (unknown0: *wasm_module_t, out: *wasm_byte_vec_t) -> void #foreign libwasmtime;
wasm_module_deserialize :: (unknown0: *wasm_store_t, unknown1: *wasm_byte_vec_t) -> *wasm_module_t #foreign libwasmtime;

wasm_func_t :: struct {}
// Function Instances
wasm_func_delete :: (unknown0: *wasm_func_t) -> void #foreign libwasmtime;
// Function Instances
wasm_func_copy :: (unknown0: *wasm_func_t) -> *wasm_func_t #foreign libwasmtime;
// Function Instances
wasm_func_same :: (unknown0: *wasm_func_t, unknown1: *wasm_func_t) -> bool #foreign libwasmtime;
// Function Instances
wasm_func_get_host_info :: (unknown0: *wasm_func_t) -> *void #foreign libwasmtime;
// Function Instances
wasm_func_set_host_info :: (unknown0: *wasm_func_t, unknown1: *void) -> void #foreign libwasmtime;
// Function Instances
wasm_func_set_host_info_with_finalizer :: (unknown0: *wasm_func_t, unknown1: *void, unknown2: #type (unknown0: *void) -> void #c_call) -> void #foreign libwasmtime;
// Function Instances
wasm_func_as_ref :: (unknown0: *wasm_func_t) -> *wasm_ref_t #foreign libwasmtime;
// Function Instances
wasm_ref_as_func :: (unknown0: *wasm_ref_t) -> *wasm_func_t #foreign libwasmtime;
// Function Instances
wasm_func_as_ref_const :: (unknown0: *wasm_func_t) -> *wasm_ref_t #foreign libwasmtime;
// Function Instances
wasm_ref_as_func_const :: (unknown0: *wasm_ref_t) -> *wasm_func_t #foreign libwasmtime;

// Function Instances
wasm_func_callback_t :: #type (args: *wasm_val_vec_t, results: *wasm_val_vec_t) -> *wasm_trap_t #c_call;

wasm_func_callback_with_env_t :: #type (env: *void, args: *wasm_val_vec_t, results: *wasm_val_vec_t) -> *wasm_trap_t #c_call;

wasm_func_new :: (unknown0: *wasm_store_t, unknown1: *wasm_functype_t, unknown2: wasm_func_callback_t) -> *wasm_func_t #foreign libwasmtime;

wasm_func_new_with_env :: (unknown0: *wasm_store_t, type: *wasm_functype_t, unknown1: wasm_func_callback_with_env_t, env: *void, finalizer: #type (unknown0: *void) -> void #c_call) -> *wasm_func_t #foreign libwasmtime;

wasm_func_type :: (unknown0: *wasm_func_t) -> *wasm_functype_t #foreign libwasmtime;
wasm_func_param_arity :: (unknown0: *wasm_func_t) -> u64 #foreign libwasmtime;
wasm_func_result_arity :: (unknown0: *wasm_func_t) -> u64 #foreign libwasmtime;

wasm_func_call :: (unknown0: *wasm_func_t, args: *wasm_val_vec_t, results: *wasm_val_vec_t) -> *wasm_trap_t #foreign libwasmtime;

wasm_global_t :: struct {}
// Global Instances
wasm_global_delete :: (unknown0: *wasm_global_t) -> void #foreign libwasmtime;
// Global Instances
wasm_global_copy :: (unknown0: *wasm_global_t) -> *wasm_global_t #foreign libwasmtime;
// Global Instances
wasm_global_same :: (unknown0: *wasm_global_t, unknown1: *wasm_global_t) -> bool #foreign libwasmtime;
// Global Instances
wasm_global_get_host_info :: (unknown0: *wasm_global_t) -> *void #foreign libwasmtime;
// Global Instances
wasm_global_set_host_info :: (unknown0: *wasm_global_t, unknown1: *void) -> void #foreign libwasmtime;
// Global Instances
wasm_global_set_host_info_with_finalizer :: (unknown0: *wasm_global_t, unknown1: *void, unknown2: #type (unknown0: *void) -> void #c_call) -> void #foreign libwasmtime;
// Global Instances
wasm_global_as_ref :: (unknown0: *wasm_global_t) -> *wasm_ref_t #foreign libwasmtime;
// Global Instances
wasm_ref_as_global :: (unknown0: *wasm_ref_t) -> *wasm_global_t #foreign libwasmtime;
// Global Instances
wasm_global_as_ref_const :: (unknown0: *wasm_global_t) -> *wasm_ref_t #foreign libwasmtime;
// Global Instances
wasm_ref_as_global_const :: (unknown0: *wasm_ref_t) -> *wasm_global_t #foreign libwasmtime;

// Global Instances
wasm_global_new :: (unknown0: *wasm_store_t, unknown1: *wasm_globaltype_t, unknown2: *wasm_val_t) -> *wasm_global_t #foreign libwasmtime;

wasm_global_type :: (unknown0: *wasm_global_t) -> *wasm_globaltype_t #foreign libwasmtime;

wasm_global_get :: (unknown0: *wasm_global_t, out: *wasm_val_t) -> void #foreign libwasmtime;
wasm_global_set :: (unknown0: *wasm_global_t, unknown1: *wasm_val_t) -> void #foreign libwasmtime;

wasm_table_t :: struct {}
// Table Instances
wasm_table_delete :: (unknown0: *wasm_table_t) -> void #foreign libwasmtime;
// Table Instances
wasm_table_copy :: (unknown0: *wasm_table_t) -> *wasm_table_t #foreign libwasmtime;
// Table Instances
wasm_table_same :: (unknown0: *wasm_table_t, unknown1: *wasm_table_t) -> bool #foreign libwasmtime;
// Table Instances
wasm_table_get_host_info :: (unknown0: *wasm_table_t) -> *void #foreign libwasmtime;
// Table Instances
wasm_table_set_host_info :: (unknown0: *wasm_table_t, unknown1: *void) -> void #foreign libwasmtime;
// Table Instances
wasm_table_set_host_info_with_finalizer :: (unknown0: *wasm_table_t, unknown1: *void, unknown2: #type (unknown0: *void) -> void #c_call) -> void #foreign libwasmtime;
// Table Instances
wasm_table_as_ref :: (unknown0: *wasm_table_t) -> *wasm_ref_t #foreign libwasmtime;
// Table Instances
wasm_ref_as_table :: (unknown0: *wasm_ref_t) -> *wasm_table_t #foreign libwasmtime;
// Table Instances
wasm_table_as_ref_const :: (unknown0: *wasm_table_t) -> *wasm_ref_t #foreign libwasmtime;
// Table Instances
wasm_ref_as_table_const :: (unknown0: *wasm_ref_t) -> *wasm_table_t #foreign libwasmtime;

// Table Instances
wasm_table_size_t :: u32;

wasm_table_new :: (unknown0: *wasm_store_t, unknown1: *wasm_tabletype_t, init: *wasm_ref_t) -> *wasm_table_t #foreign libwasmtime;

wasm_table_type :: (unknown0: *wasm_table_t) -> *wasm_tabletype_t #foreign libwasmtime;

wasm_table_get :: (unknown0: *wasm_table_t, index: wasm_table_size_t) -> *wasm_ref_t #foreign libwasmtime;
wasm_table_set :: (unknown0: *wasm_table_t, index: wasm_table_size_t, unknown1: *wasm_ref_t) -> bool #foreign libwasmtime;

wasm_table_size :: (unknown0: *wasm_table_t) -> wasm_table_size_t #foreign libwasmtime;
wasm_table_grow :: (unknown0: *wasm_table_t, delta: wasm_table_size_t, init: *wasm_ref_t) -> bool #foreign libwasmtime;

wasm_memory_t :: struct {}
// Memory Instances
wasm_memory_delete :: (unknown0: *wasm_memory_t) -> void #foreign libwasmtime;
// Memory Instances
wasm_memory_copy :: (unknown0: *wasm_memory_t) -> *wasm_memory_t #foreign libwasmtime;
// Memory Instances
wasm_memory_same :: (unknown0: *wasm_memory_t, unknown1: *wasm_memory_t) -> bool #foreign libwasmtime;
// Memory Instances
wasm_memory_get_host_info :: (unknown0: *wasm_memory_t) -> *void #foreign libwasmtime;
// Memory Instances
wasm_memory_set_host_info :: (unknown0: *wasm_memory_t, unknown1: *void) -> void #foreign libwasmtime;
// Memory Instances
wasm_memory_set_host_info_with_finalizer :: (unknown0: *wasm_memory_t, unknown1: *void, unknown2: #type (unknown0: *void) -> void #c_call) -> void #foreign libwasmtime;
// Memory Instances
wasm_memory_as_ref :: (unknown0: *wasm_memory_t) -> *wasm_ref_t #foreign libwasmtime;
// Memory Instances
wasm_ref_as_memory :: (unknown0: *wasm_ref_t) -> *wasm_memory_t #foreign libwasmtime;
// Memory Instances
wasm_memory_as_ref_const :: (unknown0: *wasm_memory_t) -> *wasm_ref_t #foreign libwasmtime;
// Memory Instances
wasm_ref_as_memory_const :: (unknown0: *wasm_ref_t) -> *wasm_memory_t #foreign libwasmtime;

// Memory Instances
wasm_memory_pages_t :: u32;

MEMORY_PAGE_SIZE: u64 : 65536;

wasm_memory_new :: (unknown0: *wasm_store_t, unknown1: *wasm_memorytype_t) -> *wasm_memory_t #foreign libwasmtime;

wasm_memory_type :: (unknown0: *wasm_memory_t) -> *wasm_memorytype_t #foreign libwasmtime;

wasm_memory_data :: (unknown0: *wasm_memory_t) -> *byte_t #foreign libwasmtime;
wasm_memory_data_size :: (unknown0: *wasm_memory_t) -> u64 #foreign libwasmtime;

wasm_memory_size :: (unknown0: *wasm_memory_t) -> wasm_memory_pages_t #foreign libwasmtime;
wasm_memory_grow :: (unknown0: *wasm_memory_t, delta: wasm_memory_pages_t) -> bool #foreign libwasmtime;

wasm_extern_t :: struct {}
// Externals
wasm_extern_delete :: (unknown0: *wasm_extern_t) -> void #foreign libwasmtime;
// Externals
wasm_extern_copy :: (unknown0: *wasm_extern_t) -> *wasm_extern_t #foreign libwasmtime;
// Externals
wasm_extern_same :: (unknown0: *wasm_extern_t, unknown1: *wasm_extern_t) -> bool #foreign libwasmtime;
// Externals
wasm_extern_get_host_info :: (unknown0: *wasm_extern_t) -> *void #foreign libwasmtime;
// Externals
wasm_extern_set_host_info :: (unknown0: *wasm_extern_t, unknown1: *void) -> void #foreign libwasmtime;
// Externals
wasm_extern_set_host_info_with_finalizer :: (unknown0: *wasm_extern_t, unknown1: *void, unknown2: #type (unknown0: *void) -> void #c_call) -> void #foreign libwasmtime;
// Externals
wasm_extern_as_ref :: (unknown0: *wasm_extern_t) -> *wasm_ref_t #foreign libwasmtime;
// Externals
wasm_ref_as_extern :: (unknown0: *wasm_ref_t) -> *wasm_extern_t #foreign libwasmtime;
// Externals
wasm_extern_as_ref_const :: (unknown0: *wasm_extern_t) -> *wasm_ref_t #foreign libwasmtime;
// Externals
wasm_ref_as_extern_const :: (unknown0: *wasm_ref_t) -> *wasm_extern_t #foreign libwasmtime;
// Externals
wasm_extern_vec_t :: struct {
    size: u64;
    data: **wasm_extern_t;
}
// Externals
wasm_extern_vec_new_empty :: (out: *wasm_extern_vec_t) -> void #foreign libwasmtime;
// Externals
wasm_extern_vec_new_uninitialized :: (out: *wasm_extern_vec_t, unknown0: u64) -> void #foreign libwasmtime;
// Externals
wasm_extern_vec_new :: (out: *wasm_extern_vec_t, unknown0: u64, unknown1: **wasm_extern_t) -> void #foreign libwasmtime;
// Externals
wasm_extern_vec_copy :: (out: *wasm_extern_vec_t, unknown0: *wasm_extern_vec_t) -> void #foreign libwasmtime;
// Externals
wasm_extern_vec_delete :: (unknown0: *wasm_extern_vec_t) -> void #foreign libwasmtime;

// Externals
wasm_extern_kind :: (unknown0: *wasm_extern_t) -> wasm_externkind_t #foreign libwasmtime;
wasm_extern_type :: (unknown0: *wasm_extern_t) -> *wasm_externtype_t #foreign libwasmtime;

wasm_func_as_extern :: (unknown0: *wasm_func_t) -> *wasm_extern_t #foreign libwasmtime;
wasm_global_as_extern :: (unknown0: *wasm_global_t) -> *wasm_extern_t #foreign libwasmtime;
wasm_table_as_extern :: (unknown0: *wasm_table_t) -> *wasm_extern_t #foreign libwasmtime;
wasm_memory_as_extern :: (unknown0: *wasm_memory_t) -> *wasm_extern_t #foreign libwasmtime;

wasm_extern_as_func :: (unknown0: *wasm_extern_t) -> *wasm_func_t #foreign libwasmtime;
wasm_extern_as_global :: (unknown0: *wasm_extern_t) -> *wasm_global_t #foreign libwasmtime;
wasm_extern_as_table :: (unknown0: *wasm_extern_t) -> *wasm_table_t #foreign libwasmtime;
wasm_extern_as_memory :: (unknown0: *wasm_extern_t) -> *wasm_memory_t #foreign libwasmtime;

wasm_func_as_extern_const :: (unknown0: *wasm_func_t) -> *wasm_extern_t #foreign libwasmtime;
wasm_global_as_extern_const :: (unknown0: *wasm_global_t) -> *wasm_extern_t #foreign libwasmtime;
wasm_table_as_extern_const :: (unknown0: *wasm_table_t) -> *wasm_extern_t #foreign libwasmtime;
wasm_memory_as_extern_const :: (unknown0: *wasm_memory_t) -> *wasm_extern_t #foreign libwasmtime;

wasm_extern_as_func_const :: (unknown0: *wasm_extern_t) -> *wasm_func_t #foreign libwasmtime;
wasm_extern_as_global_const :: (unknown0: *wasm_extern_t) -> *wasm_global_t #foreign libwasmtime;
wasm_extern_as_table_const :: (unknown0: *wasm_extern_t) -> *wasm_table_t #foreign libwasmtime;
wasm_extern_as_memory_const :: (unknown0: *wasm_extern_t) -> *wasm_memory_t #foreign libwasmtime;

// Module Instances
wasm_instance_delete :: (unknown0: *wasm_instance_t) -> void #foreign libwasmtime;
// Module Instances
wasm_instance_copy :: (unknown0: *wasm_instance_t) -> *wasm_instance_t #foreign libwasmtime;
// Module Instances
wasm_instance_same :: (unknown0: *wasm_instance_t, unknown1: *wasm_instance_t) -> bool #foreign libwasmtime;
// Module Instances
wasm_instance_get_host_info :: (unknown0: *wasm_instance_t) -> *void #foreign libwasmtime;
// Module Instances
wasm_instance_set_host_info :: (unknown0: *wasm_instance_t, unknown1: *void) -> void #foreign libwasmtime;
// Module Instances
wasm_instance_set_host_info_with_finalizer :: (unknown0: *wasm_instance_t, unknown1: *void, unknown2: #type (unknown0: *void) -> void #c_call) -> void #foreign libwasmtime;
// Module Instances
wasm_instance_as_ref :: (unknown0: *wasm_instance_t) -> *wasm_ref_t #foreign libwasmtime;
// Module Instances
wasm_ref_as_instance :: (unknown0: *wasm_ref_t) -> *wasm_instance_t #foreign libwasmtime;
// Module Instances
wasm_instance_as_ref_const :: (unknown0: *wasm_instance_t) -> *wasm_ref_t #foreign libwasmtime;
// Module Instances
wasm_ref_as_instance_const :: (unknown0: *wasm_ref_t) -> *wasm_instance_t #foreign libwasmtime;

// Module Instances
wasm_instance_new :: (unknown0: *wasm_store_t, unknown1: *wasm_module_t, imports: *wasm_extern_vec_t, unknown2: **wasm_trap_t) -> *wasm_instance_t #foreign libwasmtime;

wasm_instance_exports :: (unknown0: *wasm_instance_t, out: *wasm_extern_vec_t) -> void #foreign libwasmtime;

wasi_config_t :: struct {}
/**
* \typedef wasi_config_t
* \brief Convenience alias for #wasi_config_t
*
* \struct wasi_config_t
* \brief TODO
*
* \fn void wasi_config_delete(wasi_config_t *);
* \brief Deletes a configuration object.
*/
wasi_config_delete :: (unknown0: *wasi_config_t) -> void #foreign libwasmtime;

/**
* \brief Creates a new empty configuration object.
*
* The caller is expected to deallocate the returned configuration
*/
wasi_config_new :: (__args: ..Any) -> *wasi_config_t #foreign libwasmtime;

/**
* \brief Sets the argv list for this configuration object.
*
* By default WASI programs have an empty argv list, but this can be used to
* explicitly specify what the argv list for the program is.
*
* The arguments are copied into the `config` object as part of this function
* call, so the `argv` pointer only needs to stay alive for this function call.
*
* This function returns `true` if all arguments were registered successfully,
* or `false` if an argument was not valid UTF-8.
*/
wasi_config_set_argv :: (config: *wasi_config_t, argc: u64, argv: **u8) -> bool #foreign libwasmtime;

/**
* \brief Indicates that the argv list should be inherited from this process's
* argv list.
*/
wasi_config_inherit_argv :: (config: *wasi_config_t) -> void #foreign libwasmtime;

/**
* \brief Sets the list of environment variables available to the WASI instance.
*
* By default WASI programs have a blank environment, but this can be used to
* define some environment variables for them.
*
* It is required that the `names` and `values` lists both have `envc` entries.
*
* The env vars are copied into the `config` object as part of this function
* call, so the `names` and `values` pointers only need to stay alive for this
* function call.
*
* This function returns `true` if all environment variables were successfully
* registered. This returns `false` if environment variables are not valid
* UTF-8.
*/
wasi_config_set_env :: (config: *wasi_config_t, envc: u64, names: **u8, values: **u8) -> bool #foreign libwasmtime;

/**
* \brief Indicates that the entire environment of the calling process should be
* inherited by this WASI configuration.
*/
wasi_config_inherit_env :: (config: *wasi_config_t) -> void #foreign libwasmtime;

/**
* \brief Configures standard input to be taken from the specified file.
*
* By default WASI programs have no stdin, but this configures the specified
* file to be used as stdin for this configuration.
*
* If the stdin location does not exist or it cannot be opened for reading then
* `false` is returned. Otherwise `true` is returned.
*/
wasi_config_set_stdin_file :: (config: *wasi_config_t, path: *u8) -> bool #foreign libwasmtime;

/**
* \brief Configures standard input to be taken from the specified
* #wasm_byte_vec_t.
*
* By default WASI programs have no stdin, but this configures the specified
* bytes to be used as stdin for this configuration.
*
* This function takes ownership of the `binary` argument.
*/
wasi_config_set_stdin_bytes :: (config: *wasi_config_t, binary: *wasm_byte_vec_t) -> void #foreign libwasmtime;

/**
* \brief Configures this process's own stdin stream to be used as stdin for
* this WASI configuration.
*/
wasi_config_inherit_stdin :: (config: *wasi_config_t) -> void #foreign libwasmtime;

/**
* \brief Configures standard output to be written to the specified file.
*
* By default WASI programs have no stdout, but this configures the specified
* file to be used as stdout.
*
* If the stdout location could not be opened for writing then `false` is
* returned. Otherwise `true` is returned.
*/
wasi_config_set_stdout_file :: (config: *wasi_config_t, path: *u8) -> bool #foreign libwasmtime;

/**
* \brief Configures this process's own stdout stream to be used as stdout for
* this WASI configuration.
*/
wasi_config_inherit_stdout :: (config: *wasi_config_t) -> void #foreign libwasmtime;

/**
* \brief Configures standard output to be directed to \p callback
*
* \param config The config to operate on
* \param callback A non-null callback must be provided, that will get called
* for each write with the buffer. A positive return value indicates the amount
* of bytes written. Negative return values are treated as OS error codes.
* \param data An optional user provided data that will be passed to \p callback
* \param finalizer An optional callback to be called to destroy \p data
*/
wasi_config_set_stdout_custom :: (config: *wasi_config_t, callback: #type (unknown0: *void, unknown1: *u8, unknown2: u64) -> ptrdiff_t #c_call, data: *void, finalizer: #type (unknown0: *void) -> void #c_call) -> void #foreign libwasmtime;

/**
* \brief Configures standard output to be written to the specified file.
*
* By default WASI programs have no stderr, but this configures the specified
* file to be used as stderr.
*
* If the stderr location could not be opened for writing then `false` is
* returned. Otherwise `true` is returned.
*/
wasi_config_set_stderr_file :: (config: *wasi_config_t, path: *u8) -> bool #foreign libwasmtime;

/**
* \brief Configures this process's own stderr stream to be used as stderr for
* this WASI configuration.
*/
wasi_config_inherit_stderr :: (config: *wasi_config_t) -> void #foreign libwasmtime;

/**
* \brief Configures standard error output to be directed to \p callback
*
* \param config The config to operate on
* \param callback A non-null callback must be provided, that will get called
* for each write with the buffer. A positive return value indicates the amount
* of bytes written. Negative return values are treated as OS error codes.
* \param data An optional user provided data that will be passed to \p callback
* \param finalizer An optional callback to be called to destroy \p data
*/
wasi_config_set_stderr_custom :: (config: *wasi_config_t, callback: #type (unknown0: *void, unknown1: *u8, unknown2: u64) -> ptrdiff_t #c_call, data: *void, finalizer: #type (unknown0: *void) -> void #c_call) -> void #foreign libwasmtime;

/**
* \brief The permissions granted for a directory when preopening it.
*/
wasi_dir_perms_flags :: enum u32 {
    READ  :: 1;

    WRITE :: 2;

    WASMTIME_WASI_DIR_PERMS_READ  :: READ;

    WASMTIME_WASI_DIR_PERMS_WRITE :: WRITE;
}

/**
* \brief The permissions granted for directories when preopening them,
* which is a bitmask with flag values from wasi_dir_perms_flags.
*/
wasi_dir_perms :: u64;

/**
* \brief The permissions granted for files when preopening a directory.
*/
wasi_file_perms_flags :: enum u32 {
    READ  :: 1;

    WRITE :: 2;

    WASMTIME_WASI_FILE_PERMS_READ  :: READ;

    WASMTIME_WASI_FILE_PERMS_WRITE :: WRITE;
}

/**
* \brief The max permissions granted a file within a preopened directory,
* which is a bitmask with flag values from wasi_file_perms_flags.
*/
wasi_file_perms :: u64;

/**
* \brief Configures a "preopened directory" to be available to WASI APIs.
*
* By default WASI programs do not have access to anything on the filesystem.
* This API can be used to grant WASI programs access to a directory on the
* filesystem, but only that directory (its whole contents but nothing above
* it).
*
* The `host_path` argument here is a path name on the host filesystem, and
* `guest_path` is the name by which it will be known in wasm.
*
* The `dir_perms` argument is the permissions that wasm will have to operate on
* `guest_path`. This can be used, for example, to provide readonly access to a
* directory. This argument is a bitmask with the following flag values:
* - WASMTIME_WASI_DIR_PERMS_READ
* - WASMTIME_WASI_DIR_PERMS_WRITE
*
* The `file_perms` argument is similar to `dir_perms` but corresponds to the
* maximum set of permissions that can be used for any file in this directory.
* This argument is a bitmask with the following flag values:
* - WASMTIME_WASI_FILE_PERMS_READ
* - WASMTIME_WASI_FILE_PERMS_WRITE
*/
wasi_config_preopen_dir :: (config: *wasi_config_t, host_path: *u8, guest_path: *u8, dir_perms: wasi_dir_perms, file_perms: wasi_file_perms) -> bool #foreign libwasmtime;

wasmtime_error :: struct {}
/**
* \typedef wasmtime_error_t
* \brief Convenience alias for #wasmtime_error
*
* \struct wasmtime_error
* \brief Errors generated by Wasmtime.
* \headerfile wasmtime/error.h
*
* This opaque type represents an error that happened as part of one of the
* functions below. Errors primarily have an error message associated with them
* at this time, which you can acquire by calling #wasmtime_error_message.
*
* Errors are safe to share across threads and must be deleted with
* #wasmtime_error_delete.
*/
wasmtime_error_t :: wasmtime_error;

/**
* \brief Creates a new error with the provided message.
*/
wasmtime_error_new :: (unknown0: *u8) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Deletes an error.
*/
wasmtime_error_delete :: (error: *wasmtime_error_t) -> void #foreign libwasmtime;

/**
* \brief Returns the string description of this error.
*
* This will "render" the error to a string and then return the string
* representation of the error to the caller. The `message` argument should be
* uninitialized before this function is called and the caller is responsible
* for deallocating it with #wasm_byte_vec_delete afterwards.
*/
wasmtime_error_message :: (error: *wasmtime_error_t, message: *wasm_name_t) -> void #foreign libwasmtime;

/**
* \brief Attempts to extract a WASI-specific exit status from this error.
*
* Returns `true` if the error is a WASI "exit" trap and has a return status.
* If `true` is returned then the exit status is returned through the `status`
* pointer. If `false` is returned then this is not a wasi exit trap.
*/
wasmtime_error_exit_status :: (unknown0: *wasmtime_error_t, status: *s32) -> bool #foreign libwasmtime;

/**
* \brief Attempts to extract a WebAssembly trace from this error.
*
* This is similar to #wasm_trap_trace except that it takes a #wasmtime_error_t
* as input. The `out` argument will be filled in with the wasm trace, if
* present.
*/
wasmtime_error_wasm_trace :: (unknown0: *wasmtime_error_t, out: *wasm_frame_vec_t) -> void #foreign libwasmtime;

/**
* \brief Specifier for how Wasmtime will compile code, values are in
* #wasmtime_strategy_enum
*/
wasmtime_strategy_t :: u8;

/**
* \brief Different ways that Wasmtime can compile WebAssembly
*
* The default value is #WASMTIME_STRATEGY_AUTO.
*/
wasmtime_strategy_enum :: enum u32 {
    AUTO      :: 0;

    CRANELIFT :: 1;

    WASMTIME_STRATEGY_AUTO      :: AUTO;

    WASMTIME_STRATEGY_CRANELIFT :: CRANELIFT;
}

/**
* \brief Specifier of what optimization level to use for generated JIT code.
*
* See #wasmtime_opt_level_enum for possible values.
*/
wasmtime_opt_level_t :: u8;

/**
* \brief Different ways Wasmtime can optimize generated code.
*
* The default value is #WASMTIME_OPT_LEVEL_SPEED.
*/
wasmtime_opt_level_enum :: enum u32 {
    NONE           :: 0;

    SPEED          :: 1;

    SPEED_AND_SIZE :: 2;

    WASMTIME_OPT_LEVEL_NONE           :: NONE;

    WASMTIME_OPT_LEVEL_SPEED          :: SPEED;

    WASMTIME_OPT_LEVEL_SPEED_AND_SIZE :: SPEED_AND_SIZE;
}

/**
* \brief Different ways wasmtime can enable profiling JIT code.
*
* See #wasmtime_profiling_strategy_enum for possible values.
*/
wasmtime_profiling_strategy_t :: u8;

/**
* \brief Different ways to profile JIT code.
*
* The default is #WASMTIME_PROFILING_STRATEGY_NONE.
*/
wasmtime_profiling_strategy_enum :: enum u32 {
    NONE    :: 0;

    JITDUMP :: 1;

    VTUNE   :: 2;

    PERFMAP :: 3;

    WASMTIME_PROFILING_STRATEGY_NONE    :: NONE;

    WASMTIME_PROFILING_STRATEGY_JITDUMP :: JITDUMP;

    WASMTIME_PROFILING_STRATEGY_VTUNE   :: VTUNE;

    WASMTIME_PROFILING_STRATEGY_PERFMAP :: PERFMAP;
}

/**
* \brief Configures whether DWARF debug information is constructed at runtime
* to describe JIT code.
*
* This setting is `false` by default. When enabled it will attempt to inform
* native debuggers about DWARF debugging information for JIT code to more
* easily debug compiled WebAssembly via native debuggers. This can also
* sometimes improve the quality of output when profiling is enabled.
*/
wasmtime_config_debug_info_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Whether or not fuel is enabled for generated code.
*
* This setting is `false` by default. When enabled it will enable fuel counting
* meaning that fuel will be consumed every time a wasm instruction is executed,
* and trap when reaching zero.
*/
wasmtime_config_consume_fuel_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Whether or not epoch-based interruption is enabled for generated code.
*
* This setting is `false` by default. When enabled wasm code will check the
* current epoch periodically and abort if the current epoch is beyond a
* store-configured limit.
*
* Note that when this setting is enabled all stores will immediately trap and
* need to have their epoch deadline otherwise configured with
* #wasmtime_context_set_epoch_deadline.
*
* Note that the current epoch is engine-local and can be incremented with
* #wasmtime_engine_increment_epoch.
*/
wasmtime_config_epoch_interruption_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures the maximum stack size, in bytes, that JIT code can use.
*
* This setting is 2MB by default. Configuring this setting will limit the
* amount of native stack space that JIT code can use while it is executing. If
* you're hitting stack overflow you can try making this setting larger, or if
* you'd like to limit wasm programs to less stack you can also configure this.
*
* Note that this setting is not interpreted with 100% precision. Additionally
* the amount of stack space that wasm takes is always relative to the first
* invocation of wasm on the stack, so recursive calls with host frames in the
* middle will all need to fit within this setting.
*/
wasmtime_config_max_wasm_stack_set :: (unknown0: *wasm_config_t, unknown1: u64) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly threading proposal is enabled.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_threads_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether shared memories can be created.
*
* This setting is `false` by default.
*/
wasmtime_config_shared_memory_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly tail call proposal is enabled.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_tail_call_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly reference types proposal is
* enabled.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_reference_types_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly typed function reference types
* proposal is enabled.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_function_references_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly GC proposal is enabled.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_gc_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly SIMD proposal is
* enabled.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_simd_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly relaxed SIMD proposal is
* enabled.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_relaxed_simd_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly relaxed SIMD proposal is
* in deterministic mode.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_relaxed_simd_deterministic_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly bulk memory proposal is
* enabled.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_bulk_memory_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly multi value proposal is
* enabled.
*
* This setting is `true` by default.
*/
wasmtime_config_wasm_multi_value_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly multi-memory proposal is
* enabled.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_multi_memory_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly memory64 proposal is
* enabled.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_memory64_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly wide-arithmetic proposal is
* enabled.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_wide_arithmetic_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly exceptions proposal is enabled.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_exceptions_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly custom-page-sizes proposal is
* enabled.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_custom_page_sizes_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly stack switching
* proposal is enabled.
*
* This setting is `false` by default.
*/
wasmtime_config_wasm_stack_switching_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures how JIT code will be compiled.
*
* This setting is #WASMTIME_STRATEGY_AUTO by default.
*/
wasmtime_config_strategy_set :: (unknown0: *wasm_config_t, unknown1: wasmtime_strategy_t) -> void #foreign libwasmtime;

/**
* \brief Configure whether wasmtime should compile a module using multiple
* threads.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#method.parallel_compilation.
*/
wasmtime_config_parallel_compilation_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether Cranelift's debug verifier is enabled.
*
* This setting in `false` by default.
*
* When cranelift is used for compilation this enables expensive debug checks
* within Cranelift itself to verify it's correct.
*/
wasmtime_config_cranelift_debug_verifier_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures whether Cranelift should perform a NaN-canonicalization
* pass.
*
* When Cranelift is used as a code generation backend this will configure
* it to replace NaNs with a single canonical value. This is useful for users
* requiring entirely deterministic WebAssembly computation.
*
* This is not required by the WebAssembly spec, so it is not enabled by
* default.
*
* The default value for this is `false`
*/
wasmtime_config_cranelift_nan_canonicalization_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures Cranelift's optimization level for JIT code.
*
* This setting in #WASMTIME_OPT_LEVEL_SPEED by default.
*/
wasmtime_config_cranelift_opt_level_set :: (unknown0: *wasm_config_t, unknown1: wasmtime_opt_level_t) -> void #foreign libwasmtime;

/**
* \brief Configures the profiling strategy used for JIT code.
*
* This setting in #WASMTIME_PROFILING_STRATEGY_NONE by default.
*/
wasmtime_config_profiler_set :: (unknown0: *wasm_config_t, unknown1: wasmtime_profiling_strategy_t) -> void #foreign libwasmtime;

/**
* \brief Configures whether `memory_reservation` is the maximal size of linear
* memory.
*
* This setting is `false` by default.
*
* For more information see the Rust documentation at
* https://bytecodealliance.github.io/wasmtime/api/wasmtime/struct.Config.html#method.memory_may_move.
*/
wasmtime_config_memory_may_move_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures the size, in bytes, of initial memory reservation size for
* linear memories.
*
* For more information see the Rust documentation at
* https://bytecodealliance.github.io/wasmtime/api/wasmtime/struct.Config.html#method.memory_reservation.
*/
wasmtime_config_memory_reservation_set :: (unknown0: *wasm_config_t, unknown1: u64) -> void #foreign libwasmtime;

/**
* \brief Configures the guard region size for linear memory.
*
* For more information see the Rust documentation at
* https://bytecodealliance.github.io/wasmtime/api/wasmtime/struct.Config.html#method.memory_guard_size.
*/
wasmtime_config_memory_guard_size_set :: (unknown0: *wasm_config_t, unknown1: u64) -> void #foreign libwasmtime;

/**
* \brief Configures the size, in bytes, of the extra virtual memory space
* reserved for memories to grow into after being relocated.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#method.memory_reservation_for_growth
*/
wasmtime_config_memory_reservation_for_growth_set :: (unknown0: *wasm_config_t, unknown1: u64) -> void #foreign libwasmtime;

/**
* \brief Configures whether to generate native unwind information (e.g.
* .eh_frame on Linux).
*
* This option defaults to true.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#method.native_unwind_info
*/
wasmtime_config_native_unwind_info_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Enables Wasmtime's cache and loads configuration from the specified
* path.
*
* By default the Wasmtime compilation cache is disabled. The configuration path
* here can be `NULL` to use the default settings, and otherwise the argument
* here must be a file on the filesystem with TOML configuration -
* https://bytecodealliance.github.io/wasmtime/cli-cache.html.
*
* An error is returned if the cache configuration could not be loaded or if the
* cache could not be enabled.
*/
wasmtime_config_cache_config_load :: (unknown0: *wasm_config_t, unknown1: *u8) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Configures the target triple that this configuration will produce
* machine code for.
*
* This option defaults to the native host. Calling this method will
* additionally disable inference of the native features of the host (e.g.
* detection of SSE4.2 on x86_64 hosts). Native features can be reenabled with
* the `cranelift_flag_{set,enable}` properties.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#method.config
*/
wasmtime_config_target_set :: (unknown0: *wasm_config_t, unknown1: *u8) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Enables a target-specific flag in Cranelift.
*
* This can be used, for example, to enable SSE4.2 on x86_64 hosts. Settings can
* be explored with `wasmtime settings` on the CLI.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#method.cranelift_flag_enable
*/
wasmtime_config_cranelift_flag_enable :: (unknown0: *wasm_config_t, unknown1: *u8) -> void #foreign libwasmtime;

/**
* \brief Sets a target-specific flag in Cranelift to the specified value.
*
* This can be used, for example, to enable SSE4.2 on x86_64 hosts. Settings can
* be explored with `wasmtime settings` on the CLI.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#method.cranelift_flag_set
*/
wasmtime_config_cranelift_flag_set :: (unknown0: *wasm_config_t, key: *u8, value: *u8) -> void #foreign libwasmtime;

/**
* \brief Configures whether, when on macOS, Mach ports are used for exception
* handling instead of traditional Unix-based signal handling.
*
* This option defaults to true, using Mach ports by default.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#method.macos_use_mach_ports
*/
wasmtime_config_macos_use_mach_ports_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Configures Wasmtime to not use signals-based trap handlers, for
* example disables `SIGILL` and `SIGSEGV` handler registration on Unix
* platforms.
*
* This option defaults to `true`: signals-based trap handlers are enabled
* by default.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#method.signals_based_traps
*/
wasmtime_config_signals_based_traps_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* Return the data from a LinearMemory instance.
*
* The size in bytes as well as the maximum number of bytes that can be
* allocated should be returned as well.
*
* For more information about see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/trait.LinearMemory.html
*/
wasmtime_memory_get_callback_t :: #type (env: *void, byte_size: *u64, byte_capacity: *u64) -> *u8 #c_call;

/**
* Grow the memory to the `new_size` in bytes.
*
* For more information about the parameters see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/trait.LinearMemory.html#tymethod.grow_to
*/
wasmtime_memory_grow_callback_t :: #type (env: *void, new_size: u64) -> *wasmtime_error_t #c_call;

/**
* A LinearMemory instance created from a #wasmtime_new_memory_callback_t.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/trait.LinearMemory.html
*/
wasmtime_linear_memory :: struct {
    /// User provided value to be passed to get_memory and grow_memory
    env:         *void;

    /// Callback to get the memory and size of this LinearMemory
    get_memory:  wasmtime_memory_get_callback_t;

    /// Callback to request growing the memory
    grow_memory: wasmtime_memory_grow_callback_t;

    /// An optional finalizer for env
    finalizer:   #type (unknown0: *void) -> void #c_call;
}

/**
* A LinearMemory instance created from a #wasmtime_new_memory_callback_t.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/trait.LinearMemory.html
*/
wasmtime_linear_memory_t :: wasmtime_linear_memory;

/**
* A callback to create a new LinearMemory from the specified parameters.
*
* The result should be written to `memory_ret` and wasmtime will own the values
* written into that struct.
*
* This callback must be thread-safe.
*
* For more information about the parameters see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/trait.MemoryCreator.html#tymethod.new_memory
*/
wasmtime_new_memory_callback_t :: #type (env: *void, ty: *wasm_memorytype_t, minimum: u64, maximum: u64, reserved_size_in_bytes: u64, guard_size_in_bytes: u64, memory_ret: *wasmtime_linear_memory_t) -> *wasmtime_error_t #c_call;

/**
* A representation of custom memory creator and methods for an instance of
* LinearMemory.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/trait.MemoryCreator.html
*/
wasmtime_memory_creator :: struct {
    /// User provided value to be passed to new_memory
    env:        *void;

    /// The callback to create new memory, must be thread safe
    new_memory: wasmtime_new_memory_callback_t;

    /// An optional finalizer for env.
    finalizer:  #type (unknown0: *void) -> void #c_call;
}

/**
* A representation of custom memory creator and methods for an instance of
* LinearMemory.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/trait.MemoryCreator.html
*/
wasmtime_memory_creator_t :: wasmtime_memory_creator;

/**
* Sets a custom memory creator.
*
* Custom memory creators are used when creating host Memory objects or when
* creating instance linear memories for the on-demand instance allocation
* strategy.
*
* The config does **not** take ownership of the #wasmtime_memory_creator_t
* passed in, but instead copies all the values in the struct.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#method.with_host_memory
*/
wasmtime_config_host_memory_creator_set :: (unknown0: *wasm_config_t, unknown1: *wasmtime_memory_creator_t) -> void #foreign libwasmtime;

/**
* \brief Configures whether copy-on-write memory-mapped data is used to
* initialize a linear memory.
*
* Initializing linear memory via a copy-on-write mapping can drastically
* improve instantiation costs of a WebAssembly module because copying memory is
* deferred. Additionally if a page of memory is only ever read from WebAssembly
* and never written too then the same underlying page of data will be reused
* between all instantiations of a module meaning that if a module is
* instantiated many times this can lower the overall memory required needed to
* run that module.
*
* This option defaults to true.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#method.memory_init_cow
*/
wasmtime_config_memory_init_cow_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

wasmtime_pooling_allocation_config_t :: struct {}

/**
* \brief Creates a new pooling allocation configuration object. Must be
* deallocated with a call to wasmtime_pooling_allocation_config_delete.
*/
wasmtime_pooling_allocation_config_new :: (__args: ..Any) -> *wasmtime_pooling_allocation_config_t #foreign libwasmtime;

/**
* \brief Deallocates a pooling allocation configuration object created with a
* call to wasmtime_pooling_allocation_config_new.
*/
wasmtime_pooling_allocation_config_delete :: (unknown0: *wasmtime_pooling_allocation_config_t) -> void #foreign libwasmtime;

/**
* \brief Configures the maximum number of “unused warm slots” to retain in the
* pooling allocator.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.max_unused_warm_slots.
*/
wasmtime_pooling_allocation_config_max_unused_warm_slots_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u32) -> void #foreign libwasmtime;

/**
* \brief The target number of decommits to do per batch.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.decommit_batch_size.
*/
wasmtime_pooling_allocation_config_decommit_batch_size_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u64) -> void #foreign libwasmtime;

/**
* \brief How much memory, in bytes, to keep resident for async stacks allocated
* with the pooling allocator.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.async_stack_keep_resident.
*/
wasmtime_pooling_allocation_config_async_stack_keep_resident_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u64) -> void #foreign libwasmtime;

/**
* \brief How much memory, in bytes, to keep resident for each linear memory
* after deallocation.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.linear_memory_keep_resident.
*/
wasmtime_pooling_allocation_config_linear_memory_keep_resident_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u64) -> void #foreign libwasmtime;

/**
* \brief How much memory, in bytes, to keep resident for each table after
* deallocation.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.table_keep_resident.
*/
wasmtime_pooling_allocation_config_table_keep_resident_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u64) -> void #foreign libwasmtime;

/**
* \brief The maximum number of concurrent component instances supported
* (default is 1000).
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.total_component_instances.
*/
wasmtime_pooling_allocation_config_total_component_instances_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u32) -> void #foreign libwasmtime;

/**
* \brief The maximum size, in bytes, allocated for a component instance’s
* VMComponentContext metadata.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.max_component_instance_size.
*/
wasmtime_pooling_allocation_config_max_component_instance_size_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u64) -> void #foreign libwasmtime;

/**
* \brief The maximum number of core instances a single component may contain
* (default is unlimited).
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.max_core_instances_per_component.
*/
wasmtime_pooling_allocation_config_max_core_instances_per_component_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u32) -> void #foreign libwasmtime;

/**
* \brief The maximum number of Wasm linear memories that a single component may
* transitively contain (default is unlimited).
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.max_memories_per_component.
*/
wasmtime_pooling_allocation_config_max_memories_per_component_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u32) -> void #foreign libwasmtime;

/**
* \brief The maximum number of tables that a single component may transitively
* contain (default is unlimited).
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.max_tables_per_component.
*/
wasmtime_pooling_allocation_config_max_tables_per_component_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u32) -> void #foreign libwasmtime;

/**
* \brief The maximum number of concurrent Wasm linear memories supported
* (default is 1000).
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.total_memories.
*/
wasmtime_pooling_allocation_config_total_memories_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u32) -> void #foreign libwasmtime;

/**
* \brief The maximum number of concurrent tables supported (default is 1000).
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.total_tables.
*/
wasmtime_pooling_allocation_config_total_tables_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u32) -> void #foreign libwasmtime;

/**
* \brief The maximum number of execution stacks allowed for asynchronous
* execution, when enabled (default is 1000).
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.total_stacks.
*/
wasmtime_pooling_allocation_config_total_stacks_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u32) -> void #foreign libwasmtime;

/**
* \brief The maximum number of concurrent core instances supported (default is
* 1000).
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.total_core_instances.
*/
wasmtime_pooling_allocation_config_total_core_instances_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u32) -> void #foreign libwasmtime;

/**
* \brief The maximum size, in bytes, allocated for a core instance’s VMContext
* metadata.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.max_core_instance_size.
*/
wasmtime_pooling_allocation_config_max_core_instance_size_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u64) -> void #foreign libwasmtime;

/**
* \brief The maximum number of defined tables for a core module (default is 1).
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.max_tables_per_module.
*/
wasmtime_pooling_allocation_config_max_tables_per_module_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u32) -> void #foreign libwasmtime;

/**
* \brief The maximum table elements for any table defined in a module (default
* is 20000).
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.table_elements.
*/
wasmtime_pooling_allocation_config_table_elements_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u64) -> void #foreign libwasmtime;

/**
* \brief The maximum number of defined linear memories for a module (default is
* 1).
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.max_memories_per_module.
*/
wasmtime_pooling_allocation_config_max_memories_per_module_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u32) -> void #foreign libwasmtime;

/**
* \brief The maximum byte size that any WebAssembly linear memory may grow to.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.max_memory_size.
*/
wasmtime_pooling_allocation_config_max_memory_size_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u64) -> void #foreign libwasmtime;

/**
* \brief The maximum number of concurrent GC heaps supported (default is 1000).
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.PoolingAllocationConfig.html#method.total_gc_heaps.
*/
wasmtime_pooling_allocation_config_total_gc_heaps_set :: (unknown0: *wasmtime_pooling_allocation_config_t, unknown1: u32) -> void #foreign libwasmtime;

/**
* \brief Sets the Wasmtime allocation strategy to use the pooling allocator. It
* does not take ownership of the pooling allocation configuration object, which
* must be deleted with a call to wasmtime_pooling_allocation_config_delete.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#method.allocation_strategy.
*/
wasmtime_pooling_allocation_strategy_set :: (unknown0: *wasm_config_t, unknown1: *wasmtime_pooling_allocation_config_t) -> void #foreign libwasmtime;

/**
* \brief Configures whether the WebAssembly component-model proposal will be
* enabled for compilation.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#method.wasm_component_model.
*/
wasmtime_config_wasm_component_model_set :: (unknown0: *wasm_config_t, unknown1: bool) -> void #foreign libwasmtime;

/**
* \brief Create a new reference to the same underlying engine.
*
* This function clones the reference-counted pointer to the internal object,
* and must be freed using #wasm_engine_delete.
*/
wasmtime_engine_clone :: (engine: *wasm_engine_t) -> *wasm_engine_t #foreign libwasmtime;

/**
* \brief Increments the engine-local epoch variable.
*
* This function will increment the engine's current epoch which can be used to
* force WebAssembly code to trap if the current epoch goes beyond the
* #wasmtime_store_t configured epoch deadline.
*
* This function is safe to call from any thread, and it is also
* async-signal-safe.
*
* See also #wasmtime_config_epoch_interruption_set.
*/
wasmtime_engine_increment_epoch :: (engine: *wasm_engine_t) -> void #foreign libwasmtime;

/**
* \brief Returns whether this engine is using the Pulley interpreter to execute
* WebAssembly code.
*/
wasmtime_engine_is_pulley :: (engine: *wasm_engine_t) -> bool #foreign libwasmtime;

wasmtime_module :: struct {}
/**
* \typedef wasmtime_module_t
* \brief Convenience alias for #wasmtime_module
*
* \struct wasmtime_module
* \brief A compiled Wasmtime module.
*
* This type represents a compiled WebAssembly module. The compiled module is
* ready to be instantiated and can be inspected for imports/exports. It is safe
* to use a module across multiple threads simultaneously.
*/
wasmtime_module_t :: wasmtime_module;

/**
* \brief Compiles a WebAssembly binary into a #wasmtime_module_t
*
* This function will compile a WebAssembly binary into an owned #wasm_module_t.
* This performs the same as #wasm_module_new except that it returns a
* #wasmtime_error_t type to get richer error information.
*
* On success the returned #wasmtime_error_t is `NULL` and the `ret` pointer is
* filled in with a #wasm_module_t. On failure the #wasmtime_error_t is
* non-`NULL` and the `ret` pointer is unmodified.
*
* This function does not take ownership of any of its arguments, but the
* returned error and module are owned by the caller.
*/
wasmtime_module_new :: (engine: *wasm_engine_t, wasm: *u8, wasm_len: u64, ret: **wasmtime_module_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Deletes a module.
*/
wasmtime_module_delete :: (m: *wasmtime_module_t) -> void #foreign libwasmtime;

/**
* \brief Creates a shallow clone of the specified module, increasing the
* internal reference count.
*/
wasmtime_module_clone :: (m: *wasmtime_module_t) -> *wasmtime_module_t #foreign libwasmtime;

/**
* \brief Same as #wasm_module_imports, but for #wasmtime_module_t.
*/
wasmtime_module_imports :: (module: *wasmtime_module_t, out: *wasm_importtype_vec_t) -> void #foreign libwasmtime;

/**
* \brief Same as #wasm_module_exports, but for #wasmtime_module_t.
*/
wasmtime_module_exports :: (module: *wasmtime_module_t, out: *wasm_exporttype_vec_t) -> void #foreign libwasmtime;

/**
* \brief Validate a WebAssembly binary.
*
* This function will validate the provided byte sequence to determine if it is
* a valid WebAssembly binary within the context of the engine provided.
*
* This function does not take ownership of its arguments but the caller is
* expected to deallocate the returned error if it is non-`NULL`.
*
* If the binary validates then `NULL` is returned, otherwise the error returned
* describes why the binary did not validate.
*/
wasmtime_module_validate :: (engine: *wasm_engine_t, wasm: *u8, wasm_len: u64) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief This function serializes compiled module artifacts as blob data.
*
* \param module the module
* \param ret if the conversion is successful, this byte vector is filled in
* with the serialized compiled module.
*
* \return a non-null error if parsing fails, or returns `NULL`. If parsing
* fails then `ret` isn't touched.
*
* This function does not take ownership of `module`, and the caller is
* expected to deallocate the returned #wasmtime_error_t and #wasm_byte_vec_t.
*/
wasmtime_module_serialize :: (module: *wasmtime_module_t, ret: *wasm_byte_vec_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Build a module from serialized data.
*
* This function does not take ownership of any of its arguments, but the
* returned error and module are owned by the caller.
*
* This function is not safe to receive arbitrary user input. See the Rust
* documentation for more information on what inputs are safe to pass in here
* (e.g. only that of `wasmtime_module_serialize`)
*/
wasmtime_module_deserialize :: (engine: *wasm_engine_t, bytes: *u8, bytes_len: u64, ret: **wasmtime_module_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Deserialize a module from an on-disk file.
*
* This function is the same as #wasmtime_module_deserialize except that it
* reads the data for the serialized module from the path on disk. This can be
* faster than the alternative which may require copying the data around.
*
* This function does not take ownership of any of its arguments, but the
* returned error and module are owned by the caller.
*
* This function is not safe to receive arbitrary user input. See the Rust
* documentation for more information on what inputs are safe to pass in here
* (e.g. only that of `wasmtime_module_serialize`)
*/
wasmtime_module_deserialize_file :: (engine: *wasm_engine_t, path: *u8, ret: **wasmtime_module_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Returns the range of bytes in memory where this module’s compilation
* image resides.
*
* The compilation image for a module contains executable code, data, debug
* information, etc. This is roughly the same as the wasmtime_module_serialize
* but not the exact same.
*
* For more details see:
* https://docs.wasmtime.dev/api/wasmtime/struct.Module.html#method.image_range
*/
wasmtime_module_image_range :: (module: *wasmtime_module_t, start: **void, end: **void) -> void #foreign libwasmtime;

wasmtime_sharedmemory :: struct {}
/**
* \brief Interface for shared memories.
*
* For more information see the Rust documentation at:
* https://docs.wasmtime.dev/api/wasmtime/struct.SharedMemory.html
*/
wasmtime_sharedmemory_t :: wasmtime_sharedmemory;

/**
* \brief Creates a new WebAssembly shared linear memory
*
* \param engine engine that created shared memory is associated with
* \param ty the type of the memory to create
* \param ret where to store the returned memory
*
* If an error happens when creating the memory it's returned and owned by the
* caller. If an error happens then `ret` is not filled in.
*/
wasmtime_sharedmemory_new :: (engine: *wasm_engine_t, ty: *wasm_memorytype_t, ret: **wasmtime_sharedmemory_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Deletes shared linear memory
*
* \param memory memory to be deleted
*/
wasmtime_sharedmemory_delete :: (memory: *wasmtime_sharedmemory_t) -> void #foreign libwasmtime;

/**
* \brief Clones shared linear memory
*
* \param memory memory to be cloned
*
* This function makes shallow clone, ie. copy of reference counted
* memory handle.
*/
wasmtime_sharedmemory_clone :: (memory: *wasmtime_sharedmemory_t) -> *wasmtime_sharedmemory_t #foreign libwasmtime;

/**
* \brief Returns the type of the shared memory specified
*/
wasmtime_sharedmemory_type :: (memory: *wasmtime_sharedmemory_t) -> *wasm_memorytype_t #foreign libwasmtime;

/**
* \brief Returns the base pointer in memory where
the shared linear memory starts.
*/
wasmtime_sharedmemory_data :: (memory: *wasmtime_sharedmemory_t) -> *u8 #foreign libwasmtime;

/**
* \brief Returns the byte length of this shared linear memory.
*/
wasmtime_sharedmemory_data_size :: (memory: *wasmtime_sharedmemory_t) -> u64 #foreign libwasmtime;

/**
* \brief Returns the length, in WebAssembly pages, of this shared linear memory
*/
wasmtime_sharedmemory_size :: (memory: *wasmtime_sharedmemory_t) -> u64 #foreign libwasmtime;

/**
* \brief Attempts to grow the specified shared memory by `delta` pages.
*
* \param memory the memory to grow
* \param delta the number of pages to grow by
* \param prev_size where to store the previous size of memory
*
* If memory cannot be grown then `prev_size` is left unchanged and an error is
* returned. Otherwise `prev_size` is set to the previous size of the memory, in
* WebAssembly pages, and `NULL` is returned.
*/
wasmtime_sharedmemory_grow :: (memory: *wasmtime_sharedmemory_t, delta: u64, prev_size: *u64) -> *wasmtime_error_t #foreign libwasmtime;

wasmtime_store :: struct {}
/**
* \typedef wasmtime_store_t
* \brief Convenience alias for #wasmtime_store_t
*
* \struct wasmtime_store
* \brief Storage of WebAssembly objects
*
* A store is the unit of isolation between WebAssembly instances in an
* embedding of Wasmtime. Values in one #wasmtime_store_t cannot flow into
* another #wasmtime_store_t. Stores are cheap to create and cheap to dispose.
* It's expected that one-off stores are common in embeddings.
*
* Objects stored within a #wasmtime_store_t are referenced with integer handles
* rather than interior pointers. This means that most APIs require that the
* store be explicitly passed in, which is done via #wasmtime_context_t. It is
* safe to move a #wasmtime_store_t to any thread at any time. A store generally
* cannot be concurrently used, however.
*/
wasmtime_store_t :: wasmtime_store;

wasmtime_context :: struct {}
/**
* \typedef wasmtime_context_t
* \brief Convenience alias for #wasmtime_context
*
* \struct wasmtime_context
* \brief An interior pointer into a #wasmtime_store_t which is used as
* "context" for many functions.
*
* This context pointer is used pervasively throughout Wasmtime's API. This can
* be acquired from #wasmtime_store_context or #wasmtime_caller_context. The
* context pointer for a store is the same for the entire lifetime of a store,
* so it can safely be stored adjacent to a #wasmtime_store_t itself.
*
* Usage of a #wasmtime_context_t must not outlive the original
* #wasmtime_store_t. Additionally #wasmtime_context_t can only be used in
* situations where it has explicitly been granted access to doing so. For
* example finalizers cannot use #wasmtime_context_t because they are not given
* access to it.
*/
wasmtime_context_t :: wasmtime_context;

/**
* \brief Creates a new store within the specified engine.
*
* \param engine the compilation environment with configuration this store is
* connected to
* \param data user-provided data to store, can later be acquired with
* #wasmtime_context_get_data.
* \param finalizer an optional finalizer for `data`
*
* This function creates a fresh store with the provided configuration settings.
* The returned store must be deleted with #wasmtime_store_delete.
*/
wasmtime_store_new :: (engine: *wasm_engine_t, data: *void, finalizer: #type (unknown0: *void) -> void #c_call) -> *wasmtime_store_t #foreign libwasmtime;

/**
* \brief Returns the interior #wasmtime_context_t pointer to this store
*/
wasmtime_store_context :: (store: *wasmtime_store_t) -> *wasmtime_context_t #foreign libwasmtime;

/**
* \brief Provides limits for a store. Used by hosts to limit resource
* consumption of instances. Use negative value to keep the default value
* for the limit.
*
* \param store store where the limits should be set.
* \param memory_size the maximum number of bytes a linear memory can grow to.
* Growing a linear memory beyond this limit will fail. By default,
* linear memory will not be limited.
* \param table_elements the maximum number of elements in a table.
* Growing a table beyond this limit will fail. By default, table elements
* will not be limited.
* \param instances the maximum number of instances that can be created
* for a Store. Module instantiation will fail if this limit is exceeded.
* This value defaults to 10,000.
* \param tables the maximum number of tables that can be created for a Store.
* Module instantiation will fail if this limit is exceeded. This value
* defaults to 10,000.
* \param memories the maximum number of linear memories that can be created
* for a Store. Instantiation will fail with an error if this limit is exceeded.
* This value defaults to 10,000.
*
* Use any negative value for the parameters that should be kept on
* the default values.
*
* Note that the limits are only used to limit the creation/growth of
* resources in the future, this does not retroactively attempt to apply
* limits to the store.
*/
wasmtime_store_limiter :: (store: *wasmtime_store_t, memory_size: s64, table_elements: s64, instances: s64, tables: s64, memories: s64) -> void #foreign libwasmtime;

/**
* \brief Deletes a store.
*/
wasmtime_store_delete :: (store: *wasmtime_store_t) -> void #foreign libwasmtime;

/**
* \brief Returns the user-specified data associated with the specified store
*/
wasmtime_context_get_data :: (_context: *wasmtime_context_t) -> *void #foreign libwasmtime;

/**
* \brief Overwrites the user-specified data associated with this store.
*
* Note that this does not execute the original finalizer for the provided data,
* and the original finalizer will be executed for the provided data when the
* store is deleted.
*/
wasmtime_context_set_data :: (_context: *wasmtime_context_t, data: *void) -> void #foreign libwasmtime;

/**
* \brief Perform garbage collection within the given context.
*
* Garbage collects `externref`s that are used within this store. Any
* `externref`s that are discovered to be unreachable by other code or objects
* will have their finalizers run.
*
* The `context` argument must not be NULL.
*/
wasmtime_context_gc :: (_context: *wasmtime_context_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Set fuel to this context's store for wasm to consume while executing.
*
* For this method to work fuel consumption must be enabled via
* #wasmtime_config_consume_fuel_set. By default a store starts with 0 fuel
* for wasm to execute with (meaning it will immediately trap).
* This function must be called for the store to have
* some fuel to allow WebAssembly to execute.
*
* Note that when fuel is entirely consumed it will cause wasm to trap.
*
* If fuel is not enabled within this store then an error is returned. If fuel
* is successfully added then NULL is returned.
*/
wasmtime_context_set_fuel :: (store: *wasmtime_context_t, fuel: u64) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Returns the amount of fuel remaining in this context's store.
*
* If fuel consumption is not enabled via #wasmtime_config_consume_fuel_set
* then this function will return an error. Otherwise `NULL` is returned and the
* fuel parameter is filled in with fuel consumed so far.
*
* Also note that fuel, if enabled, must be originally configured via
* #wasmtime_context_set_fuel.
*/
wasmtime_context_get_fuel :: (_context: *wasmtime_context_t, fuel: *u64) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Configures WASI state within the specified store.
*
* This function is required if #wasmtime_linker_define_wasi is called. This
* will configure the WASI state for instances defined within this store to the
* configuration specified.
*
* This function does not take ownership of `context` but it does take ownership
* of `wasi`. The caller should no longer use `wasi` after calling this function
* (even if an error is returned).
*/
wasmtime_context_set_wasi :: (_context: *wasmtime_context_t, wasi: *wasi_config_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Configures the relative deadline at which point WebAssembly code will
* trap or invoke the callback function.
*
* This function configures the store-local epoch deadline after which point
* WebAssembly code will trap or invoke the callback function.
*
* See also #wasmtime_config_epoch_interruption_set and
* #wasmtime_store_epoch_deadline_callback.
*/
wasmtime_context_set_epoch_deadline :: (_context: *wasmtime_context_t, ticks_beyond_current: u64) -> void #foreign libwasmtime;

/// \brief An enum for the behavior before extending the epoch deadline.
wasmtime_update_deadline_kind_t :: u8;

/**
* \brief Configures epoch deadline callback to C function.
*
* This function configures a store-local callback function that will be
* called when the running WebAssembly function has exceeded its epoch
* deadline. That function can:
* - return a #wasmtime_error_t to terminate the function
* - set the delta argument and return NULL to update the
*   epoch deadline delta and resume function execution.
* - set the delta argument, update the epoch deadline,
*   set update_kind to WASMTIME_UPDATE_DEADLINE_YIELD,
*   and return NULL to yield (via async support) and
*   resume function execution.
*
* To use WASMTIME_UPDATE_DEADLINE_YIELD async support must be enabled
* for this store.
*
* See also #wasmtime_config_epoch_interruption_set and
* #wasmtime_context_set_epoch_deadline.
*/
wasmtime_store_epoch_deadline_callback :: (store: *wasmtime_store_t, func: #type (_context: *wasmtime_context_t, data: *void, epoch_deadline_delta: *u64, update_kind: *wasmtime_update_deadline_kind_t) -> *wasmtime_error_t #c_call, data: *void, finalizer: #type (unknown0: *void) -> void #c_call) -> void #foreign libwasmtime;

/// \brief Representation of a function in Wasmtime.
///
/// Functions in Wasmtime are represented as an index into a store and don't
/// have any data or destructor associated with the #wasmtime_func_t value.
/// Functions cannot interoperate between #wasmtime_store_t instances and if the
/// wrong function is passed to the wrong store then it may trigger an assertion
/// to abort the process.
wasmtime_func :: struct {
    /// Internal identifier of what store this belongs to.
    ///
    /// This field may be zero when used in conjunction with #wasmtime_val_t
    /// to represent a null `funcref` value in WebAssembly. For a valid function
    /// this field is otherwise never zero.
    store_id:  u64;

    /// Private field for Wasmtime, undefined if `store_id` is zero.
    __private: *void;
}

/// \brief Representation of a function in Wasmtime.
///
/// Functions in Wasmtime are represented as an index into a store and don't
/// have any data or destructor associated with the #wasmtime_func_t value.
/// Functions cannot interoperate between #wasmtime_store_t instances and if the
/// wrong function is passed to the wrong store then it may trigger an assertion
/// to abort the process.
wasmtime_func_t :: wasmtime_func;

/// \brief Representation of a table in Wasmtime.
///
/// Tables in Wasmtime are represented as an index into a store and don't
/// have any data or destructor associated with the #wasmtime_table_t value.
/// Tables cannot interoperate between #wasmtime_store_t instances and if the
/// wrong table is passed to the wrong store then it may trigger an assertion
/// to abort the process.
wasmtime_table :: struct {
    struct {
        /// Internal identifier of what store this belongs to, never zero.
        store_id:   u64;

        /// Private field for Wasmtime.
        __private1: u32;
    }

    /// Private field for Wasmtime.
    __private2: u32;
}

/// \brief Representation of a table in Wasmtime.
///
/// Tables in Wasmtime are represented as an index into a store and don't
/// have any data or destructor associated with the #wasmtime_table_t value.
/// Tables cannot interoperate between #wasmtime_store_t instances and if the
/// wrong table is passed to the wrong store then it may trigger an assertion
/// to abort the process.
wasmtime_table_t :: wasmtime_table;

/// \brief Representation of a memory in Wasmtime.
///
/// Memories in Wasmtime are represented as an index into a store and don't
/// have any data or destructor associated with the #wasmtime_memory_t value.
/// Memories cannot interoperate between #wasmtime_store_t instances and if the
/// wrong memory is passed to the wrong store then it may trigger an assertion
/// to abort the process.
wasmtime_memory :: struct {
    struct {
        /// Internal identifier of what store this belongs to, never zero.
        store_id:   u64;

        /// Private field for Wasmtime.
        __private1: u32;
    }

    /// Private field for Wasmtime.
    __private2: u32;
}

/// \brief Representation of a memory in Wasmtime.
///
/// Memories in Wasmtime are represented as an index into a store and don't
/// have any data or destructor associated with the #wasmtime_memory_t value.
/// Memories cannot interoperate between #wasmtime_store_t instances and if the
/// wrong memory is passed to the wrong store then it may trigger an assertion
/// to abort the process.
wasmtime_memory_t :: wasmtime_memory;

/// \brief Representation of a global in Wasmtime.
///
/// Globals in Wasmtime are represented as an index into a store and don't
/// have any data or destructor associated with the #wasmtime_global_t value.
/// Globals cannot interoperate between #wasmtime_store_t instances and if the
/// wrong global is passed to the wrong store then it may trigger an assertion
/// to abort the process.
wasmtime_global :: struct {
    /// Internal identifier of what store this belongs to, never zero.
    store_id:   u64;

    /// Private field for Wasmtime.
    __private1: u32;

    /// Private field for Wasmtime.
    __private2: u32;

    /// Private field for Wasmtime.
    __private3: u32;
}

/// \brief Representation of a global in Wasmtime.
///
/// Globals in Wasmtime are represented as an index into a store and don't
/// have any data or destructor associated with the #wasmtime_global_t value.
/// Globals cannot interoperate between #wasmtime_store_t instances and if the
/// wrong global is passed to the wrong store then it may trigger an assertion
/// to abort the process.
wasmtime_global_t :: wasmtime_global;

/// \brief Discriminant of #wasmtime_extern_t
wasmtime_extern_kind_t :: u8;

/**
* \typedef wasmtime_extern_union_t
* \brief Convenience alias for #wasmtime_extern_union
*
* \union wasmtime_extern_union
* \brief Container for different kinds of extern items.
*
* This type is contained in #wasmtime_extern_t and contains the payload for the
* various kinds of items an extern wasm item can be.
*/
wasmtime_extern_union :: union {
    /// Field used if #wasmtime_extern_t::kind is #WASMTIME_EXTERN_FUNC
    func:         wasmtime_func_t;

    /// Field used if #wasmtime_extern_t::kind is #WASMTIME_EXTERN_GLOBAL
    global:       wasmtime_global_t;

    /// Field used if #wasmtime_extern_t::kind is #WASMTIME_EXTERN_TABLE
    table:        wasmtime_table_t;

    /// Field used if #wasmtime_extern_t::kind is #WASMTIME_EXTERN_MEMORY
    memory:       wasmtime_memory_t;

    /// Field used if #wasmtime_extern_t::kind is #WASMTIME_EXTERN_SHAREDMEMORY
    sharedmemory: *wasmtime_sharedmemory;
}

/**
* \typedef wasmtime_extern_union_t
* \brief Convenience alias for #wasmtime_extern_union
*
* \union wasmtime_extern_union
* \brief Container for different kinds of extern items.
*
* This type is contained in #wasmtime_extern_t and contains the payload for the
* various kinds of items an extern wasm item can be.
*/
wasmtime_extern_union_t :: wasmtime_extern_union;

/**
* \typedef wasmtime_extern_t
* \brief Convenience alias for #wasmtime_extern_t
*
* \union wasmtime_extern
* \brief Container for different kinds of extern items.
*
* Note that this structure may contain an owned value, namely
* #wasmtime_module_t, depending on the context in which this is used. APIs
* which consume a #wasmtime_extern_t do not take ownership, but APIs that
* return #wasmtime_extern_t require that #wasmtime_extern_delete is called to
* deallocate the value.
*/
wasmtime_extern :: struct {
    /// Discriminant of which field of #of is valid.
    kind: wasmtime_extern_kind_t;

    /// Container for the extern item's value.
    of:   wasmtime_extern_union_t;
}

/**
* \typedef wasmtime_extern_t
* \brief Convenience alias for #wasmtime_extern_t
*
* \union wasmtime_extern
* \brief Container for different kinds of extern items.
*
* Note that this structure may contain an owned value, namely
* #wasmtime_module_t, depending on the context in which this is used. APIs
* which consume a #wasmtime_extern_t do not take ownership, but APIs that
* return #wasmtime_extern_t require that #wasmtime_extern_delete is called to
* deallocate the value.
*/
wasmtime_extern_t :: wasmtime_extern;

/// \brief Deletes a #wasmtime_extern_t.
wasmtime_extern_delete :: (val: *wasmtime_extern_t) -> void #foreign libwasmtime;

/// \brief Returns the type of the #wasmtime_extern_t defined within the given
/// store.
///
/// Does not take ownership of `context` or `val`, but the returned
/// #wasm_externtype_t is an owned value that needs to be deleted.
wasmtime_extern_type :: (_context: *wasmtime_context_t, val: *wasmtime_extern_t) -> *wasm_externtype_t #foreign libwasmtime;

/**
* \typedef wasmtime_anyref_t
* \brief Convenience alias for #wasmtime_anyref
*
* \struct wasmtime_anyref
* \brief A WebAssembly value in the `any` hierarchy of GC types.
*
* This structure represents an `anyref` that WebAssembly can create and
* pass back to the host. The host can also create values to pass to a guest.
*
* Note that this structure does not itself contain the data that it refers to.
* Instead to contains metadata to point back within a #wasmtime_context_t, so
* referencing the internal data requires using a `wasmtime_context_t`.
*
* Anyref values are required to be explicitly unrooted via
* #wasmtime_anyref_unroot to enable them to be garbage-collected.
*
* If you do not unroot the value, *even if you free the corresponding
* Store*, there will be some memory leaked, because GC roots use a
* separate allocation to track liveness.
*
* Null anyref values are represented by this structure and can be tested and
* created with the `wasmtime_anyref_is_null` and `wasmtime_anyref_set_null`
* functions.
*/
wasmtime_anyref :: struct {
    /// Internal metadata tracking within the store, embedders should not
    /// configure or modify these fields.
    store_id:   u64;

    /// Internal to Wasmtime.
    __private1: u32;

    /// Internal to Wasmtime.
    __private2: u32;

    /// Internal to Wasmtime.
    __private3: *void;
}

/**
* \typedef wasmtime_anyref_t
* \brief Convenience alias for #wasmtime_anyref
*
* \struct wasmtime_anyref
* \brief A WebAssembly value in the `any` hierarchy of GC types.
*
* This structure represents an `anyref` that WebAssembly can create and
* pass back to the host. The host can also create values to pass to a guest.
*
* Note that this structure does not itself contain the data that it refers to.
* Instead to contains metadata to point back within a #wasmtime_context_t, so
* referencing the internal data requires using a `wasmtime_context_t`.
*
* Anyref values are required to be explicitly unrooted via
* #wasmtime_anyref_unroot to enable them to be garbage-collected.
*
* If you do not unroot the value, *even if you free the corresponding
* Store*, there will be some memory leaked, because GC roots use a
* separate allocation to track liveness.
*
* Null anyref values are represented by this structure and can be tested and
* created with the `wasmtime_anyref_is_null` and `wasmtime_anyref_set_null`
* functions.
*/
wasmtime_anyref_t :: wasmtime_anyref;

/**
* \brief Creates a new reference pointing to the same data that `anyref`
* points to (depending on the configured collector this might increase a
* reference count or create a new GC root).
*
* The returned reference is stored in `out`.
*/
wasmtime_anyref_clone :: (anyref: *wasmtime_anyref_t, out: *wasmtime_anyref_t) -> void #foreign libwasmtime;

/**
* \brief Unroots the `ref` provided within the `context`.
*
* This API is required to enable the `ref` value provided to be
* garbage-collected. This API itself does not necessarily garbage-collect the
* value, but it's possible to collect it in the future after this.
*
* This may modify `ref` and the contents of `ref` are left in an undefined
* state after this API is called and it should no longer be used.
*
* Note that null or i32 anyref values do not need to be unrooted but are still
* valid to pass to this function.
*/
wasmtime_anyref_unroot :: (ref: *wasmtime_anyref_t) -> void #foreign libwasmtime;

/**
* \brief Converts a raw `anyref` value coming from #wasmtime_val_raw_t into
* a #wasmtime_anyref_t.
*
* The provided `out` pointer is filled in with a reference converted from
* `raw`.
*/
wasmtime_anyref_from_raw :: (_context: *wasmtime_context_t, raw: u32, out: *wasmtime_anyref_t) -> void #foreign libwasmtime;

/**
* \brief Converts a #wasmtime_anyref_t to a raw value suitable for storing
* into a #wasmtime_val_raw_t.
*
* Note that the returned underlying value is not tracked by Wasmtime's garbage
* collector until it enters WebAssembly. This means that a GC may release the
* context's reference to the raw value, making the raw value invalid within the
* context of the store. Do not perform a GC between calling this function and
* passing it to WebAssembly.
*/
wasmtime_anyref_to_raw :: (_context: *wasmtime_context_t, ref: *wasmtime_anyref_t) -> u32 #foreign libwasmtime;

/**
* \brief Create a new `i31ref` value.
*
* Creates a new `i31ref` value (which is a subtype of `anyref`) and returns a
* pointer to it.
*
* If `i31val` does not fit in 31 bits, it is wrapped.
*/
wasmtime_anyref_from_i31 :: (_context: *wasmtime_context_t, i31val: u32, out: *wasmtime_anyref_t) -> void #foreign libwasmtime;

/**
* \brief Get the `anyref`'s underlying `i31ref` value, zero extended, if any.
*
* If the given `anyref` is an instance of `i31ref`, then its value is zero
* extended to 32 bits, written to `dst`, and `true` is returned.
*
* If the given `anyref` is not an instance of `i31ref`, then `false` is
* returned and `dst` is left unmodified.
*/
wasmtime_anyref_i31_get_u :: (_context: *wasmtime_context_t, anyref: *wasmtime_anyref_t, dst: *u32) -> bool #foreign libwasmtime;

/**
* \brief Get the `anyref`'s underlying `i31ref` value, sign extended, if any.
*
* If the given `anyref` is an instance of `i31ref`, then its value is sign
* extended to 32 bits, written to `dst`, and `true` is returned.
*
* If the given `anyref` is not an instance of `i31ref`, then `false` is
* returned and `dst` is left unmodified.
*/
wasmtime_anyref_i31_get_s :: (_context: *wasmtime_context_t, anyref: *wasmtime_anyref_t, dst: *s32) -> bool #foreign libwasmtime;

/**
* \typedef wasmtime_externref_t
* \brief Convenience alias for #wasmtime_externref
*
* \struct wasmtime_externref
* \brief A host-defined un-forgeable reference to pass into WebAssembly.
*
* This structure represents an `externref` that can be passed to WebAssembly.
* It cannot be forged by WebAssembly itself and is guaranteed to have been
* created by the host.
*
* This structure is similar to #wasmtime_anyref_t but represents the
* `externref` type in WebAssembly. This can be created on the host from
* arbitrary host pointers/destructors. Note that this value is itself a
* reference into a #wasmtime_context_t and must be explicitly unrooted to
* enable garbage collection.
*
* Note that null is represented with this structure and created with
* `wasmtime_externref_set_null`. Null can be tested for with the
* `wasmtime_externref_is_null` function.
*/
wasmtime_externref :: struct {
    /// Internal metadata tracking within the store, embedders should not
    /// configure or modify these fields.
    store_id:   u64;

    /// Internal to Wasmtime.
    __private1: u32;

    /// Internal to Wasmtime.
    __private2: u32;

    /// Internal to Wasmtime.
    __private3: *void;
}

/**
* \typedef wasmtime_externref_t
* \brief Convenience alias for #wasmtime_externref
*
* \struct wasmtime_externref
* \brief A host-defined un-forgeable reference to pass into WebAssembly.
*
* This structure represents an `externref` that can be passed to WebAssembly.
* It cannot be forged by WebAssembly itself and is guaranteed to have been
* created by the host.
*
* This structure is similar to #wasmtime_anyref_t but represents the
* `externref` type in WebAssembly. This can be created on the host from
* arbitrary host pointers/destructors. Note that this value is itself a
* reference into a #wasmtime_context_t and must be explicitly unrooted to
* enable garbage collection.
*
* Note that null is represented with this structure and created with
* `wasmtime_externref_set_null`. Null can be tested for with the
* `wasmtime_externref_is_null` function.
*/
wasmtime_externref_t :: wasmtime_externref;

/**
* \brief Create a new `externref` value.
*
* Creates a new `externref` value wrapping the provided data, returning whether
* it was created or not.
*
* \param context the store context to allocate this externref within
* \param data the host-specific data to wrap
* \param finalizer an optional finalizer for `data`
* \param out where to store the created value.
*
* When the reference is reclaimed, the wrapped data is cleaned up with the
* provided `finalizer`.
*
* If `true` is returned then `out` has been filled in and must be unrooted
* in the future with #wasmtime_externref_unroot. If `false` is returned then
* the host wasn't able to create more GC values at this time. Performing a GC
* may free up enough space to try again.
*
* If you do not unroot the value, *even if you free the corresponding
* Store*, there will be some memory leaked, because GC roots use a
* separate allocation to track liveness.
*/
wasmtime_externref_new :: (_context: *wasmtime_context_t, data: *void, finalizer: #type (unknown0: *void) -> void #c_call, out: *wasmtime_externref_t) -> bool #foreign libwasmtime;

/**
* \brief Get an `externref`'s wrapped data
*
* Returns the original `data` passed to #wasmtime_externref_new. It is required
* that `data` is not `NULL`.
*/
wasmtime_externref_data :: (_context: *wasmtime_context_t, data: *wasmtime_externref_t) -> *void #foreign libwasmtime;

/**
* \brief Creates a new reference pointing to the same data that `ref` points
* to (depending on the configured collector this might increase a reference
* count or create a new GC root).
*
* The `out` parameter stores the cloned reference. This reference must
* eventually be unrooted with #wasmtime_externref_unroot in the future to
* enable GC'ing it.
*/
wasmtime_externref_clone :: (ref: *wasmtime_externref_t, out: *wasmtime_externref_t) -> void #foreign libwasmtime;

/**
* \brief Unroots the pointer `ref` from the `context` provided.
*
* This function will enable future garbage collection of the value pointed to
* by `ref` once there are no more references. The `ref` value may be mutated in
* place by this function and its contents are undefined after this function
* returns. It should not be used until after re-initializing it.
*
* Note that null externref values do not need to be unrooted but are still
* valid to pass to this function.
*/
wasmtime_externref_unroot :: (ref: *wasmtime_externref_t) -> void #foreign libwasmtime;

/**
* \brief Converts a raw `externref` value coming from #wasmtime_val_raw_t into
* a #wasmtime_externref_t.
*
* The `out` reference is filled in with the non-raw version of this externref.
* It must eventually be unrooted with #wasmtime_externref_unroot.
*/
wasmtime_externref_from_raw :: (_context: *wasmtime_context_t, raw: u32, out: *wasmtime_externref_t) -> void #foreign libwasmtime;

/**
* \brief Converts a #wasmtime_externref_t to a raw value suitable for storing
* into a #wasmtime_val_raw_t.
*
* Note that the returned underlying value is not tracked by Wasmtime's garbage
* collector until it enters WebAssembly. This means that a GC may release the
* context's reference to the raw value, making the raw value invalid within the
* context of the store. Do not perform a GC between calling this function and
* passing it to WebAssembly.
*/
wasmtime_externref_to_raw :: (_context: *wasmtime_context_t, ref: *wasmtime_externref_t) -> u32 #foreign libwasmtime;

/// \brief Discriminant stored in #wasmtime_val::kind
wasmtime_valkind_t :: u8;

/// \brief A 128-bit value representing the WebAssembly `v128` type. Bytes are
/// stored in little-endian order.
wasmtime_v128 :: [16] u8;

/**
* \typedef wasmtime_valunion_t
* \brief Convenience alias for #wasmtime_valunion
*
* \union wasmtime_valunion
* \brief Container for different kinds of wasm values.
*
* This type is contained in #wasmtime_val_t and contains the payload for the
* various kinds of items a value can be.
*/
wasmtime_valunion :: union {
    /// Field used if #wasmtime_val_t::kind is #WASMTIME_I32
    i32:       s32;

    /// Field used if #wasmtime_val_t::kind is #WASMTIME_I64
    i64:       s64;

    /// Field used if #wasmtime_val_t::kind is #WASMTIME_F32
    f32:       float32_t;

    /// Field used if #wasmtime_val_t::kind is #WASMTIME_F64
    f64:       float64_t;

    /// Field used if #wasmtime_val_t::kind is #WASMTIME_ANYREF
    anyref:    wasmtime_anyref_t;

    /// Field used if #wasmtime_val_t::kind is #WASMTIME_EXTERNREF
    externref: wasmtime_externref_t;

    /// Field used if #wasmtime_val_t::kind is #WASMTIME_FUNCREF
    ///
    /// Use `wasmtime_funcref_is_null` to test whether this is a null function
    /// reference.
    funcref:   wasmtime_func_t;

    /// Field used if #wasmtime_val_t::kind is #WASMTIME_V128
    _v128:     wasmtime_v128;
}

/**
* \typedef wasmtime_valunion_t
* \brief Convenience alias for #wasmtime_valunion
*
* \union wasmtime_valunion
* \brief Container for different kinds of wasm values.
*
* This type is contained in #wasmtime_val_t and contains the payload for the
* various kinds of items a value can be.
*/
wasmtime_valunion_t :: wasmtime_valunion;

/**
* \typedef wasmtime_val_raw_t
* \brief Convenience alias for #wasmtime_val_raw
*
* \union wasmtime_val_raw
* \brief Container for possible wasm values.
*
* This type is used on conjunction with #wasmtime_func_new_unchecked as well
* as #wasmtime_func_call_unchecked. Instances of this type do not have type
* information associated with them, it's up to the embedder to figure out
* how to interpret the bits contained within, often using some other channel
* to determine the type.
*/
wasmtime_val_raw :: union {
    /// Field for when this val is a WebAssembly `i32` value.
    ///
    /// Note that this field is always stored in a little-endian format.
    i32:       s32;

    /// Field for when this val is a WebAssembly `i64` value.
    ///
    /// Note that this field is always stored in a little-endian format.
    i64:       s64;

    /// Field for when this val is a WebAssembly `f32` value.
    ///
    /// Note that this field is always stored in a little-endian format.
    f32:       float32_t;

    /// Field for when this val is a WebAssembly `f64` value.
    ///
    /// Note that this field is always stored in a little-endian format.
    f64:       float64_t;

    /// Field for when this val is a WebAssembly `v128` value.
    ///
    /// Note that this field is always stored in a little-endian format.
    _v128:     wasmtime_v128;

    /// Field for when this val is a WebAssembly `anyref` value.
    ///
    /// If this is set to 0 then it's a null anyref, otherwise this must be
    /// passed to `wasmtime_anyref_from_raw` to determine the
    /// `wasmtime_anyref_t`.
    ///
    /// Note that this field is always stored in a little-endian format.
    anyref:    u32;

    /// Field for when this val is a WebAssembly `externref` value.
    ///
    /// If this is set to 0 then it's a null externref, otherwise this must be
    /// passed to `wasmtime_externref_from_raw` to determine the
    /// `wasmtime_externref_t`.
    ///
    /// Note that this field is always stored in a little-endian format.
    externref: u32;

    /// Field for when this val is a WebAssembly `funcref` value.
    ///
    /// If this is set to 0 then it's a null funcref, otherwise this must be
    /// passed to `wasmtime_func_from_raw` to determine the `wasmtime_func_t`.
    ///
    /// Note that this field is always stored in a little-endian format.
    funcref:   *void;
}

/**
* \typedef wasmtime_val_raw_t
* \brief Convenience alias for #wasmtime_val_raw
*
* \union wasmtime_val_raw
* \brief Container for possible wasm values.
*
* This type is used on conjunction with #wasmtime_func_new_unchecked as well
* as #wasmtime_func_call_unchecked. Instances of this type do not have type
* information associated with them, it's up to the embedder to figure out
* how to interpret the bits contained within, often using some other channel
* to determine the type.
*/
wasmtime_val_raw_t :: wasmtime_val_raw;

/**
* \typedef wasmtime_val_t
* \brief Convenience alias for #wasmtime_val_t
*
* \union wasmtime_val
* \brief Container for different kinds of wasm values.
*
* Note that this structure may contain an owned value, namely rooted GC
* references, depending on the context in which this is used. APIs which
* consume a #wasmtime_val_t do not take ownership, but APIs that return
* #wasmtime_val_t require that #wasmtime_val_unroot is called to clean up
* any possible GC roots in the value.
*
* If you do not unroot the value, *even if you free the corresponding
* Store*, there will be some memory leaked, because GC roots use a
* separate allocation to track liveness.
*/
wasmtime_val :: struct {
    /// Discriminant of which field of #of is valid.
    kind: wasmtime_valkind_t;

    /// Container for the extern item's value.
    of:   wasmtime_valunion_t;
}

/**
* \typedef wasmtime_val_t
* \brief Convenience alias for #wasmtime_val_t
*
* \union wasmtime_val
* \brief Container for different kinds of wasm values.
*
* Note that this structure may contain an owned value, namely rooted GC
* references, depending on the context in which this is used. APIs which
* consume a #wasmtime_val_t do not take ownership, but APIs that return
* #wasmtime_val_t require that #wasmtime_val_unroot is called to clean up
* any possible GC roots in the value.
*
* If you do not unroot the value, *even if you free the corresponding
* Store*, there will be some memory leaked, because GC roots use a
* separate allocation to track liveness.
*/
wasmtime_val_t :: wasmtime_val;

/**
* \brief Unroot the value contained by `val`.
*
* This function will unroot any GC references that `val` points to, for
* example if it has the `WASMTIME_EXTERNREF` or `WASMTIME_ANYREF` kinds. This
* function leaves `val` in an undefined state and it should not be used again
* without re-initializing.
*
* This method does not need to be called for integers, floats, v128, or
* funcref values.
*/
wasmtime_val_unroot :: (val: *wasmtime_val_t) -> void #foreign libwasmtime;

/**
* \brief Clones the value pointed to by `src` into the `dst` provided.
*
* This function will clone any rooted GC values in `src` and have them
* newly rooted inside of `dst`. When using this API the `dst` should be
* later unrooted with #wasmtime_val_unroot if it contains GC values.
*/
wasmtime_val_clone :: (src: *wasmtime_val_t, dst: *wasmtime_val_t) -> void #foreign libwasmtime;

wasmtime_caller :: struct {}
/**
* \typedef wasmtime_caller_t
* \brief Alias to #wasmtime_caller
*
* \brief Structure used to learn about the caller of a host-defined function.
* \struct wasmtime_caller
*
* This structure is an argument to #wasmtime_func_callback_t. The purpose
* of this structure is acquire a #wasmtime_context_t pointer to interact with
* objects, but it can also be used for inspect the state of the caller (such as
* getting memories and functions) with #wasmtime_caller_export_get.
*
* This object is never owned and does not need to be deleted.
*/
wasmtime_caller_t :: wasmtime_caller;

/**
* \brief Callback signature for #wasmtime_func_new.
*
* This is the function signature for host functions that can be made accessible
* to WebAssembly. The arguments to this function are:
*
* \param env user-provided argument passed to #wasmtime_func_new
* \param caller a temporary object that can only be used during this function
* call. Used to acquire #wasmtime_context_t or caller's state
* \param args the arguments provided to this function invocation
* \param nargs how many arguments are provided
* \param results where to write the results of this function
* \param nresults how many results must be produced
*
* Callbacks are guaranteed to get called with the right types of arguments, but
* they must produce the correct number and types of results. Failure to do so
* will cause traps to get raised on the wasm side.
*
* This callback can optionally return a #wasm_trap_t indicating that a trap
* should be raised in WebAssembly. It's expected that in this case the caller
* relinquishes ownership of the trap and it is passed back to the engine.
*/
wasmtime_func_callback_t :: #type (env: *void, caller: *wasmtime_caller_t, args: *wasmtime_val_t, nargs: u64, results: *wasmtime_val_t, nresults: u64) -> *wasm_trap_t #c_call;

/**
* \brief Creates a new host-defined function.
*
* Inserts a host-defined function into the `store` provided which can be used
* to then instantiate a module with or define within a #wasmtime_linker_t.
*
* \param store the store in which to create the function
* \param type the wasm type of the function that's being created
* \param callback the host-defined callback to invoke
* \param env host-specific data passed to the callback invocation, can be
* `NULL`
* \param finalizer optional finalizer for `env`, can be `NULL`
* \param ret the #wasmtime_func_t return value to be filled in.
*
* The returned function can only be used with the specified `store`.
*/
wasmtime_func_new :: (store: *wasmtime_context_t, type: *wasm_functype_t, callback: wasmtime_func_callback_t, env: *void, finalizer: #type (unknown0: *void) -> void #c_call, ret: *wasmtime_func_t) -> void #foreign libwasmtime;

/**
* \brief Callback signature for #wasmtime_func_new_unchecked.
*
* This is the function signature for host functions that can be made accessible
* to WebAssembly. The arguments to this function are:
*
* \param env user-provided argument passed to #wasmtime_func_new_unchecked
* \param caller a temporary object that can only be used during this function
*        call. Used to acquire #wasmtime_context_t or caller's state
* \param args_and_results storage space for both the parameters to the
*        function as well as the results of the function. The size of this
*        array depends on the function type that the host function is created
*        with, but it will be the maximum of the number of parameters and
*        number of results.
* \param num_args_and_results the size of the `args_and_results` parameter in
*        units of #wasmtime_val_raw_t.
*
* This callback can optionally return a #wasm_trap_t indicating that a trap
* should be raised in WebAssembly. It's expected that in this case the caller
* relinquishes ownership of the trap and it is passed back to the engine.
*
* This differs from #wasmtime_func_callback_t in that the payload of
* `args_and_results` does not have type information, nor does it have sizing
* information. This is especially unsafe because it's only valid within the
* particular #wasm_functype_t that the function was created with. The onus is
* on the embedder to ensure that `args_and_results` are all read correctly
* for parameters and all written for results within the execution of a
* function.
*
* Parameters will be listed starting at index 0 in the `args_and_results`
* array. Results are also written starting at index 0, which will overwrite
* the arguments.
*/
wasmtime_func_unchecked_callback_t :: #type (env: *void, caller: *wasmtime_caller_t, args_and_results: *wasmtime_val_raw_t, num_args_and_results: u64) -> *wasm_trap_t #c_call;

/**
* \brief Creates a new host function in the same manner of #wasmtime_func_new,
*        but the function-to-call has no type information available at runtime.
*
* This function is very similar to #wasmtime_func_new. The difference is that
* this version is "more unsafe" in that when the host callback is invoked there
* is no type information and no checks that the right types of values are
* produced. The onus is on the consumer of this API to ensure that all
* invariants are upheld such as:
*
* * The host callback reads parameters correctly and interprets their types
*   correctly.
* * If a trap doesn't happen then all results are written to the results
*   pointer. All results must have the correct type.
* * Types such as `funcref` cannot cross stores.
* * Types such as `externref` have valid reference counts.
*
* It's generally only recommended to use this if your application can wrap
* this in a safe embedding. This should not be frequently used due to the
* number of invariants that must be upheld on the wasm<->host boundary. On the
* upside, though, this flavor of host function will be faster to call than
* those created by #wasmtime_func_new (hence the reason for this function's
* existence).
*/
wasmtime_func_new_unchecked :: (store: *wasmtime_context_t, type: *wasm_functype_t, callback: wasmtime_func_unchecked_callback_t, env: *void, finalizer: #type (unknown0: *void) -> void #c_call, ret: *wasmtime_func_t) -> void #foreign libwasmtime;

/**
* \brief Returns the type of the function specified
*
* The returned #wasm_functype_t is owned by the caller.
*/
wasmtime_func_type :: (store: *wasmtime_context_t, func: *wasmtime_func_t) -> *wasm_functype_t #foreign libwasmtime;

/**
* \brief Call a WebAssembly function.
*
* This function is used to invoke a function defined within a store. For
* example this might be used after extracting a function from a
* #wasmtime_instance_t.
*
* \param store the store which owns `func`
* \param func the function to call
* \param args the arguments to the function call
* \param nargs the number of arguments provided
* \param results where to write the results of the function call
* \param nresults the number of results expected
* \param trap where to store a trap, if one happens.
*
* There are three possible return states from this function:
*
* 1. The returned error is non-null. This means `results`
*    wasn't written to and `trap` will have `NULL` written to it. This state
*    means that programmer error happened when calling the function, for
*    example when the size of the arguments/results was wrong, the types of the
*    arguments were wrong, or arguments may come from the wrong store.
* 2. The trap pointer is filled in. This means the returned error is `NULL` and
*    `results` was not written to. This state means that the function was
*    executing but hit a wasm trap while executing.
* 3. The error and trap returned are both `NULL` and `results` are written to.
*    This means that the function call succeeded and the specified results were
*    produced.
*
* The `trap` pointer cannot be `NULL`. The `args` and `results` pointers may be
* `NULL` if the corresponding length is zero.
*
* Does not take ownership of #wasmtime_val_t arguments. Gives ownership of
* #wasmtime_val_t results.
*/
wasmtime_func_call :: (store: *wasmtime_context_t, func: *wasmtime_func_t, args: *wasmtime_val_t, nargs: u64, results: *wasmtime_val_t, nresults: u64, trap: **wasm_trap_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Call a WebAssembly function in an "unchecked" fashion.
*
* This function is similar to #wasmtime_func_call except that there is no type
* information provided with the arguments (or sizing information). Consequently
* this is less safe to call since it's up to the caller to ensure that `args`
* has an appropriate size and all the parameters are configured with their
* appropriate values/types. Additionally all the results must be interpreted
* correctly if this function returns successfully.
*
* Parameters must be specified starting at index 0 in the `args_and_results`
* array. Results are written starting at index 0, which will overwrite
* the arguments.
*
* Callers must ensure that various correctness variants are upheld when this
* API is called such as:
*
* * The `args_and_results` pointer has enough space to hold all the parameters
*   and all the results (but not at the same time).
* * The `args_and_results_len` contains the length of the `args_and_results`
*   buffer.
* * Parameters must all be configured as if they were the correct type.
* * Values such as `externref` and `funcref` are valid within the store being
*   called.
*
* When in doubt it's much safer to call #wasmtime_func_call. This function is
* faster than that function, but the tradeoff is that embeddings must uphold
* more invariants rather than relying on Wasmtime to check them for you.
*/
wasmtime_func_call_unchecked :: (store: *wasmtime_context_t, func: *wasmtime_func_t, args_and_results: *wasmtime_val_raw_t, args_and_results_len: u64, trap: **wasm_trap_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Loads a #wasmtime_extern_t from the caller's context
*
* This function will attempt to look up the export named `name` on the caller
* instance provided. If it is found then the #wasmtime_extern_t for that is
* returned, otherwise `NULL` is returned.
*
* Note that this only works for exported memories right now for WASI
* compatibility.
*
* \param caller the caller object to look up the export from
* \param name the name that's being looked up
* \param name_len the byte length of `name`
* \param item where to store the return value
*
* Returns a nonzero value if the export was found, or 0 if the export wasn't
* found. If the export wasn't found then `item` isn't written to.
*/
wasmtime_caller_export_get :: (caller: *wasmtime_caller_t, name: *u8, name_len: u64, item: *wasmtime_extern_t) -> bool #foreign libwasmtime;

/**
* \brief Returns the store context of the caller object.
*/
wasmtime_caller_context :: (caller: *wasmtime_caller_t) -> *wasmtime_context_t #foreign libwasmtime;

/**
* \brief Converts a `raw` nonzero `funcref` value from #wasmtime_val_raw_t
* into a #wasmtime_func_t.
*
* This function can be used to interpret nonzero values of the `funcref` field
* of the #wasmtime_val_raw_t structure. It is assumed that `raw` does not have
* a value of 0, or otherwise the program will abort.
*
* Note that this function is unchecked and unsafe. It's only safe to pass
* values learned from #wasmtime_val_raw_t with the same corresponding
* #wasmtime_context_t that they were produced from. Providing arbitrary values
* to `raw` here or cross-context values with `context` is UB.
*/
wasmtime_func_from_raw :: (_context: *wasmtime_context_t, raw: *void, ret: *wasmtime_func_t) -> void #foreign libwasmtime;

/**
* \brief Converts a `func`  which belongs to `context` into a `usize`
* parameter that is suitable for insertion into a #wasmtime_val_raw_t.
*/
wasmtime_func_to_raw :: (_context: *wasmtime_context_t, func: *wasmtime_func_t) -> *void #foreign libwasmtime;

/**
* \brief Creates a new global value.
*
* Creates a new host-defined global value within the provided `store`
*
* \param store the store in which to create the global
* \param type the wasm type of the global being created
* \param val the initial value of the global
* \param ret a return pointer for the created global.
*
* This function may return an error if the `val` argument does not match the
* specified type of the global, or if `val` comes from a different store than
* the one provided.
*
* This function does not take ownership of any of its arguments but error is
* owned by the caller.
*/
wasmtime_global_new :: (store: *wasmtime_context_t, type: *wasm_globaltype_t, val: *wasmtime_val_t, ret: *wasmtime_global_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Returns the wasm type of the specified global.
*
* The returned #wasm_globaltype_t is owned by the caller.
*/
wasmtime_global_type :: (store: *wasmtime_context_t, global: *wasmtime_global_t) -> *wasm_globaltype_t #foreign libwasmtime;

/**
* \brief Get the value of the specified global.
*
* \param store the store that owns `global`
* \param global the global to get
* \param out where to store the value in this global.
*
* This function returns ownership of the contents of `out`, so
* #wasmtime_val_unroot may need to be called on the value.
*/
wasmtime_global_get :: (store: *wasmtime_context_t, global: *wasmtime_global_t, out: *wasmtime_val_t) -> void #foreign libwasmtime;

/**
* \brief Sets a global to a new value.
*
* \param store the store that owns `global`
* \param global the global to set
* \param val the value to store in the global
*
* This function may return an error if `global` is not mutable or if `val` has
* the wrong type for `global`.
*
* THis does not take ownership of any argument but returns ownership of the
* error.
*/
wasmtime_global_set :: (store: *wasmtime_context_t, global: *wasmtime_global_t, val: *wasmtime_val_t) -> *wasmtime_error_t #foreign libwasmtime;

/// \brief Representation of a instance in Wasmtime.
///
/// Instances are represented with a 64-bit identifying integer in Wasmtime.
/// They do not have any destructor associated with them. Instances cannot
/// interoperate between #wasmtime_store_t instances and if the wrong instance
/// is passed to the wrong store then it may trigger an assertion to abort the
/// process.
wasmtime_instance :: struct {
    /// Internal identifier of what store this belongs to, never zero.
    store_id:  u64;

    /// Private data for use in Wasmtime.
    __private: u64;
}

/// \brief Representation of a instance in Wasmtime.
///
/// Instances are represented with a 64-bit identifying integer in Wasmtime.
/// They do not have any destructor associated with them. Instances cannot
/// interoperate between #wasmtime_store_t instances and if the wrong instance
/// is passed to the wrong store then it may trigger an assertion to abort the
/// process.
wasmtime_instance_t :: wasmtime_instance;

/**
* \brief Instantiate a wasm module.
*
* This function will instantiate a WebAssembly module with the provided
* imports, creating a WebAssembly instance. The returned instance can then
* afterwards be inspected for exports.
*
* \param store the store in which to create the instance
* \param module the module that's being instantiated
* \param imports the imports provided to the module
* \param nimports the size of `imports`
* \param instance where to store the returned instance
* \param trap where to store the returned trap
*
* This function requires that `imports` is the same size as the imports that
* `module` has. Additionally the `imports` array must be 1:1 lined up with the
* imports of the `module` specified. This is intended to be relatively low
* level, and #wasmtime_linker_instantiate is provided for a more ergonomic
* name-based resolution API.
*
* The states of return values from this function are similar to
* #wasmtime_func_call where an error can be returned meaning something like a
* link error in this context. A trap can be returned (meaning no error or
* instance is returned), or an instance can be returned (meaning no error or
* trap is returned).
*
* Note that this function requires that all `imports` specified must be owned
* by the `store` provided as well.
*
* This function does not take ownership of any of its arguments, but all return
* values are owned by the caller.
*/
wasmtime_instance_new :: (store: *wasmtime_context_t, module: *wasmtime_module_t, imports: *wasmtime_extern_t, nimports: u64, instance: *wasmtime_instance_t, trap: **wasm_trap_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Get an export by name from an instance.
*
* \param store the store that owns `instance`
* \param instance the instance to lookup within
* \param name the export name to lookup
* \param name_len the byte length of `name`
* \param item where to store the returned value
*
* Returns nonzero if the export was found, and `item` is filled in. Otherwise
* returns 0.
*
* Doesn't take ownership of any arguments but does return ownership of the
* #wasmtime_extern_t.
*/
wasmtime_instance_export_get :: (store: *wasmtime_context_t, instance: *wasmtime_instance_t, name: *u8, name_len: u64, item: *wasmtime_extern_t) -> bool #foreign libwasmtime;

/**
* \brief Get an export by index from an instance.
*
* \param store the store that owns `instance`
* \param instance the instance to lookup within
* \param index the index to lookup
* \param name where to store the name of the export
* \param name_len where to store the byte length of the name
* \param item where to store the export itself
*
* Returns nonzero if the export was found, and `name`, `name_len`, and `item`
* are filled in. Otherwise returns 0.
*
* Doesn't take ownership of any arguments but does return ownership of the
* #wasmtime_extern_t. The `name` pointer return value is owned by the `store`
* and must be immediately used before calling any other APIs on
* #wasmtime_context_t.
*/
wasmtime_instance_export_nth :: (store: *wasmtime_context_t, instance: *wasmtime_instance_t, index: u64, name: **u8, name_len: *u64, item: *wasmtime_extern_t) -> bool #foreign libwasmtime;

wasmtime_instance_pre :: struct {}
/**
* \brief A #wasmtime_instance_t, pre-instantiation, that is ready to be
* instantiated.
*
* Must be deleted using #wasmtime_instance_pre_delete.
*
* For more information see the Rust documentation:
* https://docs.wasmtime.dev/api/wasmtime/struct.InstancePre.html
*/
wasmtime_instance_pre_t :: wasmtime_instance_pre;

/**
* \brief Delete a previously created wasmtime_instance_pre_t.
*/
wasmtime_instance_pre_delete :: (instance_pre: *wasmtime_instance_pre_t) -> void #foreign libwasmtime;

/**
* \brief Instantiates instance within the given store.
*
* This will also run the function's startup function, if there is one.
*
* For more information on instantiation see #wasmtime_instance_new.
*
* \param instance_pre the pre-initialized instance
* \param store the store in which to create the instance
* \param instance where to store the returned instance
* \param trap_ptr where to store the returned trap
*
* \return One of three things can happen as a result of this function. First
* the module could be successfully instantiated and returned through
* `instance`, meaning the return value and `trap` are both set to `NULL`.
* Second the start function may trap, meaning the return value and `instance`
* are set to `NULL` and `trap` describes the trap that happens. Finally
* instantiation may fail for another reason, in which case an error is returned
* and `trap` and `instance` are set to `NULL`.
*
* This function does not take ownership of any of its arguments, and all return
* values are owned by the caller.
*/
wasmtime_instance_pre_instantiate :: (instance_pre: *wasmtime_instance_pre_t, store: *wasmtime_context_t, instance: *wasmtime_instance_t, trap_ptr: **wasm_trap_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Get the module (as a shallow clone) for a instance_pre.
*
* The returned module is owned by the caller and the caller **must**
* delete it via `wasmtime_module_delete`.
*/
wasmtime_instance_pre_module :: (instance_pre: *wasmtime_instance_pre_t) -> *wasmtime_module_t #foreign libwasmtime;

wasmtime_linker :: struct {}
/**
* \typedef wasmtime_linker_t
* \brief Alias to #wasmtime_linker
*
* \struct #wasmtime_linker
* \brief Object used to conveniently link together and instantiate wasm
* modules.
*
* This type corresponds to the `wasmtime::Linker` type in Rust. This
* type is intended to make it easier to manage a set of modules that link
* together, or to make it easier to link WebAssembly modules to WASI.
*
* A #wasmtime_linker_t is a higher level way to instantiate a module than
* #wasm_instance_new since it works at the "string" level of imports rather
* than requiring 1:1 mappings.
*/
wasmtime_linker_t :: wasmtime_linker;

/**
* \brief Creates a new linker for the specified engine.
*
* This function does not take ownership of the engine argument, and the caller
* is expected to delete the returned linker.
*/
wasmtime_linker_new :: (engine: *wasm_engine_t) -> *wasmtime_linker_t #foreign libwasmtime;

/**
* \brief Clones existing linker.
*
* This function does not take ownership of the linker argument, and the caller
* is expected to delete the returned linker.
*/
wasmtime_linker_clone :: (linker: *wasmtime_linker_t) -> *wasmtime_linker_t #foreign libwasmtime;

/**
* \brief Deletes a linker
*/
wasmtime_linker_delete :: (linker: *wasmtime_linker_t) -> void #foreign libwasmtime;

/**
* \brief Configures whether this linker allows later definitions to shadow
* previous definitions.
*
* By default this setting is `false`.
*/
wasmtime_linker_allow_shadowing :: (linker: *wasmtime_linker_t, allow_shadowing: bool) -> void #foreign libwasmtime;

/**
* \brief Ensures that `module` can be instantiated with this linker by defining
* all functions otherwise missing from this linker to trap.
*/
wasmtime_linker_define_unknown_imports_as_traps :: (linker: *wasmtime_linker_t, module: *wasmtime_module_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Ensures that `module` can be instantiated with this linker by defining
* all functions otherwise missing from this linker to return the 'default' for
* what that import is.
*/
wasmtime_linker_define_unknown_imports_as_default_values :: (linker: *wasmtime_linker_t, store: *wasmtime_context_t, module: *wasmtime_module_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Defines a new item in this linker.
*
* \param linker the linker the name is being defined in.
* \param store the store that the `item` is owned by.
* \param module the module name the item is defined under.
* \param module_len the byte length of `module`
* \param name the field name the item is defined under
* \param name_len the byte length of `name`
* \param item the item that is being defined in this linker.
*
* \return On success `NULL` is returned, otherwise an error is returned which
* describes why the definition failed.
*
* For more information about name resolution consult the [Rust
* documentation](https://bytecodealliance.github.io/wasmtime/api/wasmtime/struct.Linker.html#name-resolution).
*/
wasmtime_linker_define :: (linker: *wasmtime_linker_t, store: *wasmtime_context_t, module: *u8, module_len: u64, name: *u8, name_len: u64, item: *wasmtime_extern_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Defines a new function in this linker.
*
* \param linker the linker the name is being defined in.
* \param module the module name the item is defined under.
* \param module_len the byte length of `module`
* \param name the field name the item is defined under
* \param name_len the byte length of `name`
* \param ty the type of the function that's being defined
* \param cb the host callback to invoke when the function is called
* \param data the host-provided data to provide as the first argument to the
*        callback
* \param finalizer an optional finalizer for the `data` argument.
*
* \return On success `NULL` is returned, otherwise an error is returned which
* describes why the definition failed.
*
* For more information about name resolution consult the [Rust
* documentation](https://bytecodealliance.github.io/wasmtime/api/wasmtime/struct.Linker.html#name-resolution).
*
* Note that this function does not create a #wasmtime_func_t. This creates a
* store-independent function within the linker, allowing this function
* definition to be used with multiple stores.
*
* For more information about host callbacks see #wasmtime_func_new.
*/
wasmtime_linker_define_func :: (linker: *wasmtime_linker_t, module: *u8, module_len: u64, name: *u8, name_len: u64, ty: *wasm_functype_t, cb: wasmtime_func_callback_t, data: *void, finalizer: #type (unknown0: *void) -> void #c_call) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Defines a new function in this linker.
*
* This is the same as #wasmtime_linker_define_func except that it's the analog
* of #wasmtime_func_new_unchecked instead of #wasmtime_func_new. Be sure to
* consult the documentation of #wasmtime_linker_define_func for argument
* information as well as #wasmtime_func_new_unchecked for why this is an
* unsafe API.
*/
wasmtime_linker_define_func_unchecked :: (linker: *wasmtime_linker_t, module: *u8, module_len: u64, name: *u8, name_len: u64, ty: *wasm_functype_t, cb: wasmtime_func_unchecked_callback_t, data: *void, finalizer: #type (unknown0: *void) -> void #c_call) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Defines WASI functions in this linker.
*
* \param linker the linker the name is being defined in.
*
* \return On success `NULL` is returned, otherwise an error is returned which
* describes why the definition failed.
*
* This function will provide WASI function names in the specified linker. Note
* that when an instance is created within a store then the store also needs to
* have its WASI settings configured with #wasmtime_context_set_wasi for WASI
* functions to work, otherwise an assert will be tripped that will abort the
* process.
*
* For more information about name resolution consult the [Rust
* documentation](https://bytecodealliance.github.io/wasmtime/api/wasmtime/struct.Linker.html#name-resolution).
*/
wasmtime_linker_define_wasi :: (linker: *wasmtime_linker_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Defines an instance under the specified name in this linker.
*
* \param linker the linker the name is being defined in.
* \param store the store that owns `instance`
* \param name the module name to define `instance` under.
* \param name_len the byte length of `name`
* \param instance a previously-created instance.
*
* \return On success `NULL` is returned, otherwise an error is returned which
* describes why the definition failed.
*
* This function will take all of the exports of the `instance` provided and
* defined them under a module called `name` with a field name as the export's
* own name.
*
* For more information about name resolution consult the [Rust
* documentation](https://bytecodealliance.github.io/wasmtime/api/wasmtime/struct.Linker.html#name-resolution).
*/
wasmtime_linker_define_instance :: (linker: *wasmtime_linker_t, store: *wasmtime_context_t, name: *u8, name_len: u64, instance: *wasmtime_instance_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Instantiates a #wasm_module_t with the items defined in this linker.
*
* \param linker the linker used to instantiate the provided module.
* \param store the store that is used to instantiate within
* \param module the module that is being instantiated.
* \param instance the returned instance, if successful.
* \param trap a trap returned, if the start function traps.
*
* \return One of three things can happen as a result of this function. First
* the module could be successfully instantiated and returned through
* `instance`, meaning the return value and `trap` are both set to `NULL`.
* Second the start function may trap, meaning the return value and `instance`
* are set to `NULL` and `trap` describes the trap that happens. Finally
* instantiation may fail for another reason, in which case an error is returned
* and `trap` and `instance` are set to `NULL`.
*
* This function will attempt to satisfy all of the imports of the `module`
* provided with items previously defined in this linker. If any name isn't
* defined in the linker than an error is returned. (or if the previously
* defined item is of the wrong type).
*/
wasmtime_linker_instantiate :: (linker: *wasmtime_linker_t, store: *wasmtime_context_t, module: *wasmtime_module_t, instance: *wasmtime_instance_t, trap: **wasm_trap_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Defines automatic instantiations of a #wasm_module_t in this linker.
*
* \param linker the linker the module is being added to
* \param store the store that is used to instantiate `module`
* \param name the name of the module within the linker
* \param name_len the byte length of `name`
* \param module the module that's being instantiated
*
* \return An error if the module could not be instantiated or added or `NULL`
* on success.
*
* This function automatically handles [Commands and
* Reactors](https://github.com/WebAssembly/WASI/blob/main/legacy/application-abi.md#current-unstable-abi)
* instantiation and initialization.
*
* For more information see the [Rust
* documentation](https://bytecodealliance.github.io/wasmtime/api/wasmtime/struct.Linker.html#method.module).
*/
wasmtime_linker_module :: (linker: *wasmtime_linker_t, store: *wasmtime_context_t, name: *u8, name_len: u64, module: *wasmtime_module_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Acquires the "default export" of the named module in this linker.
*
* \param linker the linker to load from
* \param store the store to load a function into
* \param name the name of the module to get the default export for
* \param name_len the byte length of `name`
* \param func where to store the extracted default function.
*
* \return An error is returned if the default export could not be found, or
* `NULL` is returned and `func` is filled in otherwise.
*
* For more information see the [Rust
* documentation](https://bytecodealliance.github.io/wasmtime/api/wasmtime/struct.Linker.html#method.get_default).
*/
wasmtime_linker_get_default :: (linker: *wasmtime_linker_t, store: *wasmtime_context_t, name: *u8, name_len: u64, func: *wasmtime_func_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Loads an item by name from this linker.
*
* \param linker the linker to load from
* \param store the store to load the item into
* \param module the name of the module to get
* \param module_len the byte length of `module`
* \param name the name of the field to get
* \param name_len the byte length of `name`
* \param item where to store the extracted item
*
* \return A nonzero value if the item is defined, in which case `item` is also
* filled in. Otherwise zero is returned.
*/
wasmtime_linker_get :: (linker: *wasmtime_linker_t, store: *wasmtime_context_t, module: *u8, module_len: u64, name: *u8, name_len: u64, item: *wasmtime_extern_t) -> bool #foreign libwasmtime;

/**
* \brief Perform all the checks for instantiating `module` with the linker,
*        except that instantiation doesn't actually finish.
*
* \param linker the linker used to instantiate the provided module.
* \param module the module that is being instantiated.
* \param instance_pre the returned instance_pre, if successful.
*
* \return An error or `NULL` if successful.
*
* For more information see the Rust documentation at:
* https://docs.wasmtime.dev/api/wasmtime/struct.Linker.html#method.instantiate_pre
*/
wasmtime_linker_instantiate_pre :: (linker: *wasmtime_linker_t, module: *wasmtime_module_t, instance_pre: **wasmtime_instance_pre_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Creates a new memory type from the specified parameters.
*
* Note that this function is preferred over #wasm_memorytype_new for
* compatibility with the memory64 proposal.
*/
wasmtime_memorytype_new :: (min: u64, max_present: bool, max: u64, is_64: bool, shared: bool, page_size_log2: u8, ret: **wasm_memorytype_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Returns the minimum size, in pages, of the specified memory type.
*
* Note that this function is preferred over #wasm_memorytype_limits for
* compatibility with the memory64 proposal.
*/
wasmtime_memorytype_minimum :: (ty: *wasm_memorytype_t) -> u64 #foreign libwasmtime;

/**
* \brief Returns the maximum size, in pages, of the specified memory type.
*
* If this memory type doesn't have a maximum size listed then `false` is
* returned. Otherwise `true` is returned and the `max` pointer is filled in
* with the specified maximum size, in pages.
*
* Note that this function is preferred over #wasm_memorytype_limits for
* compatibility with the memory64 proposal.
*/
wasmtime_memorytype_maximum :: (ty: *wasm_memorytype_t, max: *u64) -> bool #foreign libwasmtime;

/**
* \brief Returns whether this type of memory represents a 64-bit memory.
*/
wasmtime_memorytype_is64 :: (ty: *wasm_memorytype_t) -> bool #foreign libwasmtime;

/**
* \brief Returns whether this type of memory represents a shared memory.
*/
wasmtime_memorytype_isshared :: (ty: *wasm_memorytype_t) -> bool #foreign libwasmtime;

/**
* \brief Returns the page size, in bytes, of this memory type.
*/
wasmtime_memorytype_page_size :: (ty: *wasm_memorytype_t) -> u64 #foreign libwasmtime;

/**
* \brief Returns the log2 of this memory type's page size, in bytes.
*/
wasmtime_memorytype_page_size_log2 :: (ty: *wasm_memorytype_t) -> u8 #foreign libwasmtime;

/**
* \brief Creates a new WebAssembly linear memory
*
* \param store the store to create the memory within
* \param ty the type of the memory to create
* \param ret where to store the returned memory
*
* If an error happens when creating the memory it's returned and owned by the
* caller. If an error happens then `ret` is not filled in.
*/
wasmtime_memory_new :: (store: *wasmtime_context_t, ty: *wasm_memorytype_t, ret: *wasmtime_memory_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Returns the type of the memory specified
*/
wasmtime_memory_type :: (store: *wasmtime_context_t, memory: *wasmtime_memory_t) -> *wasm_memorytype_t #foreign libwasmtime;

/**
* \brief Returns the base pointer in memory where the linear memory starts.
*/
wasmtime_memory_data :: (store: *wasmtime_context_t, memory: *wasmtime_memory_t) -> *u8 #foreign libwasmtime;

/**
* \brief Returns the byte length of this linear memory.
*/
wasmtime_memory_data_size :: (store: *wasmtime_context_t, memory: *wasmtime_memory_t) -> u64 #foreign libwasmtime;

/**
* \brief Returns the length, in WebAssembly pages, of this linear memory
*/
wasmtime_memory_size :: (store: *wasmtime_context_t, memory: *wasmtime_memory_t) -> u64 #foreign libwasmtime;

/**
* \brief Attempts to grow the specified memory by `delta` pages.
*
* \param store the store that owns `memory`
* \param memory the memory to grow
* \param delta the number of pages to grow by
* \param prev_size where to store the previous size of memory
*
* If memory cannot be grown then `prev_size` is left unchanged and an error is
* returned. Otherwise `prev_size` is set to the previous size of the memory, in
* WebAssembly pages, and `NULL` is returned.
*/
wasmtime_memory_grow :: (store: *wasmtime_context_t, memory: *wasmtime_memory_t, delta: u64, prev_size: *u64) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Returns the size of a page, in bytes, for this memory.
*
* \param store the store that owns `memory`
* \param memory the memory to get the page size of
*
* WebAssembly memories are made up of a whole number of pages, so the byte size
* (as returned by #wasmtime_memory_data_size) will always be a multiple of
* their page size. Different Wasm memories may have different page sizes.
*
* By default this is 64KiB (aka `0x10000`, `2**16`, `1<<16`, or `65536`)
* but [the custom-page-sizes proposal] allows opting into a page size of
* `1`. Future extensions might allow any power of two as a page size.
*
* [the custom-page-sizes proposal]:
* https://github.com/WebAssembly/custom-page-sizes
*/
wasmtime_memory_page_size :: (store: *wasmtime_context_t, memory: *wasmtime_memory_t) -> u64 #foreign libwasmtime;

/**
* \brief Returns the log2 of this memory's page size, in bytes.
*
* \param store the store that owns `memory`
* \param memory the memory to get the page size of
*
* WebAssembly memories are made up of a whole number of pages, so the byte size
* (as returned by #wasmtime_memory_data_size) will always be a multiple of
* their page size. Different Wasm memories may have different page sizes.
*
* By default the page size is 64KiB (aka `0x10000`, `2**16`, `1<<16`, or
* `65536`) but [the custom-page-sizes proposal] allows opting into a page
* size of `1`. Future extensions might allow any power of two as a page
* size.
*
* [the custom-page-sizes proposal]:
* https://github.com/WebAssembly/custom-page-sizes
*/
wasmtime_memory_page_size_log2 :: (store: *wasmtime_context_t, memory: *wasmtime_memory_t) -> u8 #foreign libwasmtime;

wasmtime_guestprofiler :: struct {}
/**
* \brief Collects basic profiling data for a single WebAssembly guest.
*
* To use this, you’ll need to arrange to call #wasmtime_guestprofiler_sample at
* regular intervals while the guest is on the stack. The most straightforward
* way to do that is to call it from a callback registered with
* #wasmtime_store_epoch_deadline_callback.
*
* For more information see the Rust documentation at:
* https://docs.wasmtime.dev/api/wasmtime/struct.GuestProfiler.html
*/
wasmtime_guestprofiler_t :: wasmtime_guestprofiler;

/**
* \brief Deletes profiler without finishing it.
*
* \param guestprofiler profiler that is being deleted
*/
wasmtime_guestprofiler_delete :: (guestprofiler: *wasmtime_guestprofiler_t) -> void #foreign libwasmtime;

/**
* \typedef wasmtime_guestprofiler_modules_t
* \brief Alias to #wasmtime_guestprofiler_modules
*
* \struct #wasmtime_guestprofiler_modules
* \brief Tuple of name and module for passing into #wasmtime_guestprofiler_new.
*/
wasmtime_guestprofiler_modules :: struct {
    name: *wasm_name_t; //!< Name recorded in the profile.

    mod:  *wasmtime_module_t; //!< Module that is being allowed to appear in captured stack trace.
}

/**
* \typedef wasmtime_guestprofiler_modules_t
* \brief Alias to #wasmtime_guestprofiler_modules
*
* \struct #wasmtime_guestprofiler_modules
* \brief Tuple of name and module for passing into #wasmtime_guestprofiler_new.
*/
wasmtime_guestprofiler_modules_t :: wasmtime_guestprofiler_modules;

wasmtime_guestprofiler_new :: (engine: *wasm_engine_t, module_name: *wasm_name_t, interval_nanos: u64, modules: *wasmtime_guestprofiler_modules_t, modules_len: u64) -> *wasmtime_guestprofiler_t #foreign libwasmtime;

/**
* \brief Add a sample to the profile.
*
* \param guestprofiler the profiler the sample is being added to
* \param store         store that is being used to collect the backtraces
* \param delta_nanos   CPU time in nanoseconds that was used by this guest
*                      since the previous sample
*
* Zero can be passed as `delta_nanos` if recording CPU usage information
* is not needed.
* This function does not take ownership of the arguments.
*
* For more information see the Rust documentation at:
* https://docs.wasmtime.dev/api/wasmtime/struct.GuestProfiler.html#method.sample
*/
wasmtime_guestprofiler_sample :: (guestprofiler: *wasmtime_guestprofiler_t, store: *wasmtime_store_t, delta_nanos: u64) -> void #foreign libwasmtime;

wasmtime_guestprofiler_finish :: (guestprofiler: *wasmtime_guestprofiler_t, out: *wasm_byte_vec_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Creates a new host-defined wasm table.
*
* \param store the store to create the table within
* \param ty the type of the table to create
* \param init the initial value for this table's elements
* \param table where to store the returned table
*
* This function does not take ownership of any of its parameters, but yields
* ownership of returned error. This function may return an error if the `init`
* value does not match `ty`, for example.
*/
wasmtime_table_new :: (store: *wasmtime_context_t, ty: *wasm_tabletype_t, init: *wasmtime_val_t, table: *wasmtime_table_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Returns the type of this table.
*
* The caller has ownership of the returned #wasm_tabletype_t
*/
wasmtime_table_type :: (store: *wasmtime_context_t, table: *wasmtime_table_t) -> *wasm_tabletype_t #foreign libwasmtime;

/**
* \brief Gets a value in a table.
*
* \param store the store that owns `table`
* \param table the table to access
* \param index the table index to access
* \param val where to store the table's value
*
* This function will attempt to access a table element. If a nonzero value is
* returned then `val` is filled in and is owned by the caller. Otherwise zero
* is returned because the `index` is out-of-bounds.
*/
wasmtime_table_get :: (store: *wasmtime_context_t, table: *wasmtime_table_t, index: u64, val: *wasmtime_val_t) -> bool #foreign libwasmtime;

/**
* \brief Sets a value in a table.
*
* \param store the store that owns `table`
* \param table the table to write to
* \param index the table index to write
* \param value the value to store.
*
* This function will store `value` into the specified index in the table. This
* does not take ownership of any argument but yields ownership of the error.
* This function can fail if `value` has the wrong type for the table, or if
* `index` is out of bounds.
*/
wasmtime_table_set :: (store: *wasmtime_context_t, table: *wasmtime_table_t, index: u64, value: *wasmtime_val_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Returns the size, in elements, of the specified table
*/
wasmtime_table_size :: (store: *wasmtime_context_t, table: *wasmtime_table_t) -> u64 #foreign libwasmtime;

/**
* \brief Grows a table.
*
* \param store the store that owns `table`
* \param table the table to grow
* \param delta the number of elements to grow the table by
* \param init the initial value for new table element slots
* \param prev_size where to store the previous size of the table before growth
*
* This function will attempt to grow the table by `delta` table elements. This
* can fail if `delta` would exceed the maximum size of the table or if `init`
* is the wrong type for this table. If growth is successful then `NULL` is
* returned and `prev_size` is filled in with the previous size of the table, in
* elements, before the growth happened.
*
* This function does not take ownership of any of its arguments.
*/
wasmtime_table_grow :: (store: *wasmtime_context_t, table: *wasmtime_table_t, delta: u64, init: *wasmtime_val_t, prev_size: *u64) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Code of an instruction trap.
*
* See #wasmtime_trap_code_enum for possible values.
*/
wasmtime_trap_code_t :: u8;

/**
* \brief Trap codes for instruction traps.
*/
wasmtime_trap_code_enum :: enum u32 {
    STACK_OVERFLOW                        :: 0;

    MEMORY_OUT_OF_BOUNDS                  :: 1;

    HEAP_MISALIGNED                       :: 2;

    TABLE_OUT_OF_BOUNDS                   :: 3;

    INDIRECT_CALL_TO_NULL                 :: 4;

    BAD_SIGNATURE                         :: 5;

    INTEGER_OVERFLOW                      :: 6;

    INTEGER_DIVISION_BY_ZERO              :: 7;

    BAD_CONVERSION_TO_INTEGER             :: 8;

    UNREACHABLE_CODE_REACHED              :: 9;

    INTERRUPT                             :: 10;

    OUT_OF_FUEL                           :: 11;

    ATOMIC_WAIT_NON_SHARED_MEMORY         :: 12;

    NULL_REFERENCE                        :: 13;

    ARRAY_OUT_OF_BOUNDS                   :: 14;

    ALLOCATION_TOO_LARGE                  :: 15;

    CAST_FAILURE                          :: 16;

    CANNOT_ENTER_COMPONENT                :: 17;

    NO_ASYNC_RESULT                       :: 18;

    UNHANDLED_TAG                         :: 19;

    CONTINUATION_ALREADY_CONSUMED         :: 20;

    DISABLED_OPCODE                       :: 21;

    ASYNC_DEADLOCK                        :: 22;

    CANNOT_LEAVE_COMPONENT                :: 23;

    CANNOT_BLOCK_SYNC_TASK                :: 24;

    INVALID_CHAR                          :: 25;

    DEBUG_ASSERT_STRING_ENCODING_FINISHED :: 26;

    DEBUG_ASSERT_EQUAL_CODE_UNITS         :: 27;

    DEBUG_ASSERT_POINTER_ALIGNED          :: 28;

    DEBUG_ASSERT_UPPER_BITS_UNSET         :: 29;

    STRING_OUT_OF_BOUNDS                  :: 30;

    LIST_OUT_OF_BOUNDS                    :: 31;

    INVALID_DISCRIMINANT                  :: 32;

    UNALIGNED_POINTER                     :: 33;

    WASMTIME_TRAP_CODE_STACK_OVERFLOW                        :: STACK_OVERFLOW;

    WASMTIME_TRAP_CODE_MEMORY_OUT_OF_BOUNDS                  :: MEMORY_OUT_OF_BOUNDS;

    WASMTIME_TRAP_CODE_HEAP_MISALIGNED                       :: HEAP_MISALIGNED;

    WASMTIME_TRAP_CODE_TABLE_OUT_OF_BOUNDS                   :: TABLE_OUT_OF_BOUNDS;

    WASMTIME_TRAP_CODE_INDIRECT_CALL_TO_NULL                 :: INDIRECT_CALL_TO_NULL;

    WASMTIME_TRAP_CODE_BAD_SIGNATURE                         :: BAD_SIGNATURE;

    WASMTIME_TRAP_CODE_INTEGER_OVERFLOW                      :: INTEGER_OVERFLOW;

    WASMTIME_TRAP_CODE_INTEGER_DIVISION_BY_ZERO              :: INTEGER_DIVISION_BY_ZERO;

    WASMTIME_TRAP_CODE_BAD_CONVERSION_TO_INTEGER             :: BAD_CONVERSION_TO_INTEGER;

    WASMTIME_TRAP_CODE_UNREACHABLE_CODE_REACHED              :: UNREACHABLE_CODE_REACHED;

    WASMTIME_TRAP_CODE_INTERRUPT                             :: INTERRUPT;

    WASMTIME_TRAP_CODE_OUT_OF_FUEL                           :: OUT_OF_FUEL;

    WASMTIME_TRAP_CODE_ATOMIC_WAIT_NON_SHARED_MEMORY         :: ATOMIC_WAIT_NON_SHARED_MEMORY;

    WASMTIME_TRAP_CODE_NULL_REFERENCE                        :: NULL_REFERENCE;

    WASMTIME_TRAP_CODE_ARRAY_OUT_OF_BOUNDS                   :: ARRAY_OUT_OF_BOUNDS;

    WASMTIME_TRAP_CODE_ALLOCATION_TOO_LARGE                  :: ALLOCATION_TOO_LARGE;

    WASMTIME_TRAP_CODE_CAST_FAILURE                          :: CAST_FAILURE;

    WASMTIME_TRAP_CODE_CANNOT_ENTER_COMPONENT                :: CANNOT_ENTER_COMPONENT;

    WASMTIME_TRAP_CODE_NO_ASYNC_RESULT                       :: NO_ASYNC_RESULT;

    WASMTIME_TRAP_CODE_UNHANDLED_TAG                         :: UNHANDLED_TAG;

    WASMTIME_TRAP_CODE_CONTINUATION_ALREADY_CONSUMED         :: CONTINUATION_ALREADY_CONSUMED;

    WASMTIME_TRAP_CODE_DISABLED_OPCODE                       :: DISABLED_OPCODE;

    WASMTIME_TRAP_CODE_ASYNC_DEADLOCK                        :: ASYNC_DEADLOCK;

    WASMTIME_TRAP_CODE_CANNOT_LEAVE_COMPONENT                :: CANNOT_LEAVE_COMPONENT;

    WASMTIME_TRAP_CODE_CANNOT_BLOCK_SYNC_TASK                :: CANNOT_BLOCK_SYNC_TASK;

    WASMTIME_TRAP_CODE_INVALID_CHAR                          :: INVALID_CHAR;

    WASMTIME_TRAP_CODE_DEBUG_ASSERT_STRING_ENCODING_FINISHED :: DEBUG_ASSERT_STRING_ENCODING_FINISHED;

    WASMTIME_TRAP_CODE_DEBUG_ASSERT_EQUAL_CODE_UNITS         :: DEBUG_ASSERT_EQUAL_CODE_UNITS;

    WASMTIME_TRAP_CODE_DEBUG_ASSERT_POINTER_ALIGNED          :: DEBUG_ASSERT_POINTER_ALIGNED;

    WASMTIME_TRAP_CODE_DEBUG_ASSERT_UPPER_BITS_UNSET         :: DEBUG_ASSERT_UPPER_BITS_UNSET;

    WASMTIME_TRAP_CODE_STRING_OUT_OF_BOUNDS                  :: STRING_OUT_OF_BOUNDS;

    WASMTIME_TRAP_CODE_LIST_OUT_OF_BOUNDS                    :: LIST_OUT_OF_BOUNDS;

    WASMTIME_TRAP_CODE_INVALID_DISCRIMINANT                  :: INVALID_DISCRIMINANT;

    WASMTIME_TRAP_CODE_UNALIGNED_POINTER                     :: UNALIGNED_POINTER;
}

/**
* \brief Creates a new trap with the given message.
*
* \param msg the message to associate with this trap
* \param msg_len the byte length of `msg`
*
* The #wasm_trap_t returned is owned by the caller.
*/
wasmtime_trap_new :: (msg: *u8, msg_len: u64) -> *wasm_trap_t #foreign libwasmtime;

/**
* \brief Creates a new trap from the given trap code.
*
* \param code the trap code to associate with this trap
*
* The #wasm_trap_t returned is owned by the caller.
*/
wasmtime_trap_new_code :: (code: wasmtime_trap_code_t) -> *wasm_trap_t #foreign libwasmtime;

/**
* \brief Attempts to extract the trap code from this trap.
*
* Returns `true` if the trap is an instruction trap triggered while
* executing Wasm. If `true` is returned then the trap code is returned
* through the `code` pointer. If `false` is returned then this is not
* an instruction trap -- traps can also be created using wasm_trap_new,
* or occur with WASI modules exiting with a certain exit code.
*/
wasmtime_trap_code :: (unknown0: *wasm_trap_t, code: *wasmtime_trap_code_t) -> bool #foreign libwasmtime;

/**
* \brief Returns a human-readable name for this frame's function.
*
* This function will attempt to load a human-readable name for function this
* frame points to. This function may return `NULL`.
*
* The lifetime of the returned name is the same as the #wasm_frame_t itself.
*/
wasmtime_frame_func_name :: (unknown0: *wasm_frame_t) -> *wasm_name_t #foreign libwasmtime;

/**
* \brief Returns a human-readable name for this frame's module.
*
* This function will attempt to load a human-readable name for module this
* frame points to. This function may return `NULL`.
*
* The lifetime of the returned name is the same as the #wasm_frame_t itself.
*/
wasmtime_frame_module_name :: (unknown0: *wasm_frame_t) -> *wasm_name_t #foreign libwasmtime;

/**
* \brief Configures the size of the stacks used for asynchronous execution.
*
* This setting configures the size of the stacks that are allocated for
* asynchronous execution.
*
* The value cannot be less than max_wasm_stack.
*
* The amount of stack space guaranteed for host functions is async_stack_size -
* max_wasm_stack, so take care not to set these two values close to one
* another; doing so may cause host functions to overflow the stack and abort
* the process.
*
* By default this option is 2 MiB.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#method.async_stack_size
*/
wasmtime_config_async_stack_size_set :: (unknown0: *wasm_config_t, unknown1: u64) -> void #foreign libwasmtime;

/**
* \brief Configures a Store to yield execution of async WebAssembly code
* periodically.
*
* When a Store is configured to consume fuel with
* `wasmtime_config_consume_fuel` this method will configure what happens when
* fuel runs out. Specifically executing WebAssembly will be suspended and
* control will be yielded back to the caller.
*
* This is only suitable with use of a store associated with an async config
* because only then are futures used and yields are possible.
*
* \param context the context for the store to configure.
* \param interval the amount of fuel at which to yield. A value of 0 will
*        disable yielding.
*/
wasmtime_context_fuel_async_yield_interval :: (_context: *wasmtime_context_t, interval: u64) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Configures epoch-deadline expiration to yield to the async caller and
* the update the deadline.
*
* This is only suitable with use of a store associated with an async config
* because only then are futures used and yields are possible.
*
* See the Rust documentation for more:
* https://docs.wasmtime.dev/api/wasmtime/struct.Store.html#method.epoch_deadline_async_yield_and_update
*/
wasmtime_context_epoch_deadline_async_yield_and_update :: (_context: *wasmtime_context_t, delta: u64) -> *wasmtime_error_t #foreign libwasmtime;

/**
* The callback to determine a continuation's current state.
*
* Return true if the host call has completed, otherwise false will
* continue to yield WebAssembly execution.
*/
wasmtime_func_async_continuation_callback_t :: #type (env: *void) -> bool #c_call;

/**
* A continuation for the current state of the host function's execution.
*/
wasmtime_async_continuation_t :: struct {
    /// Callback for if the async function has completed.
    callback:  wasmtime_func_async_continuation_callback_t;

    /// User-provided argument to pass to the callback.
    env:       *void;

    /// A finalizer for the user-provided *env
    finalizer: #type (unknown0: *void) -> void #c_call;
}

/**
* \brief Callback signature for #wasmtime_linker_define_async_func.
*
* This is a host function that returns a continuation to be called later.
*
* All the arguments to this function will be kept alive until the continuation
* returns that it has errored or has completed.
*
* \param env user-provided argument passed to
*        #wasmtime_linker_define_async_func
* \param caller a temporary object that can only be used during this function
*        call. Used to acquire #wasmtime_context_t or caller's state
* \param args the arguments provided to this function invocation
* \param nargs how many arguments are provided
* \param results where to write the results of this function
* \param nresults how many results must be produced
* \param trap_ret if assigned a not `NULL` value then the called
*        function will trap with the returned error. Note that ownership of
*        trap is transferred to wasmtime.
* \param continuation_ret the returned continuation
*        that determines when the async function has completed executing.
*
* Only supported for async stores.
*
* See #wasmtime_func_callback_t for more information.
*/
wasmtime_func_async_callback_t :: #type (env: *void, caller: *wasmtime_caller_t, args: *wasmtime_val_t, nargs: u64, results: *wasmtime_val_t, nresults: u64, trap_ret: **wasm_trap_t, continuation_ret: *wasmtime_async_continuation_t) -> void #c_call;

wasmtime_call_future :: struct {}
/**
* \brief The structure representing a asynchronously running function.
*
* This structure is always owned by the caller and must be deleted using
* #wasmtime_call_future_delete.
*
* Functions that return this type require that the parameters to the function
* are unmodified until this future is destroyed.
*/
wasmtime_call_future_t :: wasmtime_call_future;

/**
* \brief Executes WebAssembly in the function.
*
* Returns true if the function call has completed. After this function returns
* true, it should *not* be called again for a given future.
*
* This function returns false if execution has yielded either due to being out
* of fuel (see wasmtime_context_fuel_async_yield_interval), or the epoch has
* been incremented enough (see
* wasmtime_context_epoch_deadline_async_yield_and_update). The function may
* also return false if asynchronous host functions have been called, which then
* calling this  function will call the continuation from the async host
* function.
*
* For more see the information at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#asynchronous-wasm
*
*/
wasmtime_call_future_poll :: (future: *wasmtime_call_future_t) -> bool #foreign libwasmtime;

/**
* /brief Frees the underlying memory for a future.
*
* All wasmtime_call_future_t are owned by the caller and should be deleted
* using this function.
*/
wasmtime_call_future_delete :: (future: *wasmtime_call_future_t) -> void #foreign libwasmtime;

/**
* \brief Invokes this function with the params given, returning the results
* asynchronously.
*
* This function is the same as wasmtime_func_call except that it is
* asynchronous. This is only compatible with stores associated with an
* asynchronous config.
*
* The result is a future that is owned by the caller and must be deleted via
* #wasmtime_call_future_delete.
*
* The `args` and `results` pointers may be `NULL` if the corresponding length
* is zero. The `trap_ret` and `error_ret` pointers may *not* be `NULL`.
*
* Does not take ownership of #wasmtime_val_t arguments or #wasmtime_val_t
* results, and all parameters to this function must be kept alive and not
* modified until the returned #wasmtime_call_future_t is deleted. This includes
* the context and store parameters. Only a single future can be alive for a
* given store at a single time (meaning only call this function after the
* previous call's future was deleted).
*
* See the header documentation for for more information.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Func.html#method.call_async
*/
wasmtime_func_call_async :: (_context: *wasmtime_context_t, func: *wasmtime_func_t, args: *wasmtime_val_t, nargs: u64, results: *wasmtime_val_t, nresults: u64, trap_ret: **wasm_trap_t, error_ret: **wasmtime_error_t) -> *wasmtime_call_future_t #foreign libwasmtime;

/**
* \brief Defines a new async function in this linker.
*
* This function behaves similar to #wasmtime_linker_define_func, except it
* supports async callbacks.
*
* The callback `cb` will be invoked on another stack (fiber for Windows).
*/
wasmtime_linker_define_async_func :: (linker: *wasmtime_linker_t, module: *u8, module_len: u64, name: *u8, name_len: u64, ty: *wasm_functype_t, cb: wasmtime_func_async_callback_t, data: *void, finalizer: #type (unknown0: *void) -> void #c_call) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Instantiates a #wasm_module_t with the items defined in this linker
* for an async store.
*
* This is the same as #wasmtime_linker_instantiate but used for async stores
* (which requires functions are called asynchronously). The returning
* #wasmtime_call_future_t must be polled using #wasmtime_call_future_poll, and
* is owned and must be deleted using #wasmtime_call_future_delete.
*
* The `trap_ret` and `error_ret` pointers may *not* be `NULL` and the returned
* memory is owned by the caller.
*
* All arguments to this function must outlive the returned future and be
* unmodified until the future is deleted.
*/
wasmtime_linker_instantiate_async :: (linker: *wasmtime_linker_t, store: *wasmtime_context_t, module: *wasmtime_module_t, instance: *wasmtime_instance_t, trap_ret: **wasm_trap_t, error_ret: **wasmtime_error_t) -> *wasmtime_call_future_t #foreign libwasmtime;

/**
* \brief Instantiates instance within the given store.
*
* This will also run the function's startup function, if there is one.
*
* For more information on async instantiation see
* #wasmtime_linker_instantiate_async.
*
* \param instance_pre the pre-initialized instance
* \param store the store in which to create the instance
* \param instance where to store the returned instance
* \param trap_ret where to store the returned trap
* \param error_ret where to store the returned trap
*
* The `trap_ret` and `error_ret` pointers may *not* be `NULL` and the returned
* memory is owned by the caller.
*
* All arguments to this function must outlive the returned future and be
* unmodified until the future is deleted.
*/
wasmtime_instance_pre_instantiate_async :: (instance_pre: *wasmtime_instance_pre_t, store: *wasmtime_context_t, instance: *wasmtime_instance_t, trap_ret: **wasm_trap_t, error_ret: **wasmtime_error_t) -> *wasmtime_call_future_t #foreign libwasmtime;

/**
* A callback to get the top of the stack address and the length of the stack,
* excluding guard pages.
*
* For more information about the parameters see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/trait.StackMemory.html
*/
wasmtime_stack_memory_get_callback_t :: #type (env: *void, out_len: *u64) -> *u8 #c_call;

/**
* A Stack instance created from a #wasmtime_new_stack_memory_callback_t.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/trait.StackMemory.html
*/
wasmtime_stack_memory_t :: struct {
    /// User provided value to be passed to get_memory and grow_memory
    env:              *void;

    /// Callback to get the memory and size of this LinearMemory
    get_stack_memory: wasmtime_stack_memory_get_callback_t;

    /// An optional finalizer for env
    finalizer:        #type (unknown0: *void) -> void #c_call;
}

/**
* A callback to create a new StackMemory from the specified parameters.
*
* The result should be written to `stack_ret` and wasmtime will own the values
* written into that struct.
*
* This callback must be thread-safe.
*
* For more information about the parameters see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/trait.StackCreator.html#tymethod.new_stack
*/
wasmtime_new_stack_memory_callback_t :: #type (env: *void, size: u64, zeroed: bool, stack_ret: *wasmtime_stack_memory_t) -> *wasmtime_error_t #c_call;

/**
* A representation of custom stack creator.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/trait.StackCreator.html
*/
wasmtime_stack_creator_t :: struct {
    /// User provided value to be passed to new_stack
    env:       *void;

    /// The callback to create a new stack, must be thread safe
    new_stack: wasmtime_new_stack_memory_callback_t;

    /// An optional finalizer for env.
    finalizer: #type (unknown0: *void) -> void #c_call;
}

/**
* Sets a custom stack creator.
*
* Custom memory creators are used when creating creating async instance stacks
* for the on-demand instance allocation strategy.
*
* The config does **not** take ownership of the #wasmtime_stack_creator_t
* passed in, but instead copies all the values in the struct.
*
* For more information see the Rust documentation at
* https://docs.wasmtime.dev/api/wasmtime/struct.Config.html#method.with_host_stack
*/
wasmtime_config_host_stack_creator_set :: (unknown0: *wasm_config_t, unknown1: *wasmtime_stack_creator_t) -> void #foreign libwasmtime;

wasmtime_component_resource_type :: struct {}
/// \brief Represents the type of a component resource.
///
/// This is an opaque structure which represents the type of a resource. This
/// can be used to equate the type of two resources together to see if they are
/// the same.
wasmtime_component_resource_type_t :: wasmtime_component_resource_type;

/// \brief Creates a new resource type representing a host-defined resource.
///
/// This function creates a new `wasmtime_component_resource_type_t` which
/// represents a host-defined resource identified by the `ty` integer argument
/// provided. Two host resources with different `ty` arguments are considered
/// not-equal in terms of resource types. Through this the host can create
/// distinct types of resources at runtime to ensure that components are also
/// required to keep resources distinct.
///
/// The pointer returned from this function must be deallocated with
/// `wasmtime_component_resource_type_delete`.
wasmtime_component_resource_type_new_host :: (ty: u32) -> *wasmtime_component_resource_type_t #foreign libwasmtime;

/// \brief Clones a resource type.
///
/// Creates a new owned copy of a resource type.
///
/// The pointer returned from this function must be deallocated with
/// `wasmtime_component_resource_type_delete`.
wasmtime_component_resource_type_clone :: (ty: *wasmtime_component_resource_type_t) -> *wasmtime_component_resource_type_t #foreign libwasmtime;

/// \brief Compares two resource types for equality.
///
/// Returns whether `a` and `b` point to logically the same resource type under
/// the hood.
wasmtime_component_resource_type_equal :: (a: *wasmtime_component_resource_type_t, b: *wasmtime_component_resource_type_t) -> bool #foreign libwasmtime;

/// \brief Deallocates a resource type.
///
/// This will deallocate the pointer `resource` any any memory that it might
/// own.
wasmtime_component_resource_type_delete :: (resource: *wasmtime_component_resource_type_t) -> void #foreign libwasmtime;

wasmtime_component_list_type :: struct {}
/// \brief Opaque type representing a component list type.
wasmtime_component_list_type_t :: wasmtime_component_list_type;

/// \brief Clones a component list type.
///
/// The returned pointer must be deallocated with
/// `wasmtime_component_list_type_delete`.
wasmtime_component_list_type_clone :: (ty: *wasmtime_component_list_type_t) -> *wasmtime_component_list_type_t #foreign libwasmtime;

/// \brief Compares two component list types for equality.
wasmtime_component_list_type_equal :: (a: *wasmtime_component_list_type_t, b: *wasmtime_component_list_type_t) -> bool #foreign libwasmtime;

/// \brief Deallocates a component list type.
wasmtime_component_list_type_delete :: (ptr: *wasmtime_component_list_type_t) -> void #foreign libwasmtime;

/// \brief Returns the element type of a component list type.
///
/// The returned type must be deallocated with
/// `wasmtime_component_valtype_delete`.
wasmtime_component_list_type_element :: (ty: *wasmtime_component_list_type_t, type_ret: *wasmtime_component_valtype_t) -> void #foreign libwasmtime;

wasmtime_component_record_type :: struct {}
/// \brief Opaque type representing a component record type.
wasmtime_component_record_type_t :: wasmtime_component_record_type;

/// \brief Clones a component record type.
///
/// The returned pointer must be deallocated with
/// `wasmtime_component_record_type_delete`.
wasmtime_component_record_type_clone :: (ty: *wasmtime_component_record_type_t) -> *wasmtime_component_record_type_t #foreign libwasmtime;

/// \brief Compares two component record types for equality.
wasmtime_component_record_type_equal :: (a: *wasmtime_component_record_type_t, b: *wasmtime_component_record_type_t) -> bool #foreign libwasmtime;

/// \brief Deallocates a component record type.
wasmtime_component_record_type_delete :: (ptr: *wasmtime_component_record_type_t) -> void #foreign libwasmtime;

/// \brief Returns the number of fields in a component record type.
wasmtime_component_record_type_field_count :: (ty: *wasmtime_component_record_type_t) -> u64 #foreign libwasmtime;

/// \brief Returns the nth field in a component record type.
///
/// The returned type must be deallocated with
/// `wasmtime_component_valtype_delete`.
wasmtime_component_record_type_field_nth :: (ty: *wasmtime_component_record_type_t, nth: u64, name_ret: **u8, name_len_ret: *u64, type_ret: *wasmtime_component_valtype_t) -> bool #foreign libwasmtime;

wasmtime_component_tuple_type :: struct {}
/// \brief Opaque type representing a component tuple type.
wasmtime_component_tuple_type_t :: wasmtime_component_tuple_type;

/// \brief Clones a component tuple type.
///
/// The returned pointer must be deallocated with
/// `wasmtime_component_tuple_type_delete`.
wasmtime_component_tuple_type_clone :: (ty: *wasmtime_component_tuple_type_t) -> *wasmtime_component_tuple_type_t #foreign libwasmtime;

/// \brief Compares two component tuple types for equality.
wasmtime_component_tuple_type_equal :: (a: *wasmtime_component_tuple_type_t, b: *wasmtime_component_tuple_type_t) -> bool #foreign libwasmtime;

/// \brief Deallocates a component tuple type.
wasmtime_component_tuple_type_delete :: (ptr: *wasmtime_component_tuple_type_t) -> void #foreign libwasmtime;

/// \brief Returns the number of types in a component tuple type.
wasmtime_component_tuple_type_types_count :: (ty: *wasmtime_component_tuple_type_t) -> u64 #foreign libwasmtime;

/// \brief Returns the nth type in a component tuple type.
///
/// The returned type must be deallocated with
/// `wasmtime_component_valtype_delete`.
wasmtime_component_tuple_type_types_nth :: (ty: *wasmtime_component_tuple_type_t, nth: u64, type_ret: *wasmtime_component_valtype_t) -> bool #foreign libwasmtime;

wasmtime_component_variant_type :: struct {}
/// \brief Opaque type representing a component variant type.
wasmtime_component_variant_type_t :: wasmtime_component_variant_type;

/// \brief Clones a component variant type.
///
/// The returned pointer must be deallocated with
/// `wasmtime_component_variant_type_delete`.
wasmtime_component_variant_type_clone :: (ty: *wasmtime_component_variant_type_t) -> *wasmtime_component_variant_type_t #foreign libwasmtime;

/// \brief Compares two component variant types for equality.
wasmtime_component_variant_type_equal :: (a: *wasmtime_component_variant_type_t, b: *wasmtime_component_variant_type_t) -> bool #foreign libwasmtime;

/// \brief Deallocates a component variant type.
wasmtime_component_variant_type_delete :: (ptr: *wasmtime_component_variant_type_t) -> void #foreign libwasmtime;

/// \brief Returns the number of cases in a component variant type.
wasmtime_component_variant_type_case_count :: (ty: *wasmtime_component_variant_type_t) -> u64 #foreign libwasmtime;

/// \brief Returns the nth case in a component variant type.
/// The returned payload type must be deallocated with
/// `wasmtime_component_valtype_delete`.
wasmtime_component_variant_type_case_nth :: (ty: *wasmtime_component_variant_type_t, nth: u64, name_ret: **u8, name_len_ret: *u64, has_payload_ret: *bool, payload_ret: *wasmtime_component_valtype_t) -> bool #foreign libwasmtime;

wasmtime_component_enum_type :: struct {}
/// \brief Opaque type representing a component enum type.
wasmtime_component_enum_type_t :: wasmtime_component_enum_type;

/// \brief Clones a component enum type.
///
/// The returned pointer must be deallocated with
/// `wasmtime_component_enum_type_delete`.
wasmtime_component_enum_type_clone :: (ty: *wasmtime_component_enum_type_t) -> *wasmtime_component_enum_type_t #foreign libwasmtime;

/// \brief Compares two component enum types for equality.
wasmtime_component_enum_type_equal :: (a: *wasmtime_component_enum_type_t, b: *wasmtime_component_enum_type_t) -> bool #foreign libwasmtime;

/// \brief Deallocates a component enum type.
wasmtime_component_enum_type_delete :: (ptr: *wasmtime_component_enum_type_t) -> void #foreign libwasmtime;

/// \brief Returns the number of names in a component enum type.
wasmtime_component_enum_type_names_count :: (ty: *wasmtime_component_enum_type_t) -> u64 #foreign libwasmtime;

/// \brief Returns the nth name in a component enum type.
wasmtime_component_enum_type_names_nth :: (ty: *wasmtime_component_enum_type_t, nth: u64, name_ret: **u8, name_len_ret: *u64) -> bool #foreign libwasmtime;

wasmtime_component_option_type :: struct {}
/// \brief Opaque type representing a component option type.
wasmtime_component_option_type_t :: wasmtime_component_option_type;

/// \brief Clones a component option type.
///
/// The returned pointer must be deallocated with
/// `wasmtime_component_option_type_delete`.
wasmtime_component_option_type_clone :: (ty: *wasmtime_component_option_type_t) -> *wasmtime_component_option_type_t #foreign libwasmtime;

/// \brief Compares two component option types for equality.
wasmtime_component_option_type_equal :: (a: *wasmtime_component_option_type_t, b: *wasmtime_component_option_type_t) -> bool #foreign libwasmtime;

/// \brief Deallocates a component option type.
wasmtime_component_option_type_delete :: (ptr: *wasmtime_component_option_type_t) -> void #foreign libwasmtime;

/// \brief Returns the inner type of a component option type.
///
/// The returned type must be deallocated with
/// `wasmtime_component_valtype_delete`.
wasmtime_component_option_type_ty :: (ty: *wasmtime_component_option_type_t, type_ret: *wasmtime_component_valtype_t) -> void #foreign libwasmtime;

wasmtime_component_result_type :: struct {}
/// \brief Opaque type representing a component result type.
wasmtime_component_result_type_t :: wasmtime_component_result_type;

/// \brief Clones a component result type.
///
/// The returned pointer must be deallocated with
/// `wasmtime_component_result_type_delete`.
wasmtime_component_result_type_clone :: (ty: *wasmtime_component_result_type_t) -> *wasmtime_component_result_type_t #foreign libwasmtime;

/// \brief Compares two component result types for equality.
wasmtime_component_result_type_equal :: (a: *wasmtime_component_result_type_t, b: *wasmtime_component_result_type_t) -> bool #foreign libwasmtime;

/// \brief Deallocates a component result type.
wasmtime_component_result_type_delete :: (ptr: *wasmtime_component_result_type_t) -> void #foreign libwasmtime;

/// \brief Returns the `ok` type of a component result type.
/// The returned type must be deallocated with
/// `wasmtime_component_valtype_delete`.
wasmtime_component_result_type_ok :: (ty: *wasmtime_component_result_type_t, type_ret: *wasmtime_component_valtype_t) -> bool #foreign libwasmtime;

/// \brief Returns the `err` type of a component result type.
/// The returned type must be deallocated with
/// `wasmtime_component_valtype_delete`.
wasmtime_component_result_type_err :: (ty: *wasmtime_component_result_type_t, type_ret: *wasmtime_component_valtype_t) -> bool #foreign libwasmtime;

wasmtime_component_flags_type :: struct {}
/// \brief Opaque type representing a component flags type.
wasmtime_component_flags_type_t :: wasmtime_component_flags_type;

/// \brief Clones a component flags type.
///
/// The returned pointer must be deallocated with
/// `wasmtime_component_flags_type_delete`.
wasmtime_component_flags_type_clone :: (ty: *wasmtime_component_flags_type_t) -> *wasmtime_component_flags_type_t #foreign libwasmtime;

/// \brief Compares two component flags types for equality.
wasmtime_component_flags_type_equal :: (a: *wasmtime_component_flags_type_t, b: *wasmtime_component_flags_type_t) -> bool #foreign libwasmtime;

/// \brief Deallocates a component flags type.
wasmtime_component_flags_type_delete :: (ptr: *wasmtime_component_flags_type_t) -> void #foreign libwasmtime;

/// \brief Returns the number of names in a component flags type.
wasmtime_component_flags_type_names_count :: (ty: *wasmtime_component_flags_type_t) -> u64 #foreign libwasmtime;

/// \brief Returns the nth name in a component flags type.
wasmtime_component_flags_type_names_nth :: (ty: *wasmtime_component_flags_type_t, nth: u64, name_ret: **u8, name_len_ret: *u64) -> bool #foreign libwasmtime;

wasmtime_component_future_type :: struct {}
/// \brief Opaque type representing a component future type.
wasmtime_component_future_type_t :: wasmtime_component_future_type;

/// \brief Clones a component future type.
///
/// The returned pointer must be deallocated with
/// `wasmtime_component_future_type_delete`.
wasmtime_component_future_type_clone :: (ty: *wasmtime_component_future_type_t) -> *wasmtime_component_future_type_t #foreign libwasmtime;

/// \brief Compares two component future types for equality.
wasmtime_component_future_type_equal :: (a: *wasmtime_component_future_type_t, b: *wasmtime_component_future_type_t) -> bool #foreign libwasmtime;

/// \brief Deallocates a component future type.
wasmtime_component_future_type_delete :: (ptr: *wasmtime_component_future_type_t) -> void #foreign libwasmtime;

/// \brief Returns the inner type of a component future type.
///
/// The returned type must be deallocated with
/// `wasmtime_component_valtype_delete`.
wasmtime_component_future_type_ty :: (ty: *wasmtime_component_future_type_t, type_ret: *wasmtime_component_valtype_t) -> bool #foreign libwasmtime;

wasmtime_component_stream_type :: struct {}
/// \brief Opaque type representing a component stream type.
wasmtime_component_stream_type_t :: wasmtime_component_stream_type;

/// \brief Clones a component stream type.
///
/// The returned pointer must be deallocated with
/// `wasmtime_component_stream_type_delete`.
wasmtime_component_stream_type_clone :: (ty: *wasmtime_component_stream_type_t) -> *wasmtime_component_stream_type_t #foreign libwasmtime;

/// \brief Compares two component stream types for equality.
wasmtime_component_stream_type_equal :: (a: *wasmtime_component_stream_type_t, b: *wasmtime_component_stream_type_t) -> bool #foreign libwasmtime;

/// \brief Deallocates a component stream type.
wasmtime_component_stream_type_delete :: (ptr: *wasmtime_component_stream_type_t) -> void #foreign libwasmtime;

/// \brief Returns the inner type of a component stream type.
///
/// The returned type must be deallocated with
/// `wasmtime_component_valtype_delete`.
wasmtime_component_stream_type_ty :: (ty: *wasmtime_component_stream_type_t, type_ret: *wasmtime_component_valtype_t) -> bool #foreign libwasmtime;

/// \brief Discriminant used in #wasmtime_component_valtype_t::kind
wasmtime_component_valtype_kind_t :: u8;

/// \brief Represents a single value type in the component model.
wasmtime_component_valtype_union :: union {
    /// Field used if #wasmtime_component_valtype_t::kind is
    /// #WASMTIME_COMPONENT_VALTYPE_LIST
    list:    *wasmtime_component_list_type_t;

    /// Field used if #wasmtime_component_valtype_t::kind is
    /// #WASMTIME_COMPONENT_VALTYPE_RECORD
    record:  *wasmtime_component_record_type_t;

    /// Field used if #wasmtime_component_valtype_t::kind is
    /// #WASMTIME_COMPONENT_VALTYPE_TUPLE
    tuple:   *wasmtime_component_tuple_type_t;

    /// Field used if #wasmtime_component_valtype_t::kind is
    /// #WASMTIME_COMPONENT_VALTYPE_VARIANT
    variant: *wasmtime_component_variant_type_t;

    /// Field used if #wasmtime_component_valtype_t::kind is
    /// #WASMTIME_COMPONENT_VALTYPE_ENUM
    enum_:   *wasmtime_component_enum_type_t;

    /// Field used if #wasmtime_component_valtype_t::kind is
    /// #WASMTIME_COMPONENT_VALTYPE_OPTION
    option:  *wasmtime_component_option_type_t;

    /// Field used if #wasmtime_component_valtype_t::kind is
    /// #WASMTIME_COMPONENT_VALTYPE_RESULT
    result:  *wasmtime_component_result_type_t;

    /// Field used if #wasmtime_component_valtype_t::kind is
    /// #WASMTIME_COMPONENT_VALTYPE_FLAGS
    flags:   *wasmtime_component_flags_type_t;

    /// Field used if #wasmtime_component_valtype_t::kind is
    /// #WASMTIME_COMPONENT_VALTYPE_OWN
    own:     *wasmtime_component_resource_type_t;

    /// Field used if #wasmtime_component_valtype_t::kind is
    /// #WASMTIME_COMPONENT_VALTYPE_BORROW
    borrow:  *wasmtime_component_resource_type_t;

    /// Field used if #wasmtime_component_valtype_t::kind is
    /// #WASMTIME_COMPONENT_VALTYPE_FUTURE
    future:  *wasmtime_component_future_type_t;

    /// Field used if #wasmtime_component_valtype_t::kind is
    /// #WASMTIME_COMPONENT_VALTYPE_STREAM
    stream:  *wasmtime_component_stream_type_t;
}

/// \brief Represents a single value type in the component model.
wasmtime_component_valtype_union_t :: wasmtime_component_valtype_union;

/// \brief Represents a single value type in the component model.
wasmtime_component_valtype_t :: struct {
    /// The type discriminant for the `of` union.
    kind: wasmtime_component_valtype_kind_t;

    /// The actual type.
    of:   wasmtime_component_valtype_union_t;
}

/// \brief Clones a component value type.
///
/// The returned pointer must be deallocated with
/// `wasmtime_component_valtype_delete`.
wasmtime_component_valtype_clone :: (ty: *wasmtime_component_valtype_t, out: *wasmtime_component_valtype_t) -> void #foreign libwasmtime;

/// \brief Compares two component value types for equality.
wasmtime_component_valtype_equal :: (a: *wasmtime_component_valtype_t, b: *wasmtime_component_valtype_t) -> bool #foreign libwasmtime;

/// \brief Deallocates a component value type.
wasmtime_component_valtype_delete :: (ptr: *wasmtime_component_valtype_t) -> void #foreign libwasmtime;

wasmtime_component_func_type_t :: struct {}

/// \brief Clones a component function type.
///
/// The pointer returned from this function must be deallocated with
/// `wasmtime_component_func_type_delete`.
wasmtime_component_func_type_clone :: (ty: *wasmtime_component_func_type_t) -> *wasmtime_component_func_type_t #foreign libwasmtime;

/// \brief Deallocates a component instance type.
wasmtime_component_func_type_delete :: (ty: *wasmtime_component_func_type_t) -> void #foreign libwasmtime;

/// \brief Returns whether this is an async function.
wasmtime_component_func_type_async :: (ty: *wasmtime_component_func_type_t) -> bool #foreign libwasmtime;

/// \brief Returns the number of parameters of a component function type.
wasmtime_component_func_type_param_count :: (ty: *wasmtime_component_func_type_t) -> u64 #foreign libwasmtime;

/// \brief Retrieves the nth parameter.
///
/// The `type_ret` return value must be deallocated with
/// `wasmtime_component_valtype_delete`.
wasmtime_component_func_type_param_nth :: (ty: *wasmtime_component_func_type_t, nth: u64, name_ret: **u8, name_len_ret: *u64, type_ret: *wasmtime_component_valtype_t) -> bool #foreign libwasmtime;

/// \brief Returns the result, if any, of this component function type.
///
/// The `type_ret` return value must be deallocated with
/// `wasmtime_component_valtype_delete`.
wasmtime_component_func_type_result :: (ty: *wasmtime_component_func_type_t, type_ret: *wasmtime_component_valtype_t) -> bool #foreign libwasmtime;

wasmtime_component_instance_type :: struct {}
/// \brief Represents the type of a component instance.
wasmtime_component_instance_type_t :: wasmtime_component_instance_type;

/// \brief Clones a component instance type.
///
/// The pointer returned from this function must be deallocated with
/// `wasmtime_component_instance_type_delete`.
wasmtime_component_instance_type_clone :: (ty: *wasmtime_component_instance_type_t) -> *wasmtime_component_instance_type_t #foreign libwasmtime;

/// \brief Deallocates a component instance type.
wasmtime_component_instance_type_delete :: (ty: *wasmtime_component_instance_type_t) -> void #foreign libwasmtime;

/// \brief Returns the number of exports of a component instance type.
wasmtime_component_instance_type_export_count :: (ty: *wasmtime_component_instance_type_t, engine: *wasm_engine_t) -> u64 #foreign libwasmtime;

/// \brief Retrieves the export with the specified name.
///
/// The returned `wasmtime_component_item_t` must be deallocated with
/// `wasmtime_component_item_delete`.
wasmtime_component_instance_type_export_get :: (ty: *wasmtime_component_instance_type_t, engine: *wasm_engine_t, name: *u8, name_len: u64, ret: *wasmtime_component_item_t) -> bool #foreign libwasmtime;

/// \brief Retrieves the nth export.
///
/// The returned `wasmtime_component_item_t` must be deallocated with
/// `wasmtime_component_item_delete`.
wasmtime_component_instance_type_export_nth :: (ty: *wasmtime_component_instance_type_t, engine: *wasm_engine_t, nth: u64, name_ret: **u8, name_len_ret: *u64, type_ret: *wasmtime_component_item_t) -> bool #foreign libwasmtime;

wasmtime_module_type :: struct {}
/// \brief Represents the type of a module.
wasmtime_module_type_t :: wasmtime_module_type;

/// \brief Clones a module type.
///
/// The pointer returned from this function must be deallocated with
/// `wasmtime_module_type_delete`.
wasmtime_module_type_clone :: (ty: *wasmtime_module_type_t) -> *wasmtime_module_type_t #foreign libwasmtime;

/// \brief Deallocates a component instance type.
wasmtime_module_type_delete :: (ty: *wasmtime_module_type_t) -> void #foreign libwasmtime;

/// \brief Returns the number of imports of a module type.
wasmtime_module_type_import_count :: (ty: *wasmtime_module_type_t, engine: *wasm_engine_t) -> u64 #foreign libwasmtime;

/// \brief Retrieves the nth import.
///
/// The returned `type_ret` pointer must be deallocated with
/// `wasm_importtype_delete`.
wasmtime_module_type_import_nth :: (ty: *wasmtime_module_type_t, engine: *wasm_engine_t, nth: u64) -> *wasm_importtype_t #foreign libwasmtime;

/// \brief Returns the number of exports of a module type.
wasmtime_module_type_export_count :: (ty: *wasmtime_module_type_t, engine: *wasm_engine_t) -> u64 #foreign libwasmtime;

/// \brief Retrieves the nth export.
///
/// The returned `type_ret` pointer must be deallocated with
/// `wasm_exporttype_delete`.
wasmtime_module_type_export_nth :: (ty: *wasmtime_module_type_t, engine: *wasm_engine_t, nth: u64) -> *wasm_exporttype_t #foreign libwasmtime;

wasmtime_component_type_t :: struct {}

/// \brief Clones a component type.
///
/// The returned pointer must be deallocated wit
/// h`wasmtime_component_type_delete`.
wasmtime_component_type_clone :: (ty: *wasmtime_component_type_t) -> *wasmtime_component_type_t #foreign libwasmtime;

/// \brief Deallocates a component type.
wasmtime_component_type_delete :: (ty: *wasmtime_component_type_t) -> void #foreign libwasmtime;

/// \brief Returns the number of imports of a component type.
wasmtime_component_type_import_count :: (ty: *wasmtime_component_type_t, engine: *wasm_engine_t) -> u64 #foreign libwasmtime;

/// \brief Retrieves the import with the specified name.
///
/// The returned `wasmtime_component_item_t` must be deallocated with
/// `wasmtime_component_item_delete`.
wasmtime_component_type_import_get :: (ty: *wasmtime_component_type_t, engine: *wasm_engine_t, name: *u8, name_len: u64, ret: *wasmtime_component_item_t) -> bool #foreign libwasmtime;

/// \brief Retrieves the nth import.
///
/// The returned `wasmtime_component_item_t` must be deallocated with
/// `wasmtime_component_item_delete`.
wasmtime_component_type_import_nth :: (ty: *wasmtime_component_type_t, engine: *wasm_engine_t, nth: u64, name_ret: **u8, name_len_ret: *u64, type_ret: *wasmtime_component_item_t) -> bool #foreign libwasmtime;

/// \brief Returns the number of exports of a component type.
wasmtime_component_type_export_count :: (ty: *wasmtime_component_type_t, engine: *wasm_engine_t) -> u64 #foreign libwasmtime;

/// \brief Retrieves the export with the specified name.
///
/// The returned `wasmtime_component_item_t` must be deallocated with
/// `wasmtime_component_item_delete`.
wasmtime_component_type_export_get :: (ty: *wasmtime_component_type_t, engine: *wasm_engine_t, name: *u8, name_len: u64, ret: *wasmtime_component_item_t) -> bool #foreign libwasmtime;

/// \brief Retrieves the nth export.
///
/// The returned `wasmtime_component_item_t` must be deallocated with
/// `wasmtime_component_item_delete`.
wasmtime_component_type_export_nth :: (ty: *wasmtime_component_type_t, engine: *wasm_engine_t, nth: u64, name_ret: **u8, name_len_ret: *u64, type_ret: *wasmtime_component_item_t) -> bool #foreign libwasmtime;

/// \brief Discriminant used in #wasmtime_component_item_t::kind
wasmtime_component_item_kind_t :: u8;

/// \brief Represents a single item in a component's import or export list.
wasmtime_component_item_union :: union {
    /// Field used if #wasmtime_component_item_t::kind is
    /// #WASMTIME_COMPONENT_ITEM_COMPONENT
    component:          *wasmtime_component_type_t;

    /// Field used if #wasmtime_component_item_t::kind is
    /// #WASMTIME_COMPONENT_ITEM_COMPONENT_INSTANCE
    component_instance: *wasmtime_component_instance_type_t;

    /// Field used if #wasmtime_component_item_t::kind is
    /// #WASMTIME_COMPONENT_ITEM_MODULE
    module:             *wasmtime_module_type_t;

    /// Field used if #wasmtime_component_item_t::kind is
    /// #WASMTIME_COMPONENT_ITEM_COMPONENT_FUNC
    component_func:     *wasmtime_component_func_type_t;

    /// Field used if #wasmtime_component_item_t::kind is
    /// #WASMTIME_COMPONENT_ITEM_RESOURCE
    resource:           *wasmtime_component_resource_type_t;

    /// Field used if #wasmtime_component_item_t::kind is
    /// #WASMTIME_COMPONENT_ITEM_CORE_FUNC
    core_func:          *wasm_functype_t;

    /// Field used if #wasmtime_component_item_t::kind is
    /// #WASMTIME_COMPONENT_ITEM_TYPE
    type:               wasmtime_component_valtype_t;
}

/// \brief Represents a single item in a component's import or export list.
wasmtime_component_item_union_t :: wasmtime_component_item_union;

/// \brief Represents a single item in a component's import or export list.
wasmtime_component_item_t :: struct {
    /// The type discriminant for the `of` union.
    kind: wasmtime_component_item_kind_t;

    /// The actual item.
    of:   wasmtime_component_item_union_t;
}

/// \brief Clones a component item.
///
/// The returned pointer must be deallocated with
/// `wasmtime_component_item_delete`.
wasmtime_component_item_clone :: (item: *wasmtime_component_item_t, out: *wasmtime_component_item_t) -> void #foreign libwasmtime;

/// \brief Deallocates a component item.
wasmtime_component_item_delete :: (ptr: *wasmtime_component_item_t) -> void #foreign libwasmtime;

wasmtime_component_t :: struct {}

/**
* \brief Compiles a WebAssembly binary into a #wasmtime_component_t
*
* This function will compile a WebAssembly binary into an owned
#wasmtime_component_t.
*
* It requires a component binary, such as what is produced by Rust `cargo
component` tooling.
*
* This function does not take ownership of any of its arguments, but the
* returned error and component are owned by the caller.

* \param engine the #wasm_engine_t that will create the component
* \param buf the address of the buffer containing the WebAssembly binary
* \param len the length of the buffer containing the WebAssembly binary
* \param component_out on success, contains the address of the created
*        component
*
* \return NULL on success, else a #wasmtime_error_t describing the error
*/
wasmtime_component_new :: (engine: *wasm_engine_t, buf: *u8, len: u64, component_out: **wasmtime_component_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief This function serializes compiled component artifacts as blob data.
*
* \param component the component
* \param ret if the conversion is successful, this byte vector is filled in
* with the serialized compiled component.
*
* \return a non-null error if parsing fails, or returns `NULL`. If parsing
* fails then `ret` isn't touched.
*
* This function does not take ownership of `component`, and the caller is
* expected to deallocate the returned #wasmtime_error_t and #wasm_byte_vec_t.
*/
wasmtime_component_serialize :: (component: *wasmtime_component_t, ret: *wasm_byte_vec_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Build a component from serialized data.
*
* This function does not take ownership of any of its arguments, but the
* returned error and component are owned by the caller.
*
* This function is not safe to receive arbitrary user input. See the Rust
* documentation for more information on what inputs are safe to pass in here
* (e.g. only that of `wasmtime_component_serialize`)
*/
wasmtime_component_deserialize :: (engine: *wasm_engine_t, buf: *u8, len: u64, component_out: **wasmtime_component_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Deserialize a component from an on-disk file.
*
* This function is the same as #wasmtime_component_deserialize except that it
* reads the data for the serialized component from the path on disk. This can
* be faster than the alternative which may require copying the data around.
*
* This function does not take ownership of any of its arguments, but the
* returned error and component are owned by the caller.
*
* This function is not safe to receive arbitrary user input. See the Rust
* documentation for more information on what inputs are safe to pass in here
* (e.g. only that of `wasmtime_component_serialize`)
*/
wasmtime_component_deserialize_file :: (engine: *wasm_engine_t, path: *u8, component_out: **wasmtime_component_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Creates a shallow clone of the specified component, increasing the
* internal reference count.
*/
wasmtime_component_clone :: (component: *wasmtime_component_t) -> *wasmtime_component_t #foreign libwasmtime;

/**
* \brief Returns the type of this component.
*
* The returned pointer must be deallocatd with
* `wasmtime_component_type_delete`.
*/
wasmtime_component_type :: (component: *wasmtime_component_t) -> *wasmtime_component_type_t #foreign libwasmtime;

/**
* \brief Deletes a #wasmtime_component_t created by #wasmtime_component_new
*
* \param component the component to delete
*/
wasmtime_component_delete :: (component: *wasmtime_component_t) -> void #foreign libwasmtime;

wasmtime_component_export_index_t :: struct {}

/**
* \brief Looks up a specific export of this component by \p name optionally
* nested within the \p instance provided.
*
* \param component the component to look up \p name in
* \param instance_export_index optional (i.e. nullable) instance to look up in
* \param name the name of the export
* \param name_len length of \p name in bytes
* \return export index if found, else NULL
*/
wasmtime_component_get_export_index :: (component: *wasmtime_component_t, instance_export_index: *wasmtime_component_export_index_t, name: *u8, name_len: u64) -> *wasmtime_component_export_index_t #foreign libwasmtime;

/**
* \brief Creates a new separately-owned copy of the specified index.
*/
wasmtime_component_export_index_clone :: (index: *wasmtime_component_export_index_t) -> *wasmtime_component_export_index_t #foreign libwasmtime;

/**
* \brief Deletes a #wasmtime_component_export_index_t
*
* \param export_index the export index to delete
*/
wasmtime_component_export_index_delete :: (export_index: *wasmtime_component_export_index_t) -> void #foreign libwasmtime;

wasmtime_component_resource_any :: struct {}
/// \brief Represents a component resource which can be either guest-owned or
/// host-owned.
///
/// This type is an opaque type used to represent any component model resource.
/// Internally this tracks information about ownership, type, etc. Values of
/// this type have dynamic ownership guarantees associated with them. Notably
/// from a component-model perspective values of this type must either be
/// converted to a host resource with `wasmtime_component_resource_any_to_host`
/// or dropped via `wasmtime_component_resource_any_drop`. This is required to
/// handle various metadata tracking appropriately, and if this is not done
/// then the resource will be leaked into the store and a trap may be raised.
///
/// Note that this type also has dynamic memory allocations associated with it
/// and users must call `wasmtime_component_resource_any_delete` to deallocate
/// the host-side resources. This destructor can be called in an RAII fashion
/// and will only clean up memory, not metadata related to the resource.
/// It is required to call `wasmtime_component_resource_any_delete` to prevent
/// leaking memory on the host. It's highly recommended to call
/// `wasmtime_component_resource_any_drop` to avoid leaking memory in a
/// long-lived store, but if this is forgotten then deallocating the store will
/// deallocate all memory still.
wasmtime_component_resource_any_t :: wasmtime_component_resource_any;

/// \brief Gets the type of a component resource.
///
/// Returns an owned `wasmtime_component_resource_type_t` which represents the
/// type of this resource.
///
/// The pointer returned from this function must be deallocated with
/// `wasmtime_component_resource_type_delete`.
wasmtime_component_resource_any_type :: (resource: *wasmtime_component_resource_any_t) -> *wasmtime_component_resource_type_t #foreign libwasmtime;

/// \brief Clones a component resource.
///
/// Creates a new owned copy of a component resource. Note that the returned
/// resource still logically refers to the same resource as before, but this
/// can be convenient from an API perspective. Calls to
/// `wasmtime_component_resource_any_drop` need only happen
/// once-per-logical-resource, not once-per-handle-to-the-resource. Note though
/// that calls to `wasmtime_component_resource_any_delete` must happen
/// once-per-handle-to-the-resource.
///
/// The pointer returned from this function must be deallocated with
/// `wasmtime_component_resource_any_delete`.
wasmtime_component_resource_any_clone :: (resource: *wasmtime_component_resource_any_t) -> *wasmtime_component_resource_any_t #foreign libwasmtime;

/// \brief Returns whether this resource is an `own`, or a `borrow` in the
/// component model.
wasmtime_component_resource_any_owned :: (resource: *wasmtime_component_resource_any_t) -> bool #foreign libwasmtime;

/// \brief Drops a component resource.
///
/// This function is required to be called per "logical resource" to clean up
/// any borrow-tracking state in the store, for example. Additionally this may
/// invoke WebAssembly if it's a guest-owned resource with a destructor
/// associated with it.
///
/// This operation is not to be confused with
/// `wasmtime_component_resource_any_delete` which deallocates host-related
/// memory for this resource. After `wasmtime_component_resource_any_drop` is
/// called it's still required to call
/// `wasmtime_component_resource_any_delete`.
wasmtime_component_resource_any_drop :: (ctx: *wasmtime_context_t, resource: *wasmtime_component_resource_any_t) -> *wasmtime_error_t #foreign libwasmtime;

/// \brief Deallocates a component resource.
///
/// This function deallocates any host-side memory associated with this
/// resource. This function does not perform any component-model related
/// cleanup, and `wasmtime_component_resource_any_drop` is required for that.
wasmtime_component_resource_any_delete :: (resource: *wasmtime_component_resource_any_t) -> void #foreign libwasmtime;

wasmtime_component_resource_host :: struct {}
/// \brief Represents a host-defined component resource.
///
/// This structure is similar to `wasmtime_component_resource_any_t` except
/// that it unconditionally represents an embedder-defined resource via this
/// API. Host resources have a "rep" which is a 32-bit integer whose meaning
/// is defined by the host. This "rep" is trusted in the sense that the guest
/// cannot forge this so the embedder is the only one that can view this.
///
/// Host resources also have a 32-bit type whose meaning is also defined by the
/// host and has no meaning internally. This is used to distinguish different
/// types of resources from one another.
///
/// Also note that unlike `wasmtime_component_resource_any_t` host resources
/// do not have a "drop" operation. It's up to the host to define what it means
/// to drop an owned resource and handle that appropriately.
wasmtime_component_resource_host_t :: wasmtime_component_resource_host;

/// \brief Creates a new host-defined component resource.
///
/// This function creates a new host-defined component resource with the
/// provided parameters. The `owned` parameter indicates whether this resource
/// is an `own` or a `borrow` in the component model. The `rep` and `ty`
/// parameters are 32-bit integers which only have meaning to the embedder and
/// are plumbed through with this resource.
///
/// The pointer returned from this function must be deallocated with
/// `wasmtime_component_resource_host_delete`.
wasmtime_component_resource_host_new :: (owned: bool, rep: u32, ty: u32) -> *wasmtime_component_resource_host_t #foreign libwasmtime;

/// \brief Clones a host-defined component resource.
///
/// Creates a new owned copy of a host-defined component resource. Note that the
/// returned resource still logically refers to the same resource as before,
/// but this can be convenient from an API perspective.
///
/// The pointer returned from this function must be deallocated with
/// `wasmtime_component_resource_host_delete`.
wasmtime_component_resource_host_clone :: (resource: *wasmtime_component_resource_host_t) -> *wasmtime_component_resource_host_t #foreign libwasmtime;

/// \brief Gets the "rep" of a host-defined component resource.
///
/// Returns the 32-bit integer "rep" associated with this resource. This is a
/// trusted value that guests cannot forge.
wasmtime_component_resource_host_rep :: (resource: *wasmtime_component_resource_host_t) -> u32 #foreign libwasmtime;

/// \brief Gets the "type" of a host-defined component resource.
///
/// Returns the 32-bit integer "type" associated with this resource. This is a
/// trusted value that guests cannot forge.
wasmtime_component_resource_host_type :: (resource: *wasmtime_component_resource_host_t) -> u32 #foreign libwasmtime;

/// \brief Returns whether this host-defined resource is an `own` or a `borrow`
/// in the component model.
wasmtime_component_resource_host_owned :: (resource: *wasmtime_component_resource_host_t) -> bool #foreign libwasmtime;

/// \brief Deallocates a host-defined component resource.
///
/// This function deallocates any host-side memory associated with this
/// resource.
wasmtime_component_resource_host_delete :: (resource: *wasmtime_component_resource_host_t) -> void #foreign libwasmtime;

/// \brief Attempts to convert a `wasmtime_component_resource_any_t` into a
/// `wasmtime_component_resource_host_t`.
///
/// This function will attempt to convert the provided `resource` into a
/// host-defined resource. If the resource is indeed host-defined then a new
/// owned `wasmtime_component_resource_host_t` is returned via `ret`. If the
/// resource is guest-defined then an error is returned and `ret` is not
/// modified.
///
/// If no error is returned then the pointer written to `ret` must be
/// deallocated with `wasmtime_component_resource_host_delete`.
wasmtime_component_resource_any_to_host :: (ctx: *wasmtime_context_t, resource: *wasmtime_component_resource_any_t, ret: **wasmtime_component_resource_host_t) -> *wasmtime_error_t #foreign libwasmtime;

/// \brief Same as `wasmtime_component_resource_any_to_host` except for
/// converting the other way around.
///
/// This can fail in some edge-case scenarios but typically does not fail.
wasmtime_component_resource_host_to_any :: (ctx: *wasmtime_context_t, resource: *wasmtime_component_resource_host_t, ret: **wasmtime_component_resource_any_t) -> *wasmtime_error_t #foreign libwasmtime;

/// \brief Discriminant used in #wasmtime_component_val_t::kind
wasmtime_component_valkind_t :: u8;

/** \brief A vec of a type */
wasmtime_component_vallist :: struct {
    /** Length of the vec */
    size: u64;
    data: *wasmtime_component_val;
}
/** \brief A vec of a type */
wasmtime_component_vallist_t :: wasmtime_component_vallist;
/** \brief Create vec from \p ptr and \p size */
wasmtime_component_vallist_new :: (out: *wasmtime_component_vallist_t, size: u64, ptr: *wasmtime_component_val) -> void #foreign libwasmtime;
/** \brief Create an empty vec */
wasmtime_component_vallist_new_empty :: (out: *wasmtime_component_vallist_t) -> void #foreign libwasmtime;
/** \brief Create a vec with length \p size */
wasmtime_component_vallist_new_uninit :: (out: *wasmtime_component_vallist_t, size: u64) -> void #foreign libwasmtime;
/** \brief Copy \p src to \p dst */
wasmtime_component_vallist_copy :: (dst: *wasmtime_component_vallist_t, src: *wasmtime_component_vallist_t) -> void #foreign libwasmtime;
/** \brief Delete \p value */
wasmtime_component_vallist_delete :: (value: *wasmtime_component_vallist_t) -> void #foreign libwasmtime;
/** \brief A vec of a type */
wasmtime_component_valrecord :: struct {
    /** Length of the vec */
    size: u64;
    data: *wasmtime_component_valrecord_entry;
}
/** \brief A vec of a type */
wasmtime_component_valrecord_t :: wasmtime_component_valrecord;
/** \brief Create vec from \p ptr and \p size */
wasmtime_component_valrecord_new :: (out: *wasmtime_component_valrecord_t, size: u64, ptr: *wasmtime_component_valrecord_entry) -> void #foreign libwasmtime;
/** \brief Create an empty vec */
wasmtime_component_valrecord_new_empty :: (out: *wasmtime_component_valrecord_t) -> void #foreign libwasmtime;
/** \brief Create a vec with length \p size */
wasmtime_component_valrecord_new_uninit :: (out: *wasmtime_component_valrecord_t, size: u64) -> void #foreign libwasmtime;
/** \brief Copy \p src to \p dst */
wasmtime_component_valrecord_copy :: (dst: *wasmtime_component_valrecord_t, src: *wasmtime_component_valrecord_t) -> void #foreign libwasmtime;
/** \brief Delete \p value */
wasmtime_component_valrecord_delete :: (value: *wasmtime_component_valrecord_t) -> void #foreign libwasmtime;

/** \brief A vec of a type */
wasmtime_component_valtuple :: struct {
    /** Length of the vec */
    size: u64;
    data: *wasmtime_component_val;
}
/** \brief A vec of a type */
wasmtime_component_valtuple_t :: wasmtime_component_valtuple;
/** \brief Create vec from \p ptr and \p size */
wasmtime_component_valtuple_new :: (out: *wasmtime_component_valtuple_t, size: u64, ptr: *wasmtime_component_val) -> void #foreign libwasmtime;
/** \brief Create an empty vec */
wasmtime_component_valtuple_new_empty :: (out: *wasmtime_component_valtuple_t) -> void #foreign libwasmtime;
/** \brief Create a vec with length \p size */
wasmtime_component_valtuple_new_uninit :: (out: *wasmtime_component_valtuple_t, size: u64) -> void #foreign libwasmtime;
/** \brief Copy \p src to \p dst */
wasmtime_component_valtuple_copy :: (dst: *wasmtime_component_valtuple_t, src: *wasmtime_component_valtuple_t) -> void #foreign libwasmtime;
/** \brief Delete \p value */
wasmtime_component_valtuple_delete :: (value: *wasmtime_component_valtuple_t) -> void #foreign libwasmtime;
/** \brief A vec of a type */
wasmtime_component_valflags :: struct {
    /** Length of the vec */
    size: u64;
    data: *wasm_name_t;
}
/** \brief A vec of a type */
wasmtime_component_valflags_t :: wasmtime_component_valflags;
/** \brief Create vec from \p ptr and \p size */
wasmtime_component_valflags_new :: (out: *wasmtime_component_valflags_t, size: u64, ptr: *wasm_name_t) -> void #foreign libwasmtime;
/** \brief Create an empty vec */
wasmtime_component_valflags_new_empty :: (out: *wasmtime_component_valflags_t) -> void #foreign libwasmtime;
/** \brief Create a vec with length \p size */
wasmtime_component_valflags_new_uninit :: (out: *wasmtime_component_valflags_t, size: u64) -> void #foreign libwasmtime;
/** \brief Copy \p src to \p dst */
wasmtime_component_valflags_copy :: (dst: *wasmtime_component_valflags_t, src: *wasmtime_component_valflags_t) -> void #foreign libwasmtime;
/** \brief Delete \p value */
wasmtime_component_valflags_delete :: (value: *wasmtime_component_valflags_t) -> void #foreign libwasmtime;

/// Represents a variant type
wasmtime_component_valvariant_t :: struct {
    /// The discriminant of the variant
    discriminant: wasm_name_t;

    /// The payload of the variant
    val:          *wasmtime_component_val;
}

/// Represents a result type
wasmtime_component_valresult_t :: struct {
    /// The discriminant of the result
    is_ok: bool;

    /// The 'ok' value if #wasmtime_component_valresult_t::is_ok is `true`, else
    /// the 'err' value
    val:   *wasmtime_component_val;
}

/// \brief Represents possible runtime values which a component function can
/// either consume or produce
wasmtime_component_valunion_t :: union {
    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_BOOL
    boolean:     bool;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_S8
    _s8:         s8;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_U8
    _u8:         u8;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_S16
    _s16:        s16;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_U16
    _u16:        u16;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_S32
    _s32:        s32;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_U32
    _u32:        u32;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_S64
    _s64:        s64;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_U64
    _u64:        u64;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_F32
    f32:         float32_t;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_F64
    f64:         float64_t;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_CHAR
    character:   u32;

    /// Field used if #wasmtime_component_val_t::kind is
    /// #WASMTIME_COMPONENT_STRING
    _string:     wasm_name_t;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_LIST
    list:        wasmtime_component_vallist_t;

    /// Field used if #wasmtime_component_val_t::kind is
    /// #WASMTIME_COMPONENT_RECORD
    record:      wasmtime_component_valrecord_t;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_TUPLE
    tuple:       wasmtime_component_valtuple_t;

    /// Field used if #wasmtime_component_val_t::kind is
    /// #WASMTIME_COMPONENT_VARIANT
    variant:     wasmtime_component_valvariant_t;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_ENUM
    enumeration: wasm_name_t;

    /// Field used if #wasmtime_component_val_t::kind is
    /// #WASMTIME_COMPONENT_OPTION
    option:      *wasmtime_component_val;

    /// Field used if #wasmtime_component_val_t::kind is
    /// #WASMTIME_COMPONENT_RESULT
    result:      wasmtime_component_valresult_t;

    /// Field used if #wasmtime_component_val_t::kind is #WASMTIME_COMPONENT_FLAGS
    flags:       wasmtime_component_valflags_t;

    /// Field used if #wasmtime_component_val_t::kind is
    /// #WASMTIME_COMPONENT_RESOURCE
    resource:    *wasmtime_component_resource_any_t;
}

/// \brief Represents possible runtime values which a component function can
/// either consume or produce
wasmtime_component_val :: struct {
    /// The type discriminant
    kind: wasmtime_component_valkind_t;

    /// Value of type \ref kind
    of:   wasmtime_component_valunion_t;
}

/// \brief Represents possible runtime values which a component function can
/// either consume or produce
wasmtime_component_val_t :: wasmtime_component_val;

/// \brief A pair of a name and a value that represents one entry in a value
/// with kind #WASMTIME_COMPONENT_RECORD
wasmtime_component_valrecord_entry :: struct {
    /// The name of this entry
    name: wasm_name_t;

    /// The value of this entry
    val:  wasmtime_component_val_t;
}

/// \brief A pair of a name and a value that represents one entry in a value
/// with kind #WASMTIME_COMPONENT_RECORD
wasmtime_component_valrecord_entry_t :: wasmtime_component_valrecord_entry;

/// \brief Allocates a new `wasmtime_component_val_t` on the heap, initializing
/// it with the contents of `val`.
///
/// This function is intended to be used with the `variant`, `result`, and
/// `option` fields of `wasmtime_component_valunion_t`. The returned pointer
/// must be deallocated with `wasmtime_component_val_free` to deallocate the
/// heap-owned pointer. The `val` provided is "taken" meaning that its contents
/// are transferred to the returned pointer. This is not a clone operation but
/// instead is an operation used to move `val` onto a Wasmtime-defined heap
/// allocation.
///
/// Note that `wasmtime_component_val_delete` should not be used for
/// deallocating the return value because that will deallocate the contents of
/// the value but not the value pointer itself.
wasmtime_component_val_new :: (val: *wasmtime_component_val_t) -> *wasmtime_component_val_t #foreign libwasmtime;

/// \brief Deallocates the heap-allocated value at `ptr`.
///
/// This function will perform `wasmtime_component_val_delete` on `ptr` and
/// then it will deallocate `ptr` itself. This should not be used on
/// embedder-owned `ptr` storage. This function is used to clean up
/// allocations made by `wasmtime_component_val_new`.
wasmtime_component_val_free :: (ptr: *wasmtime_component_val_t) -> void #foreign libwasmtime;

/// \brief Performs a deep copy of the provided `src`, storing the results into
/// `dst`.
///
/// The `dst` value must have `wasmtime_component_val_delete` run to discard
/// its contents.
wasmtime_component_val_clone :: (src: *wasmtime_component_val_t, dst: *wasmtime_component_val_t) -> void #foreign libwasmtime;

/// \brief Deallocates any memory owned by `value`.
///
/// This function will look at `value->kind` and deallocate any memory if
/// necessary. For example lists will deallocate
/// `value->of.list`.
///
/// Note that this function is not to be confused with
/// `wasmtime_component_val_free` which not only deallocates the memory that
/// `value` owns but also deallocates the memory of `value` itself. This
/// function should only be used when the embedder owns the pointer `value`
/// itself.
wasmtime_component_val_delete :: (value: *wasmtime_component_val_t) -> void #foreign libwasmtime;

/// \brief Representation of a function in Wasmtime.
///
/// Functions in Wasmtime are represented as an index into a store and don't
/// have any data or destructor associated with the value. Functions cannot
/// interoperate between #wasmtime_store_t instances and if the wrong function
/// is passed to the wrong store then it may trigger an assertion to abort the
/// process.
wasmtime_component_func :: struct {
    struct {
        /// Internal identifier of what store this belongs to, never zero.
        store_id:   u64;

        /// Private internal wasmtime information.
        __private1: u32;
    }

    /// Private internal wasmtime information.
    __private2: u32;
}

/// \brief Representation of a function in Wasmtime.
///
/// Functions in Wasmtime are represented as an index into a store and don't
/// have any data or destructor associated with the value. Functions cannot
/// interoperate between #wasmtime_store_t instances and if the wrong function
/// is passed to the wrong store then it may trigger an assertion to abort the
/// process.
wasmtime_component_func_t :: wasmtime_component_func;

/// \brief Returns the type of this function.
///
/// The caller must deallocate the returned pointer with
/// `wasmtime_component_func_type_delete`.
wasmtime_component_func_type :: (func: *wasmtime_component_func_t, _context: *wasmtime_context_t) -> *wasmtime_component_func_type_t #foreign libwasmtime;

/**
* \brief Invokes \p func with the \p args given and returns the result.
*
* The \p args provided must match the parameters that this function takes in
* terms of their types and the number of parameters. Results will be written to
* the \p results provided if the call completes successfully. The initial types
* of the values in \p results are ignored and values are overwritten to write
* the result. It's required that the \p results_size exactly matches the number
* of results that this function produces.
*/
wasmtime_component_func_call :: (func: *wasmtime_component_func_t, _context: *wasmtime_context_t, args: *wasmtime_component_val_t, args_size: u64, results: *wasmtime_component_val_t, results_size: u64) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief No longer needs to be called; this function has no effect.
*
* \deprecated Previously, this invoked the `post-return` canonical ABI option,
* if specified, after a #wasmtime_component_func_call had finished.  Now that's
* taken care of automatically as part of #wasmtime_component_func_call, so this
* function is no longer needed, and any calls to it may be removed.
*/
wasmtime_component_func_post_return :: (func: *wasmtime_component_func_t, _context: *wasmtime_context_t) -> *wasmtime_error_t #foreign libwasmtime;

/// \brief Representation of a instance in Wasmtime.
///
/// Instances are represented with a 64-bit identifying integer in Wasmtime.
/// They do not have any destructor associated with them. Instances cannot
/// interoperate between #wasmtime_store_t instances and if the wrong instance
/// is passed to the wrong store then it may trigger an assertion to abort the
/// process.
wasmtime_component_instance :: struct {
    /// Internal identifier of what store this belongs to, never zero.
    store_id:  u64;

    /// Internal index within the store.
    __private: u32;
}

/// \brief Representation of a instance in Wasmtime.
///
/// Instances are represented with a 64-bit identifying integer in Wasmtime.
/// They do not have any destructor associated with them. Instances cannot
/// interoperate between #wasmtime_store_t instances and if the wrong instance
/// is passed to the wrong store then it may trigger an assertion to abort the
/// process.
wasmtime_component_instance_t :: wasmtime_component_instance;

/**
* \brief A methods similar to #wasmtime_component_get_export_index except for
* this instance.
*
* \param instance the instance to look up \p name in
* \param context the context where \p instance lives in
* \param instance_export_index optional (i.e. nullable) instance to look up in
* \param name the name of the export
* \param name_len length of \p name in bytes
* \return export index if found, else NULL
*/
wasmtime_component_instance_get_export_index :: (instance: *wasmtime_component_instance_t, _context: *wasmtime_context_t, instance_export_index: *wasmtime_component_export_index_t, name: *u8, name_len: u64) -> *wasmtime_component_export_index_t #foreign libwasmtime;

/**
* \brief Looks up an exported function by name within this
* #wasmtime_component_instance_t.
*
* \param instance the instance to look up this name in
* \param context the store that \p instance lives in
* \param export_index the export index of the function
* \param func_out if found, the function corresponding to \p name
* \return boolean marking if a function for \p name was found
*/
wasmtime_component_instance_get_func :: (instance: *wasmtime_component_instance_t, _context: *wasmtime_context_t, export_index: *wasmtime_component_export_index_t, func_out: *wasmtime_component_func_t) -> bool #foreign libwasmtime;

wasmtime_component_linker_t :: struct {}

wasmtime_component_linker_instance_t :: struct {}

/**
* \brief Creates a new #wasmtime_component_linker_t for the specified engine.
*
* \param engine the compilation environment and configuration
*
* \return a pointer to the newly created #wasmtime_component_linker_t
*/
wasmtime_component_linker_new :: (engine: *wasm_engine_t) -> *wasmtime_component_linker_t #foreign libwasmtime;

/**
* \brief Configures whether this linker allows later definitions to shadow
* previous definitions.
*
* By default this setting is `false`.
*/
wasmtime_component_linker_allow_shadowing :: (linker: *wasmtime_component_linker_t, allow: bool) -> void #foreign libwasmtime;

/**
* \brief Returns the "root instance" of this linker, used to define names into
* the root namespace.
*
* \warning This acquires exclusive access to the \p linker. The \p linker
* *MUST* not be accessed by anything until the returned
* #wasmtime_component_linker_instance_t in \p linker_instance_out is destroyed
* by #wasmtime_component_linker_instance_delete.
*/
wasmtime_component_linker_root :: (linker: *wasmtime_component_linker_t) -> *wasmtime_component_linker_instance_t #foreign libwasmtime;

/**
* \brief Instantiates a component instance in a given #wasmtime_context_t
*
* \param linker a #wasmtime_component_linker_t that will help provide host
*        functions
* \param context the #wasmtime_context_t in which the instance should be
*        created
* \param component the #wasmtime_component_t to instantiate
* \param instance_out on success, the instantiated
*        #wasmtime_component_instance_t
*
* \return wasmtime_error_t* on success `NULL` is returned, otherwise an error
*         is returned which describes why the build failed.
*/
wasmtime_component_linker_instantiate :: (linker: *wasmtime_component_linker_t, _context: *wasmtime_context_t, component: *wasmtime_component_t, instance_out: *wasmtime_component_instance_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Defines all unknown imports of `component` as trapping functions.
*/
wasmtime_component_linker_define_unknown_imports_as_traps :: (linker: *wasmtime_component_linker_t, component: *wasmtime_component_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Deletes a #wasmtime_component_linker_t created by
* #wasmtime_component_linker_new
*
* \param linker the #wasmtime_component_linker_t to delete
*/
wasmtime_component_linker_delete :: (linker: *wasmtime_component_linker_t) -> void #foreign libwasmtime;

/**
* \brief Defines a nested instance within this instance.
*
* This can be used to describe arbitrarily nested levels of instances within a
* linker to satisfy nested instance exports of components.
*
* \warning This acquires exclusive access to the \p linker_instance. The \p
* linker_instance *MUST* not be accessed by anything until the returned
* #wasmtime_component_linker_instance_t in \p linker_instance_out is destroyed
* by #wasmtime_component_linker_instance_delete.
*
* \param linker_instance the linker instance from which the new one is created
* \param name new instance name
* \param name_len length of \p name in bytes
* \param linker_instance_out on success, the new
* #wasmtime_component_linker_instance_t
* \return on success `NULL`, otherwise an error
*/
wasmtime_component_linker_instance_add_instance :: (linker_instance: *wasmtime_component_linker_instance_t, name: *u8, name_len: u64, linker_instance_out: **wasmtime_component_linker_instance_t) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Defines a #wasmtime_module_t within this instance.
*
* This can be used to provide a core wasm #wasmtime_module_t as an import
* to a component. The #wasmtime_module_t provided is saved within the
* linker for the specified \p name in this instance.
*
* \param linker_instance the instance to define the module in
* \param name the module name
* \param name_len length of \p name in bytes
* \param module the module
* \return on success `NULL`, otherwise an error
*/
wasmtime_component_linker_instance_add_module :: (linker_instance: *wasmtime_component_linker_instance_t, name: *u8, name_len: u64, module: *wasmtime_module_t) -> *wasmtime_error_t #foreign libwasmtime;

/// Type of the callback used in #wasmtime_component_linker_instance_add_func
wasmtime_component_func_callback_t :: #type (unknown0: *void, unknown1: *wasmtime_context_t, unknown2: *wasmtime_component_func_type_t, unknown3: *wasmtime_component_val_t, unknown4: u64, unknown5: *wasmtime_component_val_t, unknown6: u64) -> *wasmtime_error_t #c_call;

/**
* \brief Define a function within this instance.
*
* \param linker_instance the instance to define the function in
* \param name the module name
* \param name_len length of \p name in bytes
* \param callback the callback when this function gets called
* \param data host-specific data passed to the callback invocation, can be
* `NULL`
* \param finalizer optional finalizer for \p data, can be `NULL`
* \return on success `NULL`, otherwise an error
*/
wasmtime_component_linker_instance_add_func :: (linker_instance: *wasmtime_component_linker_instance_t, name: *u8, name_len: u64, callback: wasmtime_component_func_callback_t, data: *void, finalizer: #type (unknown0: *void) -> void #c_call) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Add all WASI interfaces into the \p linker provided.
*/
wasmtime_component_linker_add_wasip2 :: (linker: *wasmtime_component_linker_t) -> *wasmtime_error_t #foreign libwasmtime;

/// Type of the callback used in
/// #wasmtime_component_linker_instance_add_resource
wasmtime_component_resource_destructor_t :: #type (unknown0: *void, unknown1: *wasmtime_context_t, unknown2: u32) -> *wasmtime_error_t #c_call;

/**
* \brief Defines a new resource type within this instance.
*
* This can be used to define a new resource type that the guest will be able
* to import. Here the `resource` is a type, often a host-defined type, which
* can be used to distinguish and definie different types of resources. A
* destruction callback is also specified via `destructor` which has private
* data `data` along with an optional `finalizer` for the `data` too.
*
* \return on success `NULL`, otherwise an error
*/
wasmtime_component_linker_instance_add_resource :: (linker_instance: *wasmtime_component_linker_instance_t, name: *u8, name_len: u64, resource: *wasmtime_component_resource_type_t, destructor: wasmtime_component_resource_destructor_t, data: *void, finalizer: #type (unknown0: *void) -> void #c_call) -> *wasmtime_error_t #foreign libwasmtime;

/**
* \brief Deletes a #wasmtime_component_linker_instance_t
*
* \param linker_instance the #wasmtime_component_linker_instance_t to delete
*/
wasmtime_component_linker_instance_delete :: (linker_instance: *wasmtime_component_linker_instance_t) -> void #foreign libwasmtime;

/**
* \brief Converts from the text format of WebAssembly to the binary format.
*
* \param wat this it the input pointer with the WebAssembly Text Format inside
*        of it. This will be parsed and converted to the binary format.
* \param wat_len this it the length of `wat`, in bytes.
* \param ret if the conversion is successful, this byte vector is filled in
*        with the WebAssembly binary format.
*
* \return a non-null error if parsing fails, or returns `NULL`. If parsing
* fails then `ret` isn't touched.
*
* This function does not take ownership of `wat`, and the caller is expected to
* deallocate the returned #wasmtime_error_t and #wasm_byte_vec_t.
*/
wasmtime_wat2wasm :: (wat: *u8, wat_len: u64, ret: *wasm_byte_vec_t) -> *wasmtime_error_t #foreign libwasmtime;

#scope_file


#if OS == .LINUX {
    libwasmtime :: #library "lib/linux/libwasmtime";
} else #if OS == .WINDOWS {
    libwasmtime :: #library,no_dll "lib/windows/libwasmtime";
} else #if OS == .MACOS {
    libwasmtime :: #library "lib/macos/libwasmtime";
}

