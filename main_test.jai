#import "Basic"()(MEMORY_DEBUGGER = true);
#import "Jay_ECS";
#import "Jay_Logger";
#import "Jay_Render";

Component1 :: struct {
    val1: s32;
    val2: string;
}

Component2 :: struct {
    vala1: s64;
    vala2: Apollo_Time;
}

Component3 :: struct {
    valb1: s32;
    valb2: float64 = 3.14;
}

Component4 :: struct {
    valc1: String_Builder;
    valc2: Entity;
}

Test_Stages: enum_flags u64 {
    Q_ITER;
    Q_EACH;
    Q_RANDOM;
    DEFAULT;
    BACH;
    MAX;
}

SOME_COUNT :: 999;


main :: () {

    context.logger = jay_logger;

    world: World(systems = .[
        System(test_iter, xx Test_Stages.Q_ITER),
        System(test_each, xx Test_Stages.Q_EACH),
        System(test_random, xx Test_Stages.Q_RANDOM),
        System(test_default, xx Test_Stages.DEFAULT),
        System(test_bach, xx Test_Stages.BACH),
        System(additional, xx Test_Stages.MAX) 
    ]);

    for 0..SOME_COUNT {
        components: [..]Any;
        defer array_free(components);

        array_add(*components, Component1.{ xx it, "HELLO" });
        array_add(*components, Component2.{ xx SOME_COUNT - it, current_time_consensus() });
        array_add(*components, Component3);
        array_add(*components, Component4.{ .{}, .{index = xx it} });

        // log("new_entity: %", components);
        n := it % 10;

        if n > 2 {
            if n <= 6
                array_add(*components, Destruction1);

            if n >= 4
                array_add(*components, Destruction2);
        }

        new_entity(world, components);
    }
    // dump(world);

    // log("=== === === === === === === === === === === === ");
    for 0..9 {
        
        {
            start := current_time_consensus();
            progress(*world, 0.1, Test_Stages.DEFAULT);
            log("DEFAULT: % μs", to_microseconds(current_time_consensus() - start));
        }

        {
            start := current_time_consensus();
            progress(*world, 0.1, Test_Stages.Q_EACH);
            log("EACH:    % μs", to_microseconds(current_time_consensus() - start));
        }

        {
            start := current_time_consensus();
            progress(*world, 0.1, Test_Stages.Q_ITER);
            log("ITER:    % μs", to_microseconds(current_time_consensus() - start));
        }

        {
            start := current_time_consensus();
            progress(*world, 0.1, Test_Stages.Q_RANDOM);
            log("RANDOM:  % μs", to_microseconds(current_time_consensus() - start));
        }


        {
            start := current_time_consensus();
            progress(*world, 0.1, Test_Stages.BACH);
            log("BACH:  % μs", to_microseconds(current_time_consensus() - start));
        }
        log("------------------------");
    }

    // dump(world);
    free(world);
    report_memory_leaks(.{});

    log("%", test_bach);
}

test_default :: inline (entity: Entity, c1: *Component1, c2: *Component2, c3: *Component3, c4: *Component4) {
    c1.val1 += 1;
    c2.vala1 += 1;
    c3.valb1 += 1;
    c4.valc2.index += 1;
} @before:test_each

test_each :: inline (query: Query(Component1, Component2, Component3, Component4)) {
    for query {
        c1, c2, c3, c4 := components();       
        c1.val1 += 1;
        c2.vala1 += 1;
        c3.valb1 += 1;
        c4.valc2.index += 1;
    }
}

test_iter :: inline (query: Query(Component1, Component2, Component3, Component4)) {
    iter1 := get_iter(query, Component1);
    iter2 := get_iter(query, Component2);
    iter3 := get_iter(query, Component3);
    iter4 := get_iter(query, Component4);

    for *c1, index: iter1
        c1.val1 += 1;

    for *c2, index: iter2
        c2.vala1 += 1;

    for *c3, index: iter3
        c3.valb1 += 1;

    for *c4, index: iter4
        c4.valc2.index += 1;
}


test_random :: inline (query: Query(Component1, Component2, Component3, Component4)) {
    for query {
        c1 := get(it, Component1);
        c2 := get(it, Component2);
        c3 := get(it, Component3);
        c4 := get(it, Component4);

        c1.val1 += 1;
        c2.vala1 += 1;
        c3.valb1 += 1;
        c4.valc2.index += 1;
    } 
}


test_bach :: inline (e: []Entity, c1: []Component1, c2: []Component2, c3: []Component3, c4: []Component4) {
    for e
        log("Entity % bach touched", it);
    for 0..3 {
        // print("% ", it);
        c1[it].val1 += 1;
        c2[it].vala1 += 1;
        c3[it].valb1 += 1;
        c4[it].valc2.index += 1;
    }
} @bach_size:8

Destruction1 :: struct {v: s32;}
Destruction2 :: struct {v: s64;}

additional :: (d1: Destruction1, d2: Destruction2) {}
