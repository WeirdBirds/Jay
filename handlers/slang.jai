#import "Jay_Render";
#import "Process";
#import "Basic";

import :: (in: string) -> Shader_Data {
    success, code := run_command("slangc", in, "-matrix-layout-row-major", "-target", "spirv", "-profile", "spirv_1_5", capture_and_return_output = true);
    return .{ code };
}
