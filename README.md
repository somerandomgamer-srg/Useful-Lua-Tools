` tags.

```text
# Useful Lua Tools

A comprehensive library extending Lua's standard functionality with additional tools and utilities.

## Features
### **Current Features**
- [x] Math Extensions
  - [x] Statistical functions (average, median, mode)
  - [x] Number theory (GCD, LCM, prime checking)
  - [x] Quadratic equation solving
  - [x] Hyperbolic functions
  - [x] Number utilities
- [x] String Extensions
  - [x] String cleaning and formatting
  - [x] Text manipulation
  - [x] Pattern matching helpers
- [x] Table Extensions
  - [x] Advanced table operations
  - [x] CSV conversion
  - [x] Table manipulation
- [x] Input Library
  - [x] User input handling
  - [x] Multiple input collection
  - [x] Numeric input validation
- [x] Cryptography
  - [x] Text format conversion
  - [x] Encryption methods
  - [x] Bitwise operations
- [x] Global Utilities
  - [x] Timing and benchmarking
  - [x] Type checking
  - [x] System operations

## Usage

### Basic Include
```lua
require("Useful Lua Tools")
```

### Math Functions
```lua
local numbers = {1, 2, 3, 4, 5}
print(math.average(numbers))  -- Output: 3
print(math.median(numbers))   -- Output: 3
print(math.mode(numbers))     -- Output: nil (no mode)
```

### String Functions
```lua
local text = "  Hello World  "
print(string.trim(text))      -- Output: "Hello World"
print(string.capitalize(text)) -- Output: "  Hello world  "
```

### Cryptography
```lua
local text = "Hello"
print(cryptography.text_to_hex(text))    -- Output: "48656C6C6F"
print(cryptography.text_to_morse(text))  -- Output: ".... . .-.. .-.. ---"
```

## Installation

1. Clone or download this repository
2. Add the files to your Lua project
3. Include the main library:
```lua
require("Useful Lua Tools")
```

## Contact

- Creator: Some Random Gamer (SRG)
- Issues: Use the Replit comments section
- Contributions: Fork the repl and create a pull request

## License

This project is open source and available under the MIT License.