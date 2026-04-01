// Jay_WASM — Wasmtime C API bindings (v42.0.1)
// WASM runtime integration for the BlueJay Engine

#if OS == .LINUX {
    #load "linux.jai";
} else #if OS == .WINDOWS {
    #load "windows.jai";
} else #if OS == .MACOS {
    #load "macos.jai";
}
