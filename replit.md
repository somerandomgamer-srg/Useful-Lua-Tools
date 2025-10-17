# Useful Lua Tools (ULT)

## Overview

Useful Lua Tools is a comprehensive Lua utility library providing **186 functions** and **15 variables** across **16 specialized libraries**. This toolkit simplifies Lua development by offering pre-built solutions for common tasks including cryptography, mathematical operations, string manipulation, data structures, file I/O, HTTP requests, and much more.

**Current Version**: 2.1.0  
**Minimum Lua Version**: 5.3+

## Features

### 📚 16 Specialized Libraries

- **Core Libraries**
  - `ult` (5 variables) - Toolkit metadata and version info
  - `system` (10 variables) - OS detection and system information

- **Data Manipulation**
  - `math` (41 functions) - Advanced mathematical operations
  - `string` (12 functions) - Text processing and manipulation
  - `table` (24 functions) - Table utilities and operations

- **Input/Output**
  - `input` (6 functions) - User input handling
  - `file` (8 functions) - File I/O operations
  - `json` (2 functions) - JSON encoding/decoding
  - `http` (5 functions) - HTTP requests (GET, POST, PUT, PATCH, DELETE)

- **Security & Validation**
  - `cryptography` (32 functions) - Encryption, hashing, encoding
  - `validate` (2 functions) - Input validation (email, IP)

- **Utilities**
  - `binary` (8 functions) - Binary string arithmetic and bitwise operations
  - `color` (6 functions) - Color conversion (RGB, HEX, HSV)
  - `datetime` (5 functions) - Date and time operations
  - `random` (7 functions) - Enhanced randomization

- **Data Structures & Events**
  - `stack` (7 functions) - Stack data structure
  - `queue` (7 functions) - Queue data structure
  - `remote` (8 functions) - Event-driven programming

- **Global Functions** (5 functions) - Utility functions available globally

### 🆕 What's New in v2.1.0

**New Libraries:**
- **Binary Library** - Perform arithmetic and bitwise operations on binary strings
- **Validate Library** - Validate emails and IP addresses

**New Functions:**
- `string.wrap` - Wrap text to specified width with word boundary handling

**Improvements:**
- Introduced deprecation system for backward compatibility
- Fixed binary arithmetic bugs (carry handling, subtraction logic)
- Fixed bitwise operation padding issues

**Deprecated Functions:**
- `cryptography.is_ip()` → Use `validate.ip()` instead
- `cryptography.is_email()` → Use `validate.email()` instead

*Note: Deprecated functions still work but will be removed in future versions.*

## Installation

### Via LuaRocks (Coming Soon)
```bash
luarocks install useful-lua-tools
```

### Manual Installation
1. Download `Useful Lua Tools.lua`
2. Place it in your project directory
3. Require it in your code:
```lua
require("Useful Lua Tools")
```

### Via Replit Template
Fork the Replit template to get started immediately with examples and documentation.

## Quick Start

```lua
-- Require the library
require("Useful Lua Tools")

-- Use any function from the libraries
local hash = cryptography.sha256("Hello World")
local shuffled = table.shuffle({1, 2, 3, 4, 5})
local wrapped = string.wrap("This is a long text that needs wrapping", 20)
local response = http.get("https://api.example.com/data")

-- Check toolkit version
print(ult.version)  -- "2.1.0"
print(ult.build)    -- Full build information
```

## Compatibility

### Platform Support
- ✅ Windows
- ✅ Linux
- ✅ macOS
- ✅ ChromeOS

### Lua Version Support
- **Minimum**: Lua 5.3 (required for native bitwise operators)
- **Recommended**: Lua 5.4+

### Dependencies
- **Required**: Standard Lua libraries (`os`, `math`, `string`, `table`, `io`)
- **Optional**: None - fully self-contained

## Documentation

- **Complete Function Reference**: See `Current Functions and Variables.md` for detailed documentation of all 186 functions
- **Change History**: See `Change Logs.md` for version history and updates
- **README**: See `README.md` for quick overview and examples

### Function Notation
- **(R)** - Required parameter
- **(O)** - Optional parameter
- **...** - Multiple arguments accepted
- **(D)** - Deprecated (still works, but use alternative)

## Architecture

### Design Principles
- **Namespace Isolation** - Functions grouped by purpose to avoid naming conflicts
- **Self-Contained** - No external dependencies required
- **Cross-Platform** - Automatic OS detection with fallback mechanisms
- **Backward Compatible** - Deprecated functions continue to work while you migrate

### Module Organization
Each library is independent and focused on a specific domain. You can use any combination of libraries without conflicts.

## License & Credits

See the toolkit metadata for contributor information:
```lua
print(ult.contributors)
```

---

**Happy Coding with Useful Lua Tools!** 🚀

For questions, issues, or contributions, please refer to the project repository.
