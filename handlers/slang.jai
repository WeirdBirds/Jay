// Compile-time handler: .slang source -> Shader_Data { code_words = SPIR-V bytes }.
// Runs inside the compiler at asset-import time (#run). The JAY_STAGE stage macro
// is injected by sgpu's compile_shader from the path convention
// (/vertex/ -> 0, /fragment/ -> 1, /compute/ -> 2).
#import "Basic";
#import "File";
#import "String";
#import "sgpu";
#import "Jay_Render";

import :: (in_path: string) -> Shader_Data {
    ok, spirv := compile_shader(in_path);
    assert(ok, "slang handler: failed to compile shader '%'", in_path);
    return .{ code_words = spirv, reflection = "" };
}
