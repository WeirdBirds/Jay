#import "Basic"()(MEMORY_DEBUGGER = true);
#import "Jay_Render";
#import "Jay_Core";
// #import "Jay_Logger";

main :: () {

    engine: Engine(Packages(Jay_Render, Jay_Logger_CLI));

    run(*engine);
    report_memory_leaks();
}
