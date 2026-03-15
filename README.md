# Jay Engine

A game/rendering engine written in the **Jai** programming language.

## Overview

Jay is a modular game engine built with Jai, featuring:
- **ECS** - Archetype-based Entity Component System
- **Rendering** - Vulkan renderer with SDL3 windowing
- **Math** - Vectors, matrices, quaternions with SIMD support
- **Logging** - Colored console logging with timestamps

## Building

Requires the Jai compiler (expected at `~/jai/`).

```bash
# Debug build (X64 backend, bounds checking ON)
jai build.jai

# Debug with optimizations (LLVM backend)
jai build.jai -debug

# Release build (LLVM backend, optimized)
jai build.jai -release

# With Tracy profiler
jai build.jai +tracy -modules - -release
```

Output: `bin/Jay`

## Project Structure

```
Jay/
  build.jai              # Build metaprogram
  main.jai               # Application entry point
  engine/                # Engine modules (git submodules)
    Jay_Core/            # Engine lifecycle, timer, threading
    Jay_ECS/             # Archetype-based ECS
    Jay_Math/            # Vectors, matrices, quaternions
    Jay_Logger/          # Colored console logging
    Jay_Render/          # Vulkan renderer
    Jay_Utils/           # Utility functions
    Jay_Vulkan/          # Vulkan API bindings
    Slang/               # Shader compiler bindings
    jai-sdl3/            # SDL3 bindings
    jai-vma/             # Vulkan Memory Allocator
  assets/shaders/        # Slang shader sources
  bin/                   # Build output
```

## Dependencies

- SDL3
- Vulkan SDK
- Slang shader compiler

## License

Apache License 2.0 - See LICENSE file
