ARENA_SIZE  :: 4 * 1024 * 1024;
ALIGNMENT   :: 16;

allocator :: Allocator.{allocator_proc, null};

arena_storage: [ARENA_SIZE]u8;
arena_used: s64;

align_up :: (value: s64, alignment: s64) -> s64 {
    return ((value + alignment - 1) / alignment) * alignment;
}

in_arena :: (memory: *void) -> bool {
    if !memory return false;

    start := cast(s64) arena_storage.data;
    p := cast(s64) memory;
    return p >= start && p < start + ARENA_SIZE;
}

allocate_bytes :: (size: s64) -> *void {
    if size <= 0 return null;

    start := align_up(arena_used, ALIGNMENT);
    end := start + size;
    if end > ARENA_SIZE return null;

    memory := cast(*void) (arena_storage.data + start);
    arena_used = end;
    return memory;
}

allocator_proc :: (mode: Allocator_Mode, requested_size: s64, old_size: s64, old_memory: *void, allocator_data: *void) -> *void {
    if #complete mode == {
        case .ALLOCATE;
            return allocate_bytes(requested_size);

        case .RESIZE;
            if !old_memory return allocate_bytes(requested_size);
            if requested_size <= old_size return old_memory;

            new_memory := allocate_bytes(requested_size);
            if !new_memory return null;

            memcpy(new_memory, old_memory, old_size);
            return new_memory;

        case .FREE;
            return null;

        case .STARTUP;
            arena_used = 0;
            return null;

        case .SHUTDOWN;
            arena_used = 0;
            return null;

        case .THREAD_START;
            return null;

        case .THREAD_STOP;
            return null;

        case .CREATE_HEAP;
            return null;

        case .DESTROY_HEAP;
            return null;

        case .IS_THIS_YOURS;
            return cast(*void) cast(s64) in_arena(old_memory);

        case .CAPS;
            if old_memory {
                (cast(*string) old_memory).* = "Jay_WASM test bump allocator";
            }
            return cast(*void) (Allocator_Caps.HINT_I_AM_A_FAST_BUMP_ALLOCATOR | .IS_THIS_YOURS);
    }
}
