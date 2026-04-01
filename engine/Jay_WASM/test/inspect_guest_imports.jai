#import "Basic";
#import "File";
using WASM :: #import "Jay_WASM";

panic_with_error :: (error: *WASM.wasmtime_error_t) {
    message: WASM.wasm_name_t;
    WASM.wasmtime_error_message(error, *message);
    defer WASM.wasm_byte_vec_delete(*message);
    defer WASM.wasmtime_error_delete(error);

    text := string.{ data = cast(*u8) message.data, count = cast(int) message.size };
    assert(false, "%", text);
}

main :: () {
    guest_path := "engine/Jay_WASM/test/guest.wasm";
    guest_bytes, success := read_entire_file(guest_path, log_errors = true);
    assert(success, "failed to read guest wasm bundle '%'", guest_path);

    engine := WASM.wasm_engine_new();
    defer WASM.wasm_engine_delete(engine);

    module: *WASM.wasmtime_module_t;
    error := WASM.wasmtime_module_new(
        engine,
        cast(*u8) guest_bytes.data,
        cast(u64) guest_bytes.count,
        *module
    );
    if error != null panic_with_error(error);
    defer WASM.wasmtime_module_delete(module);

    imports: WASM.wasm_importtype_vec_t;
    WASM.wasmtime_module_imports(module, *imports);
    defer WASM.wasm_importtype_vec_delete(*imports);

    print("import count: %\n", imports.size);

    for i: 0..xx imports.size-1 {
        import_type := imports.data[i];
        module_name := WASM.wasm_importtype_module(import_type);
        field_name := WASM.wasm_importtype_name(import_type);

        module_text := string.{ data = cast(*u8) module_name.data, count = cast(int) module_name.size };
        field_text := string.{ data = cast(*u8) field_name.data, count = cast(int) field_name.size };

        print("- %.%\n", module_text, field_text);
    }
}
