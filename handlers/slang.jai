#import "Jay_Render";
#import "Process";
#import "Basic";

import :: (in: string) -> Shader_Data {
    result, code, error_string := run_command("slangc", in, "-matrix-layout-row-major", "-target", "spirv", "-profile", "spirv_1_5", capture_and_return_output = true);
    defer free(error_string);

    assert(result.type == .EXITED && result.exit_code == 0, "Failed to compile shader '%': %", in, error_string);
    assert(code.count > 0, "Shader compiler produced no output for '%'.", in);
    return .{ code };
}
