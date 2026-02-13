# Useful Lua Tools (ULT)

## Overview

Useful Lua Tools (ULT) is a pure Lua utility library (version 3.0.0) that provides 258 functions and variables across 20 libraries. It is a single-file Lua module designed to extend Lua's standard library with additional functionality in areas like cryptography, math, string manipulation, table operations, random number generation, binary operations, color handling, HTTP, file I/O, JSON, input handling, datetime, validation, and more.

The project has no external dependencies — it is pure interpreted Lua (5.3+) consisting of approximately 6,029 lines of code in a single ~164 KB file. Users simply `require("Useful Lua Tools")` to access all functionality.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Single-File Lua Module

- **Problem**: Provide a comprehensive utility library for Lua projects without dependency management complexity.
- **Solution**: Everything is bundled into a single Lua file (`Useful Lua Tools.lua`) that users require. All libraries (math extensions, cryptography, table utilities, etc.) are defined within this one file.
- **Pros**: Zero setup, no package manager needed, easy to distribute and include.
- **Cons**: Large single file (~164 KB) can be harder to navigate and maintain.

### Library Organization

The module extends or creates the following 20 library namespaces:

| Library | Purpose |
|---------|---------|
| `math` | 44 functions + 2 variables — extended math operations |
| `table` | 34 functions — extended table/array utilities |
| `cryptography` | 31 functions — hashing, encoding, encryption |
| `bignum` | 13 functions — arbitrary precision number operations |
| `string` | 14 functions — extended string manipulation |
| `random` | 10 functions — random generation (UUIDs, hex, strings, etc.) |
| `stack` | 10 functions — stack data structure |
| `queue` | 10 functions — queue data structure |
| `remote` | 9 functions — event-based communication (inspired by Roblox RemoteEvents) |
| `binary` | 8 functions — binary/bitwise operations |
| `file` | 8 functions — file I/O utilities |
| `http` | 8 functions — HTTP request utilities |
| `color` | 6 functions — color conversions and manipulation |
| `input` | 6 functions — user input handling |
| `system` | 6 functions + 11 variables — system info and environment |
| `datetime` | 5 functions — date/time utilities |
| `validate` | 5 functions — data validation |
| `json` | 2 functions — JSON encode/decode |
| `terminal` | 2 functions — terminal/console utilities |
| `ult` | 7 variables — library metadata (version, contributors, etc.) |

There are also 7 global functions available without a library prefix.

### Design Patterns

- **Namespace extension**: The library extends Lua's built-in `math`, `string`, and `table` namespaces with additional functions rather than creating separate namespaces. Custom libraries use new global table names.
- **No OOP**: The library uses a functional/procedural style with library tables acting as namespaces.
- **Pure Lua**: No C extensions, FFI, or external dependencies. Everything runs in standard Lua 5.3+ interpreters.

### Language Requirements

- **Lua 5.3 or higher** is required (likely for integer division, bitwise operators, and utf8 support introduced in 5.3).

## External Dependencies

**None.** This is a pure Lua library with zero external dependencies. It does not use any third-party packages, databases, APIs, or services. All functionality (including cryptography, JSON, HTTP utilities, etc.) is implemented directly in Lua.

The `.config/.semgrep` directory contains static analysis rules but these are development/CI tooling, not runtime dependencies.