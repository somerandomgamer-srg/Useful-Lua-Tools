# Useful Lua Tools - Project Guide

## Overview

Useful Lua Tools is a comprehensive Lua utility library providing 195+ functions across 17 specialized libraries. The project is a pure Lua implementation (5.3+) with zero external dependencies, offering utilities for cryptography, data structures, file operations, HTTP requests, mathematical operations, string manipulation, and more. The library is designed to be plug-and-play, requiring only a single `require()` statement to access all functionality.

**Current Version**: 2.2.0  
**Language**: Lua 5.3+  
**Total Definitions**: 210 (195 functions + 15 variables)  
**Lines of Code**: ~4,836  
**File Size**: 126 KB

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Core Design Pattern

The library follows a **modular namespace pattern** where functionality is organized into logical libraries, each exposing a set of related functions through a shared namespace. The architecture is structured as:

```
ult (root namespace)
├── Library modules (17 total)
│   ├── binary (8 functions)
│   ├── color (6 functions)
│   ├── cryptography (31 functions)
│   ├── datetime (5 functions)
│   ├── file (8 functions)
│   ├── http (7 functions)
│   ├── input (6 functions)
│   ├── json (2 functions)
│   ├── math (44 functions)
│   ├── queue (7 functions)
│   ├── random (7 functions)
│   ├── remote (8 functions)
│   ├── stack (7 functions)
│   ├── string (12 functions)
│   ├── table (27 functions)
│   ├── terminal (functions)
│   └── validate (3 functions)
├── Global utility functions (5)
└── Metadata variables (15)
```

**Rationale**: This approach provides clean separation of concerns, making it easy for users to discover related functionality and for maintainers to extend specific domains without affecting others.

### Library Organization

**Problem Addressed**: Need for organized, discoverable utilities across diverse domains (cryptography, data structures, I/O, etc.)

**Solution**: Domain-driven library segmentation where each library focuses on a specific problem space:
- **Data Structures**: `queue`, `stack`, `table` for collection operations
- **Utilities**: `math`, `string`, `random` for common operations
- **I/O Operations**: `file`, `http`, `input` for external interactions
- **Security**: `cryptography`, `validate` for security-sensitive operations
- **Encoding**: `binary`, `json`, `color` for data transformation
- **System**: `datetime`, `system`, `terminal` for environment interaction
- **Custom Patterns**: `remote` for event-driven patterns (inspired by Roblox RemoteEvents)

**Pros**:
- Clear mental model for users
- Easy to extend with new functions
- No dependency hell (everything in one library)

**Cons**:
- Single large file may impact initial load time
- No tree-shaking for unused modules

### Pure Lua Implementation

**Problem Addressed**: Portability and ease of deployment across different Lua environments

**Solution**: Zero external dependencies, all functionality implemented in pure interpreted Lua

**Alternatives Considered**: 
- Using C extensions for performance-critical operations (cryptography, math)
- Depending on LuaRocks packages for established utilities

**Chosen Approach Rationale**: 
- Maximum portability across Lua 5.3+ environments
- No compilation or dependency management required
- Single-file deployment model
- Suitable for embedded Lua contexts (game engines, embedded systems)

**Trade-offs**:
- Performance may be slower than native implementations for intensive operations
- Re-implementation of common patterns that exist in external libraries

### Metadata and Versioning

The library exposes metadata through the `ult` namespace:
- `ult.version`: Semantic versioning string
- `ult.contributors`: Attribution table
- `ult.min_lua_ver`: Compatibility information

**Design Decision**: Embedding version metadata allows runtime version checks and programmatic dependency management by consuming applications.

### Function Signature Convention

The library uses a parameter annotation system:
- **R**: Required parameter
- **O**: Optional parameter
- **...**: Variadic arguments
- **D**: Deprecated (backward compatible but scheduled for removal)

**Rationale**: This provides clear documentation for users without requiring external documentation systems, enabling inline discovery.

### Remote Events System

**Unique Feature**: The `remote` library implements an event-driven communication pattern inspired by Roblox Studio's RemoteEvents.

**Functions**:
- `remote.exists()`: Check if remote exists
- `remote.remove()`: Remove a remote
- `remote.count()`: Count active remotes

**Use Case**: Enables decoupled component communication within Lua applications, particularly useful for game development or event-driven architectures.

### Evolution and Deprecation Strategy

The library maintains backward compatibility while evolving:
- Functions can be marked deprecated (D flag) but remain functional
- Migration path: `cryptography.uuid4()` → `random.uuid()` (moved for better organization)
- Similar consolidation: `math.random_sign()` → `random.sign()`

**Rationale**: Allows the library to improve organization without breaking existing user code.

## External Dependencies

**Runtime Dependencies**: None

**Development/Testing Dependencies**: Not specified in repository

**Lua Version Requirement**: Lua 5.3 or higher

**Notable Absence**: The library intentionally avoids external dependencies to maximize portability and simplify deployment. All functionality (including cryptography, HTTP, JSON parsing, etc.) is implemented in pure Lua.

**Platform Considerations**: 
- File I/O operations may have platform-specific behavior
- HTTP operations likely use Lua's built-in socket libraries or platform-specific implementations
- No database or external service integrations present