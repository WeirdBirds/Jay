#import "Basic";
using WASM :: #import "Jay_WASM";

main :: () {
    assert(WASM.WASMTIME_I32 == 0);

    config := WASM.wasm_config_new();
    assert(config != null);

    WASM.wasm_config_delete(config);
}
