#import "Basic";
#import "Jay_ECS";
#import "Jay_Logger";

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

SOME_COUNT :: 999;


main :: () {

    context.logger = jay_logger;

    world: World(.[test_iter, test_each, test_random, test_default, test_bach, additional, bench_spawn, bench_touch, bench_reap, bench_on_created, bench_on_changed, bench_on_destroyed]);

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

        new_entity(*world, components);
    }
    // dump(world);

    // log("=== === === === === === === === === === === === ");
    for 0..9 {
        start := current_time_consensus();
        progress(*world, 0.1);
        log("TICK %: % μs created=% changed=% destroyed=%", it, to_microseconds(current_time_consensus() - start), bench_created, bench_changed, bench_destroyed);
    }

    // dump(world);
    free(world);

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
    for 0..e.count-1 {
        // print("% ", it);
        c1[it].val1 += 1;
        c2[it].vala1 += 1;
        c3[it].valb1 += 1;
        c4[it].valc2.index += 1;
    }
} @batch_size:8

Destruction1 :: struct {v: s32;}
Destruction2 :: struct {v: s64;}

additional :: (d1: Destruction1, d2: Destruction2) {}

// --- Reactive benchmark: spawn 10/tick, touch a subset, reap 3/tick ---
bench_created := 0;
bench_changed := 0;
bench_destroyed := 0;

bench_spawn :: () {
    for 0..9 new_entity(Component1.{xx it, "S"}, Component3.{});
}

bench_touch :: (e: Entity, c1: *Component1) {
    if c1.val1 % 7 == 0 set(e, Component1.{c1.val1, c1.val2});
} @after:bench_spawn

bench_reap :: (query: Query(Component1)) {
    n := 0;
    for query {
        if n >= 3 break;
        destroy(it);
        n += 1;
    }
} @after:bench_touch

bench_on_created :: (e: Entity, ev: Component_Event(Component1)) { bench_created += 1; } @on:created(Component1)
bench_on_changed :: (e: Entity, ev: Component_Event(Component1)) { bench_changed += 1; } @on:changed(Component1)
bench_on_destroyed :: (e: Entity, ev: Component_Event(Component1)) { bench_destroyed += 1; } @on:destroyed(Component1)
