# Useful Lua Tools

## Overview

Useful Lua Tools (ULT) is a comprehensive Lua utility library that provides 186 functions and 15 variables organized into 16 specialized libraries. The project aims to simplify Lua development by offering pre-built solutions for cryptography, input handling, mathematical operations, string manipulation, table operations, system detection, color utilities, remote events, random number generation, data structures (stack/queue), datetime operations, file I/O, JSON handling, HTTP requests, binary operations, and validation utilities. Currently at version 2.1.0, the library is designed to be cross-platform compatible and supports Lua 5.3+ (uses native bitwise operators).

## Project Status

- **Current Version**: 2.1.0
- **Total Functions**: 186
- **Total Variables**: 15
- **Total Libraries**: 16
- **Distribution Status**: Prepared for LuaRocks (awaiting unrestricted internet access)
- **Latest Features**: Binary library, validate library, deprecation system

## Recent Changes (v2.1.0)

### New Libraries Added
- **Binary Library** (8 functions): Binary string arithmetic and bitwise operations
  - `binary.add`, `binary.subtract`, `binary.multiply`, `binary.divide`
  - `binary.band`, `binary.bor`, `binary.bxor`, `binary.bnot`
- **Validate Library** (2 functions): Input validation utilities
  - `validate.ip` - IP address validation
  - `validate.email` - Email validation

### New Functions
- **string.wrap** - Text wrapping with word boundary handling

### Deprecation System
- Introduced backward-compatible deprecation system (v2.1.0)
- Deprecated functions still work but will be removed in future versions
- **Deprecated Functions**:
  - `cryptography.is_ip` → Use `validate.ip` instead
  - `cryptography.is_email` → Use `validate.email` instead

### Bug Fixes
- Fixed binary_add multi-digit carry handling
- Completely rewrote binary_subtract logic
- Fixed binary.multiply missing function call
- Fixed bitwise operations padding issues

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Library Structure
The project follows a modular library architecture where functionality is organized into specialized namespaces:

- **Core Libraries**: `ult` (5 variables), `system` (10 variables)
- **Math Library**: 41 functions for advanced mathematical operations
- **String Library**: 12 functions for text manipulation
- **Table Library**: 24 functions for table operations
- **Input Library**: 6 functions for user input handling
- **Cryptography Library**: 32 functions for encryption, hashing, and encoding
- **Binary Library**: 8 functions for binary string operations (NEW in v2.1.0)
- **Validate Library**: 2 functions for input validation (NEW in v2.1.0)
- **Color Library**: 6 functions for color conversion (RGB, HEX, HSV)
- **Remote Library**: 8 functions for event-driven programming
- **Random Library**: 7 functions for enhanced randomization
- **Stack Library**: 7 functions for stack data structure
- **Queue Library**: 7 functions for queue data structure
- **Datetime Library**: 5 functions for date/time operations
- **File Library**: 8 functions for file I/O operations
- **JSON Library**: 2 functions for JSON encoding/decoding
- **HTTP Library**: 5 functions for HTTP requests (GET, POST, PUT, PATCH, DELETE)
- **Global Functions**: 5 utility functions available globally

### Module Organization
Each library is self-contained and focuses on a specific domain of functionality. The architecture promotes:
- **Namespace Isolation**: Functions are grouped by purpose to avoid naming conflicts
- **Incremental Loading**: Libraries can be used independently
- **Version Management**: Built-in version tracking and compatibility checking
- **Backward Compatibility**: Deprecated functions continue to work while users migrate to new APIs

### Cross-Platform Compatibility
The system includes robust platform detection mechanisms:
- **OS Detection**: Automatic identification of Windows, Linux, MacOS, and ChromeOS
- **Lua Version Support**: Backward compatibility with older Lua versions (5.3+)
- **Fallback Mechanisms**: Graceful degradation when certain features aren't available

### Function Design Patterns
- **LuaDoc Annotations**: Comprehensive documentation for all functions
- **Error Handling**: Robust error checking and fallback behaviors
- **Optional Parameters**: Flexible function signatures with sensible defaults
- **Deprecation Warnings**: Clear migration paths for deprecated functions

## Distribution Strategy

### LuaRocks Preparation
- **Rockspec file**: `useful-lua-tools-2.0.0-1.rockspec` (ready for publishing)
- **Source rock**: `useful-lua-tools-2.0.0-1.src.rock` (packaged with local tarball)
- **Status**: Ready to publish when unrestricted internet access is available

### Access Blockers
- School network (Securely software) blocks GitHub, Discord, Reddit, docs.replit.com
- Alabama phone law prevents mobile workarounds
- Restricted Chromebook environment
- **Plan**: Publish to LuaRocks when accessing from home/library/college/summer break

### Current Distribution
- Available as Replit template
- Direct download via `.src.rock` file
- Manual installation supported

## External Dependencies

### Runtime Dependencies
- **Lua Runtime**: Minimum version 5.3 (uses native bitwise operators &, |, <<, >>)
- **Standard Lua Libraries**: Built-in `os`, `math`, `string`, `table`, and `io` libraries
- **Platform-Specific APIs**: OS detection relies on system-level calls

### Development Dependencies
- **Lua Language Server**: Configuration provided via `.luarc.json` for development tooling
- **Documentation Tools**: LuaDoc-compatible annotation system for function documentation

### Optional Integrations
- **Remote Events**: Inspired by Roblox Studio's remote event system for inter-component communication
- **Cryptographic Functions**: Self-contained implementations without external crypto libraries
- **Random Number Generation**: Enhanced random utilities beyond standard Lua math.random
- **HTTP Requests**: Cross-platform support (Windows, macOS, Linux)
- **JSON Operations**: Lightweight JSON encoding/decoding

## Project Notes

- This toolkit is the user's main coding project (user doesn't actively code applications)
- Focus on maintaining comprehensive, well-documented utilities
- Emphasis on backward compatibility through deprecation system
- All changes tracked in `Change Logs.md`
- Complete function reference maintained in `Current Functions and Variables.md`

The architecture prioritizes simplicity and self-containment, minimizing external dependencies while providing comprehensive functionality for common Lua development tasks.
