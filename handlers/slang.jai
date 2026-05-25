#import "Jay_Render";
#import "Process";
#import "Basic";

SPIRV_MAGIC :: 0x07230203;

import :: (in: string) -> Shader_Data {
    result, code, error_string := run_command("slangc", in, "-matrix-layout-row-major", "-target", "spirv", "-profile", "spirv_1_5", capture_and_return_output = true);
    defer free(error_string);
    defer free(code.data);

    assert(result.type == .EXITED && result.exit_code == 0, "Failed to compile shader '%': %", in, error_string);
    assert(code.count > 0, "Shader compiler produced no output for '%'.", in);
    assert((code.count % size_of(u32)) == 0, "Shader compiler output for '%' is not valid SPIR-V bytecode (size % is not a multiple of 4).", in, code.count);

    magic: u32;
    memcpy(*magic, code.data, size_of(u32));
    assert(magic == SPIRV_MAGIC, "Shader compiler output for '%' is not SPIR-V bytecode (bad magic 0x%).", in, formatInt(magic, base=16));

    word_count := code.count / size_of(u32);
    code_words := NewArray(word_count, u32);
    memcpy(code_words.data, code.data, code.count);

    return .{ code_words = code_words };
}
