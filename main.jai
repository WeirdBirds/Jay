#import "Basic"()(MEMORY_DEBUGGER = true);
#import "Jay_Render";
#import "Jay_Core";

main :: () {
    engine: Engine(Packages(Jay_Render));

    run(*engine);
    report_memory_leaks();
}
