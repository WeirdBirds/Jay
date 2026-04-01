#import "Basic";

Allocator_Shims :: #import "WASM_Bump_Allocator";

#program_export
add_one :: (value: s32) -> s32 #c_call {
    local_context: #Context;
    local_context.allocator = .{Allocator_Shims.allocator_proc, null};

    result_value: s32 = -1;
    push_context local_context {
        result := New(s32);
        if result {
            result.* = value + 1;
            result_value = result.*;
        }
    }

    return result_value;
}
