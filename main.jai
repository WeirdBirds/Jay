#import "Basic"()(MEMORY_DEBUGGER = true);
#import "Jay_Render";
#import "Jay_Core";

main :: () {
    time := current_time_consensus();
    date := to_calendar(time);

    counter := 0;

    for 0..date.year - 1
        counter += 1;

    log("%", counter);

    engine: Engine(Packages(Jay_Render));

    run(*engine);
    report_memory_leaks();
}
