
# Lua Input Handler Template

A simple and robust input handling system for Lua applications.

## Features
- ✓ Clean and consistent user input handling
- ✓ Multiple input capture methods:
  - Single input - `input(prompt)`
  - Multiple inputs - `inputTable(prompt, numberOfInputs)`
  - Numeric input with validation - `inputNumber(prompt)`
  - Continuous input collection - `inputLoop(prompt)`
  - Continuous numeric input collection - `inputNumberLoop(prompt)`
- ✓ Advanced number cleaning and validation
- ✓ Error handling for invalid numeric inputs
- □ Multi-language support
- □ Input validation with custom patterns
- □ Input masking for passwords

## Usage

### Basic Input
```lua
-- Import the module
require("input")

-- Get a single string input
local name = input("Enter your name")

-- Get multiple string inputs
local answers = inputTable("Answer the questions", 3)
```

### Numeric Input
```lua
local age = inputNumber("Enter your age")
local dimensions = inputNumberTable("Enter dimensions", 3)
```

### Input Loops
```lua
local names = inputLoop("Enter names")
local scores = inputNumberLoop("Enter scores")
```

## Contact

- Creator: Some Random Gamer (SRG)
- Issues: Use the Replit comments section
- Contributions: Fork the repl and create a pull request
