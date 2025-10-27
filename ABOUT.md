
# About Useful Lua Tools

## What is Useful Lua Tools?

**Useful Lua Tools (ULT)** is a comprehensive, single-file Lua toolkit that provides 205+ utility functions and variables across 16 specialized libraries. It's designed to extend Lua's standard library with commonly-needed functionality for real-world applications.

## Key Features

### 📦 Single-File Design
- **Zero dependencies** - Just require one file and you're ready to go
- **Easy integration** - Drop into any Lua 5.3+ project
- **Portable** - Works across Windows, macOS, and Linux

### 🎯 16 Specialized Libraries

1. **Math Library** (41 functions) - Advanced mathematical operations including statistics, combinatorics, hyperbolic functions, and number theory
2. **Cryptography Library** (31 functions) - Encoding/decoding (Base64, Base32, Base58, Hex, ASCII, Binary, Octal, Morse), encryption (XOR, Caesar, ROT13), hashing (SHA-256), and validation
3. **Table Library** (27 functions) - Advanced table manipulation, serialization, functional programming utilities
4. **String Library** (12 functions) - Text processing, validation, formatting, and analysis
5. **Binary Library** (8 functions) - Binary arithmetic and bitwise operations
6. **File Library** (8 functions) - File I/O operations
7. **Remote Library** (8 functions) - Event-driven programming inspired by Roblox Remote Events
8. **HTTP Library** (7 functions) - REST API interactions (GET, POST, PUT, PATCH, DELETE)
9. **Stack Library** (7 functions) - Stack data structure implementation
10. **Queue Library** (7 functions) - Queue data structure implementation
11. **Random Library** (7 functions) - Advanced random generation including UUIDs (v1, v4, v6)
12. **Color Library** (6 functions) - Color space conversions (RGB, HEX, HSV)
13. **Input Library** (6 functions) - User input handling
14. **Datetime Library** (5 functions) - Date and time operations
15. **Validate Library** (3 functions) - Input validation (email, IP, URL)
16. **JSON Library** (2 functions) - JSON encoding/decoding

### 🛠️ System Information
- **10 system variables** providing OS detection, CPU info, and hardware details
- Cross-platform compatibility detection

### 🌟 Developer-Friendly
- **LuaDoc annotations** for every function and variable
- Comprehensive error handling with descriptive messages
- Built-in performance benchmarking tools
- Consistent naming conventions (snake_case for public API)

## Use Cases

- **Rapid Prototyping** - Quickly build proof-of-concepts without reinventing the wheel
- **Educational Projects** - Learn Lua with practical, well-documented examples
- **Game Development** - Utilities for data structures, random generation, and color manipulation
- **CLI Tools** - Input handling, file operations, and system information
- **Web Services** - HTTP requests, JSON handling, and data validation
- **Data Processing** - Table manipulation, CSV conversion, and serialization

## Technical Specifications

- **Minimum Lua Version**: 5.3
- **License**: MIT License
- **Current Version**: 2.2.0
- **Release Date**: October 23, 2025
- **Total Functions & Variables**: 205+
- **File Size**: Single Lua file (~60KB)

## Performance Features

- Built-in `benchmark()` function for performance testing
- `execution_time()` for profiling specific operations
- Optimized algorithms for common operations
- Memoization opportunities for expensive calculations

## Distribution

Available on multiple platforms:
- **GitHub** - Source code and documentation
- **LuaRocks** - Package manager integration
- **Replit Template** - Ready-to-use template for quick starts

## Philosophy

Useful Lua Tools follows these design principles:

1. **Community-First** - Open contributions, accessible documentation
2. **Professional Standards** - MIT licensing, semantic versioning, comprehensive disclaimers
3. **Practical Over Perfect** - Focus on real-world utility over theoretical purity
4. **Accessibility** - Mix of formal and informal tone to make learning approachable
5. **Transparency** - Solo developer with clear development journey

## Creator

Created by **Some Random Gamer (SRG)**, a self-taught developer with one year of coding experience who started with Roblox development and expanded into general Lua programming.

## Getting Started

```lua
-- 1. Require the toolkit
require("Useful Lua Tools")

-- 2. Use any library
local avg = math.average(10, 20, 30, 40)  -- Returns 25
local uuid = random.uuid(4)  -- Generate UUID v4
local hash = cryptography.sha256("hello")  -- SHA-256 hash
local json = json.encode({name = "SRG", version = "2.2.0"})
```

## Community & Support

- **Discord Server**: [Join here](https://discord.gg/w9aE98gKDs)
- **Bug Reports**: Use the bugs-suggestions-and-feedback channel
- **Contributions**: DM SRG on Discord

---

**Note**: This toolkit is provided "as-is" under the MIT License. See README.md for full disclaimers and license information.
