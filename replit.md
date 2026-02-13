# Useful Lua Tools (ULT)

## Overview

Useful Lua Tools (ULT) is a pure Lua utility library (version 3.0.0) that provides 238 functions and 20 variables across 20 libraries. It is a single-file Lua module with zero external dependencies, designed to extend Lua's standard library with additional functionality in areas like cryptography, math, string manipulation, table operations, input handling, color processing, random generation, and more.

The project is written in Lua 5.3+ and is intended to be used by requiring a single main file (`require("Useful Lua Tools")`), which makes all libraries and global functions available.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Project Structure
- **Single-file library**: The core of the project is a single Lua file that contains all 20 libraries. Users require this one file to access everything.
- **No build system**: Pure interpreted Lua with no compilation or build steps needed.
- **Documentation-driven**: The project includes markdown files documenting all functions, parameters, and versioning.

### Library Organization
The project extends or creates the following Lua libraries (namespaces):
- **math** (44 functions, 2 variables) — Extended math operations beyond Lua's built-in math library
- **table** (34 functions) — Extended table/array utilities
- **cryptography** (31 functions) — Hashing, encoding, UUID generation, and other crypto utilities
- **bignum** (13 functions) — Arbitrary precision number handling
- **string** (14 functions) — Extended string manipulation
- **random** (10 functions) — Random value generation (UUIDs, hex, booleans, strings, etc.)
- **stack** (10 functions) — Stack data structure implementation
- **queue** (10 functions) — Queue data structure implementation
- **remote** (9 functions) — Event-based communication system inspired by Roblox RemoteEvents
- **binary** (8 functions) — Binary data operations
- **file** (8 functions) — File I/O utilities
- **http** (8 functions) — HTTP request utilities
- **color** (6 functions) — Color manipulation and conversion
- **input** (6 functions) — User input handling
- **system** (6 functions, 11 variables) — System information and environment data
- **datetime** (5 functions) — Date and time utilities
- **validate** (5 functions) — Data validation utilities
- **json** (2 functions) — JSON encode/decode
- **terminal** (2 functions) — Terminal/console utilities
- **ult** (7 variables) — Library metadata (version, contributors, etc.)
- **7 global functions** — Utility functions available in global scope

### Design Decisions
- **Pure Lua with no dependencies**: The library avoids any external C modules or third-party Lua libraries. This maximizes portability across any Lua 5.3+ environment.
- **Namespace extension**: Some libraries (like `math`, `string`, `table`) extend Lua's built-in global tables rather than creating entirely new namespaces. This provides a seamless experience but means the library modifies global state.
- **Single require pattern**: Everything loads from one `require` call, keeping usage simple but meaning the entire library is loaded even if only a subset is needed.

### Key Files
| File | Purpose |
|------|---------|
| `Useful Lua Tools.lua` (main file) | The core library containing all functions and variables |
| `README.md` | Project overview, usage instructions, and statistics |
| `Current Functions and Variables.md` | Detailed documentation of every function and variable |
| `Change Logs.md` | Version history |

## External Dependencies

- **None**: This is a pure Lua library with zero external dependencies. It runs on any standard Lua 5.3+ interpreter.
- **No database**: No data persistence layer is used.
- **No external APIs**: While the library includes an `http` library and `json` library, these are utility functions provided by the library itself, not connections to specific external services.