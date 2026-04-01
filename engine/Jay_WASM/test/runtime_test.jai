#import "Basic";
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

main :: () {
    guest_wat := #string END_OF_WAT
(module
  (func (export "add_one") (param i32) (result i32)
    local.get 0
    i32.const 1
    i32.add))
END_OF_WAT;

    engine := WASM.wasm_engine_new();
    assert(engine != null, "failed to create wasm engine");
    defer WASM.wasm_engine_delete(engine);

    store := WASM.wasmtime_store_new(engine, null, null);
    assert(store != null, "failed to create wasmtime store");
    defer WASM.wasmtime_store_delete(store);

    wasm_context := WASM.wasmtime_store_context(store);
    assert(wasm_context != null, "failed to get wasmtime context");

    guest_bytes: WASM.wasm_byte_vec_t;
    error := WASM.wasmtime_wat2wasm(
        cast(*u8) guest_wat.data,
        cast(u64) guest_wat.count,
        *guest_bytes
    );
    if error != null panic_with_error(error);
    defer WASM.wasm_byte_vec_delete(*guest_bytes);

    module: *WASM.wasmtime_module_t;
    error = WASM.wasmtime_module_new(
        engine,
        cast(*u8) guest_bytes.data,
        cast(u64) guest_bytes.size,
        *module
    );
    if error != null panic_with_error(error);
    defer WASM.wasmtime_module_delete(module);

    trap: *WASM.wasm_trap_t = null;
    instance: WASM.wasmtime_instance_t;
    error = WASM.wasmtime_instance_new(wasm_context, module, null, 0, *instance, *trap);
    if error != null panic_with_error(error);
    if trap  != null panic_with_trap(trap);

    export_name := "add_one";
    export_item: WASM.wasmtime_extern_t;
    found := WASM.wasmtime_instance_export_get(
        wasm_context,
        *instance,
        cast(*u8) export_name.data,
        cast(u64) export_name.count,
        *export_item
    );
    assert(found, "failed to find exported guest function '%'", export_name);
    defer WASM.wasmtime_extern_delete(*export_item);

    assert(
        export_item.kind == WASM.WASMTIME_EXTERN_FUNC,
        "export '%' was not a function",
        export_name
    );

    func := export_item.of.func;

    args: [1]WASM.wasmtime_val;
    args[0].kind = WASM.WASMTIME_I32;
    args[0].of.i32 = 41;

    results: [1]WASM.wasmtime_val;
    results[0] = .{};

    trap = null;
    error = WASM.wasmtime_func_call(wasm_context, *func, args.data, 1, results.data, 1, *trap);
    if error != null panic_with_error(error);
    if trap  != null panic_with_trap(trap);

    assert(results[0].kind == WASM.WASMTIME_I32, "guest returned unexpected value kind");
    assert(results[0].of.i32 == 42, "guest returned %, expected 42", results[0].of.i32);
}
