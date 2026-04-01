// Bindings generator for Wasmtime C API (v42.0.1)
// Run: jai generate.jai

#run generate_bindings();

generate_bindings :: () -> bool {
    set_build_options_dc(.{ do_output = false });

    output_filename: string;
    opts: Generate_Bindings_Options;
    {
        using opts;

        if OS == {
            case .LINUX;   output_filename = "linux.jai";
            case .WINDOWS; output_filename = "windows.jai";
            case .MACOS;   output_filename = "macos.jai";
            case; assert(false, "Unsupported OS for Jay_WASM bindings generation.");
        }

        array_add(*source_files, "include/wasmtime.h");

        array_add(*libraries, .{
            filename   = "libwasmtime.so",
            identifier = "libwasmtime",
        });

        array_add(*library_search_paths, "lib/linux");

        array_add(*include_paths, "include");

        array_add(*extra_clang_arguments,
            "-x", "c",
            "-DWASM_API_EXTERN=",
            "-DWASI_API_EXTERN=",
        );

        generate_library_declarations = false;
        generate_compile_time_struct_checks = false;
        log_stripped_declarations = false;
        try_to_preserve_comments = true;
        generate_printf_wrappers = false;

        header = "ptrdiff_t :: s64;\n\n";
        visitor = wasmtime_visitor;
        footer = FOOTER;
    }

    return generate_bindings(opts, output_filename);
}

#scope_file

wasmtime_visitor :: (decl: *Declaration, parent_decl: *Declaration) -> result: Declaration_Visit_Result = .RECURSE {
    return;
}

#import "Basic";
#import "Bindings_Generator";
#import "Compiler";
#import "File";
#import "String";

FOOTER :: #string __wasmtime_footer

#if OS == .LINUX {
    libwasmtime :: #library "lib/linux/libwasmtime";
} else #if OS == .WINDOWS {
    libwasmtime :: #library,no_dll "lib/windows/libwasmtime";
} else #if OS == .MACOS {
    libwasmtime :: #library "lib/macos/libwasmtime";
}

__wasmtime_footer;
