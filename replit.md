# Useful Lua Tools

## Overview

Useful Lua Tools (ULT) is a comprehensive Lua utility library that provides a collection of commonly used functions and variables organized into modular libraries. The project aims to simplify Lua development by offering pre-built solutions for cryptography, input handling, mathematical operations, string manipulation, table operations, system detection, color utilities, remote events, and random number generation. Currently at version 1.2.2, the library is designed to be cross-platform compatible and supports Lua 5.2+.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Library Structure
The project follows a modular library architecture where functionality is organized into specialized namespaces:

- **Core Libraries**: `ult` (metadata), `system` (OS detection)
- **Utility Libraries**: `math` (41 functions), `string` (10 functions), `table` (13 functions)
- **Specialized Libraries**: `cryptography` (26 functions), `input` (6 functions), `color` (6 functions), `remote` (3 functions), `random` (4 functions)
- **Global Functions**: 6 utility functions available globally

### Module Organization
Each library is self-contained and focuses on a specific domain of functionality. The architecture promotes:
- **Namespace Isolation**: Functions are grouped by purpose to avoid naming conflicts
- **Incremental Loading**: Libraries can be used independently
- **Version Management**: Built-in version tracking and compatibility checking

### Cross-Platform Compatibility
The system includes robust platform detection mechanisms:
- **OS Detection**: Automatic identification of Windows, Linux, MacOS, and ChromeOS
- **Lua Version Support**: Backward compatibility with older Lua versions
- **Fallback Mechanisms**: Graceful degradation when certain features aren't available

### Function Design Patterns
- **LuaDoc Annotations**: Comprehensive documentation for all functions
- **Error Handling**: Robust error checking and fallback behaviors
- **Optional Parameters**: Flexible function signatures with sensible defaults

## External Dependencies

### Runtime Dependencies
- **Lua Runtime**: Minimum version 5.2 (uses bit32 library for bitwise operations)
- **Standard Lua Libraries**: Built-in `os`, `math`, `string`, `table`, and `bit32` libraries
- **Platform-Specific APIs**: OS detection relies on system-level calls

### Development Dependencies
- **Lua Language Server**: Configuration provided via `.luarc.json` for development tooling
- **Documentation Tools**: LuaDoc-compatible annotation system for function documentation

### Optional Integrations
- **Remote Events**: Inspired by Roblox Studio's remote event system for inter-component communication
- **Cryptographic Functions**: Self-contained implementations without external crypto libraries
- **Random Number Generation**: Enhanced random utilities beyond standard Lua math.random

The architecture prioritizes simplicity and self-containment, minimizing external dependencies while providing comprehensive functionality for common Lua development tasks.