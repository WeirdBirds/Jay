#import "Basic";
#import "String";
#import "File";
#import "File_Utilities";
#import "Compiler";
#import "Process";
#import "Metaprogram_Plugins";

#run {
    set_build_options_dc(.{ do_output = false });

    main_workspace := compiler_create_workspace(path_filename(trim(#filepath, "/")));

    build_options := get_build_options();

    new_path: [..]string;
    array_add(*new_path, ..build_options.import_path);
    array_add(*new_path, "engine");
    array_add(*new_path, "modules");  // Add this line for Tracy
    build_options.import_path = new_path;

    #if #exists(JAILS_DIAGNOSTICS_BUILD) build_options.output_type = .NO_OUTPUT;

    build_options.backend = .X64;
    set_optimization(*build_options, .DEBUG);
    build_options.array_bounds_check = .ON;

    args := build_options.compile_time_command_line;
    success: bool;

    plugins_to_create: [..] Plugin_To_Create;

    // For custom metaprograms, plugin arguments (+PluginName) are not in compile_time_command_line.
    // We need to use get_toplevel_command_line() and skip the first 2 args (compiler name and build script).
    // Also strip "---" and everything after it — those are default-metaprogram directives
    // (e.g. "--- import_dir <path>" from Jails) that parse_plugin_arguments would incorrectly
    // treat as plugin options.
    toplevel_args := get_toplevel_command_line();
    if toplevel_args.count > 2 {
        filtered_args: [..]string;
        for i: 2..toplevel_args.count - 1 {
            if toplevel_args[i] == "---" break;
            array_add(*filtered_args, toplevel_args[i]);
        }
        success, plugins_to_create, args = parse_plugin_arguments(filtered_args);
    } else {
        success, plugins_to_create, args = parse_plugin_arguments(args);
    }
    
    if !success {
        log_error("Failed to parse plugin arguments.\n");
        exit(1);
    }



    // Process build script arguments.
    // Remaining args from parse_plugin_arguments may include compiler flags
    // passed by Jails (e.g. -quiet, -no_color, -x64, -import_dir) — skip those.
    {
        i := 0;
        while i < args.count {
            defer i += 1;
            arg := args[i];

            if arg == {
                case "o"; #through;
                case "-o";
                    build_options.backend = .LLVM;
                    set_optimization(*build_options, Optimization_Type.OPTIMIZED_VERY_SMALL, false);
                case "debug"; #through;
                case "-do";
                    build_options.backend = .LLVM;
                    build_options.llvm_options.disable_inlining = true;
                    set_optimization(*build_options, Optimization_Type.OPTIMIZED_VERY_SMALL, true);
                case "-";
                    continue;
                case "-quiet"; #through;
                case "-no_color"; #through;
                case "-x64";
                    // Compiler flags passed through by Jails — ignore
                    continue;
                case "-import_dir";
                    // Compiler flag with argument — skip both
                    i += 1;
                    continue;
                case;
                    log("Unknown build argument: '%'", arg);
            }
        }
    }

    build_options.output_type = .EXECUTABLE;
    build_options.output_executable_name = path_filename(trim(#filepath, "/"));
    build_options.output_path = join(#filepath, "bin/");
    make_directory_if_it_does_not_exist(build_options.output_path);

    plugins: [..]*Metaprogram_Plugin;
    success = init_plugins(plugins_to_create, *plugins, main_workspace);
    if !success {
        log_error("A plugin init() failed. Exiting.\n");
        exit(1);
    }

    set_build_options(build_options, main_workspace);

    intercept_flags: Intercept_Flags;
    for plugins if it.before_intercept it.before_intercept(it, *intercept_flags);

    compiler_begin_intercept(main_workspace, intercept_flags);

    for plugins if it.add_source it.add_source(it);
    add_build_file("main.jai", main_workspace);

    message_loop(plugins);

    compiler_end_intercept(main_workspace);

    for plugins if it.finish it.finish(it);
    for plugins if it.shutdown it.shutdown(it);
}

message_loop :: (plugins: []*Metaprogram_Plugin) {
    while true {
        message := compiler_wait_for_message();
        for plugins if it.message it.message(it, message);
        if message.kind == .COMPLETE break;
    }
}
