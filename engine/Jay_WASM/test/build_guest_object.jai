#import "Basic";
#import "Compiler";

#run {
    set_build_options_dc(.{ do_output = false });

    w := compiler_create_workspace("jay_wasm_guest_object");
    opts := get_build_options(w);
    copy_commonly_propagated_fields(get_build_options(), *opts);

    new_path: [..]string;
    array_add(*new_path, "./wasm_shims");
    array_add(*new_path, ..opts.import_path);
    array_add(*new_path, "../../../");
    opts.import_path = new_path;

    opts.output_type = .OBJECT_FILE;
    opts.backend = .LLVM;
    opts.os_target = .WASM;
    opts.cpu_target = .CUSTOM;
    opts.emit_debug_info = .NONE;
    opts.backtrace_on_crash = .OFF;
    opts.stack_trace = false;
    opts.runtime_support_definitions = .OMIT;
    opts.dead_code_elimination = .ALL;
    opts.array_bounds_check = .OFF;
    opts.cast_bounds_check = .OFF;
    opts.null_pointer_check = .OFF;
    opts.arithmetic_overflow_check = .OFF;
    opts.llvm_options.target_system_features = "+bulk-memory";
    opts.llvm_options.enable_split_modules = false;
    opts.llvm_options.function_sections = true;
    opts.output_executable_name = "guest.o";
    opts.output_path = "./";
    opts.append_executable_filename_extension = false;

    set_build_options(opts, w);
    remap_import(w, "*", "Default_Allocator", "WASM_Bump_Allocator");
    add_build_file("guest.jai", w);
}
