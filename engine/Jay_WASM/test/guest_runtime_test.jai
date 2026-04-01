#import "Basic";
#import "File";
using WASM :: #import "Jay_WASM";

panic_with_error :: (error: *WASM.wasmtime_error_t) {
    assert(error != null);

    message: WASM.wasm_name_t;
    WASM.wasmtime_error_message(error, *message);
    defer WASM.wasm_byte_vec_delete(*message);
    defer WASM.wasmtime_error_delete(error);

    text := string.{
        data  = cast(*u8) message.data,
        count = cast(int) message.size,
    };

    assert(false, "%", text);
}

panic_with_trap :: (trap: *WASM.wasm_trap_t) {
    defer WASM.wasm_trap_delete(trap);
    assert(false, "wasmtime trapped while executing guest wasm");
}

wasm_debug_break_callback :: (
    env: *void,
    caller: *WASM.wasmtime_caller_t,
    args: *WASM.wasmtime_val_t,
    nargs: u64,
    results: *WASM.wasmtime_val_t,
    nresults: u64
) -> *WASM.wasm_trap_t #c_call {
    return null;
}

wasm_write_string_callback :: (
    env: *void,
    caller: *WASM.wasmtime_caller_t,
    args: *WASM.wasmtime_val_t,
    nargs: u64,
    results: *WASM.wasmtime_val_t,
    nresults: u64
) -> *WASM.wasm_trap_t #c_call {
    return null;
}

get_caller_memory :: (caller: *WASM.wasmtime_caller_t) -> *u8, u64, bool #no_context {
    item: WASM.wasmtime_extern_t;
    found := WASM.wasmtime_caller_export_get(caller, "memory".data, 6, *item);
    if !found return null, 0, false;
    defer WASM.wasmtime_extern_delete(*item);

    if item.kind != WASM.WASMTIME_EXTERN_MEMORY return null, 0, false;

    wasm_context := WASM.wasmtime_caller_context(caller);
    memory := item.of.memory;
    data := WASM.wasmtime_memory_data(wasm_context, *memory);
    size := WASM.wasmtime_memory_data_size(wasm_context, *memory);
    return data, size, data != null;
}

memcmp_callback :: (
    env: *void,
    caller: *WASM.wasmtime_caller_t,
    args: *WASM.wasmtime_val_t,
    nargs: u64,
    results: *WASM.wasmtime_val_t,
    nresults: u64
) -> *WASM.wasm_trap_t #c_call {
    if nargs != 3 || nresults != 1 return null;

    memory_data, memory_size, ok := get_caller_memory(caller);
    if !ok {
        results[0].kind = WASM.WASMTIME_I32;
        results[0].of.i32 = 0;
        return null;
    }

    left_offset := cast(u64) args[0].of.i64;
    right_offset := cast(u64) args[1].of.i64;
    count := cast(u64) args[2].of.i64;

    result: s32 = 0;

    if left_offset + count <= memory_size && right_offset + count <= memory_size {
        left := memory_data + cast(s64) left_offset;
        right := memory_data + cast(s64) right_offset;

        i: u64 = 0;
        while i < count {
            a := left[cast(s64) i];
            b := right[cast(s64) i];
            if a < b {
                result = -1;
                break;
            }
            if a > b {
                result = 1;
                break;
            }

            i += 1;
        }
    }

    results[0].kind = WASM.WASMTIME_I32;
    results[0].of.i32 = result;
    return null;
}

define_jai_runtime_imports :: (
    linker: *WASM.wasmtime_linker_t,
    module: *WASM.wasmtime_module_t
) {
    imports: WASM.wasm_importtype_vec_t;
    WASM.wasmtime_module_imports(module, *imports);
    defer WASM.wasm_importtype_vec_delete(*imports);

    for i: 0..xx imports.size-1 {
        import_type := imports.data[i];
        module_name := WASM.wasm_importtype_module(import_type);
        field_name := WASM.wasm_importtype_name(import_type);

        module_text := string.{ data = cast(*u8) module_name.data, count = cast(int) module_name.size };
        field_text := string.{ data = cast(*u8) field_name.data, count = cast(int) field_name.size };

        if module_text != "env" continue;

        extern_type := WASM.wasm_importtype_type(import_type);
        func_type := WASM.wasm_externtype_as_functype_const(extern_type);
        assert(func_type != null, "expected function import for %.%", module_text, field_text);

        owned_type := WASM.wasm_functype_copy(func_type);
        assert(owned_type != null);
        defer WASM.wasm_functype_delete(owned_type);

        error: *WASM.wasmtime_error_t = null;
        if field_text == "wasm_write_string" {
            error = WASM.wasmtime_linker_define_func(
                linker,
                cast(*u8) module_text.data,
                cast(u64) module_text.count,
                cast(*u8) field_text.data,
                cast(u64) field_text.count,
                owned_type,
                wasm_write_string_callback,
                null,
                null
            );
        } else {
            if field_text == "wasm_debug_break" {
                error = WASM.wasmtime_linker_define_func(
                    linker,
                    cast(*u8) module_text.data,
                    cast(u64) module_text.count,
                    cast(*u8) field_text.data,
                    cast(u64) field_text.count,
                    owned_type,
                    wasm_debug_break_callback,
                    null,
                    null
                );
            } else if field_text == "memcmp" {
                error = WASM.wasmtime_linker_define_func(
                    linker,
                    cast(*u8) module_text.data,
                    cast(u64) module_text.count,
                    cast(*u8) field_text.data,
                    cast(u64) field_text.count,
                    owned_type,
                    memcmp_callback,
                    null,
                    null
                );
            } else {
                assert(false, "unsupported jai wasm runtime import %.%", module_text, field_text);
            }
        }

        if error != null panic_with_error(error);
    }
}

main :: () {
    guest_path := "engine/Jay_WASM/test/guest.wasm";
    guest_bytes, success := read_entire_file(guest_path, log_errors = true);
    assert(success, "failed to read guest wasm bundle '%'", guest_path);

    engine := WASM.wasm_engine_new();
    assert(engine != null);
    defer WASM.wasm_engine_delete(engine);

    store := WASM.wasmtime_store_new(engine, null, null);
    assert(store != null);
    defer WASM.wasmtime_store_delete(store);

    wasm_context := WASM.wasmtime_store_context(store);
    assert(wasm_context != null);

    module: *WASM.wasmtime_module_t;
    error := WASM.wasmtime_module_new(
        engine,
        cast(*u8) guest_bytes.data,
        cast(u64) guest_bytes.count,
        *module
    );
    if error != null panic_with_error(error);
    defer WASM.wasmtime_module_delete(module);

    linker := WASM.wasmtime_linker_new(engine);
    assert(linker != null);
    defer WASM.wasmtime_linker_delete(linker);

    define_jai_runtime_imports(linker, module);

    trap: *WASM.wasm_trap_t = null;
    instance: WASM.wasmtime_instance_t;
    error = WASM.wasmtime_linker_instantiate(linker, wasm_context, module, *instance, *trap);
    if error != null panic_with_error(error);
    if trap != null panic_with_trap(trap);

    export_name := "add_one";
    export_item: WASM.wasmtime_extern_t;
    found := WASM.wasmtime_instance_export_get(
        wasm_context,
        *instance,
        cast(*u8) export_name.data,
        cast(u64) export_name.count,
        *export_item
    );
    assert(found, "failed to find export '%'", export_name);
    defer WASM.wasmtime_extern_delete(*export_item);

    assert(export_item.kind == WASM.WASMTIME_EXTERN_FUNC, "export '%' was not a function", export_name);

    func := export_item.of.func;

    args: [1]WASM.wasmtime_val;
    args[0].kind = WASM.WASMTIME_I32;
    args[0].of.i32 = 41;

    results: [1]WASM.wasmtime_val;
    results[0] = .{};

    trap = null;
    error = WASM.wasmtime_func_call(wasm_context, *func, args.data, 1, results.data, 1, *trap);
    if error != null panic_with_error(error);
    if trap != null panic_with_trap(trap);

    assert(results[0].kind == WASM.WASMTIME_I32);
    assert(results[0].of.i32 == 42, "guest returned %, expected 42", results[0].of.i32);
}
