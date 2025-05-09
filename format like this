# Lua Input Handler Template

A simple and robust input handling system for Lua applications.

## Features
### **Boxes that have a checkmark are already implemented**
### **Boxes that don't have a checkmark are not implemented yet**
- [x] Clean and consistent user input handling
- [x] Multiple input capture methods:
  - [x] Single input - `input(prompt)`
  - [x] Multiple inputs - `inputTable(prompt, numberOfInputs)`
  - [x] Numeric input with validation - `inputNumber(prompt)`
  - [x] Continuous input collection - `inputLoop(prompt)`
  - [x] Continuous numeric input collection - `inputNumberLoop(prompt)`
- [x] Advanced number cleaning and validation
- [x] Error handling for invalid numeric inputs (returns 0 for invalid numeric inputs)
- [ ] Multi-language support
- [ ] Input validation with custom patterns
- [ ] Input masking for passwords
## Advanced Number Handling

Unlike simple `tonumber()` conversion, this template includes sophisticated number cleaning that:

- Extracts numeric values from mixed text (e.g., "22 km" → "22")
- Handles and corrects multiple decimal points (e.g., "3.23.3" → "3.233")
- Handles and corrects multiple negative signs (e.g., "-4343-2" → "-43432")
- Properly maintains negative signs only at the beginning
- Strips all non-numeric characters while preserving the numeric value

This means you can accept user inputs in various formats and still extract valid numbers.
## Usage

### Basic Input

```lua
-- All functions are global after requiring the module
require("input")

-- Get a single string input
local name = input("Enter your name")

-- Get multiple string inputs
local answers = inputTable("Answer the following questions", 3)
```

### Numeric Input

```lua
require("input")

-- Get a single number with validation
local age = inputNumber("Enter your age")
-- User types "25 years old" → returns 25
-- User types "twenty five" → returns 0

-- Get multiple numbers
local dimensions = inputNumberTable("Enter width, height, and depth", 3)
-- User types "3.5m" for width → returns 3.5
-- If any input is invalid, returns 0
```

### Input Loops

```lua
require("input")

-- Collect a variable number of string inputs
local names = inputLoop("Enter names")

-- Collect a variable number of numeric inputs with intelligent parsing
local scores = inputNumberLoop("Enter scores")
-- User types "Score: -98.6" → adds -98.6 to the scores table
-- User types "ninety-eight" → shows error message and returns 0
```

## How Number Cleaning Works

The internal `cleanNum()` function performs several operations:
1. Removes all non-numeric characters (except decimal points and minus signs)
2. Handles multiple decimal points by keeping only the first one
3. Ensures minus signs are only at the beginning of the number
4. Returns a cleaned string that can be safely converted to a number

Example transformations:
- "123abc" → "123"
- "-22.5 km" → "-22.5"
- "3.14.15" → "3.1415"
- "cost: $-99.99" → "-99.99"

## Customization

Feel free to modify the `input.lua` file to suit your specific needs.

## Custom Prompts and Messages

The input module prints prompts directly to the console:

```lua
-- Each input function displays the message you provide
local name = input.input("Enter your name")
-- Prints:
  -- Enter your name: 

-- For multiple inputs, it shows numbered prompts
local scores = inputNumTable("Enter three scores", 3)
-- Prints:
  -- Enter three scores
  -- input 1:
  -- input 2:
  -- input 3:

-- For input loops, it shows a helpful instruction
local items = inputLoop("Enter items")
-- Prints:
  -- (press enter with nothing typed to submit) Enter items
  -- Input 1:
  -- Input 2:
  -- ...
```

You can customize these prompts by modifying the `input.lua` file.

## Getting Started

1. Fork this template
2. Require the input module in your main.lua file:
   ```lua
   -- For direct import
   local input = require("input")

   -- For language-specific import with individual functions
   local inputModule = require("english.input")
   local input = inputModule.input
   local inputNum = inputModule.inputNum
   local inputLoop = inputModule.inputLoop
   local inputNumLoop = inputModule.inputNumLoop
   ```
3. Start using the various input functions in your application

## Contact

For questions, suggestions, or contributions related to this template:

- **Creator**: Some Random Gamer (SRG)
- **Discord**: [Join my Discord server!](https://discord.gg/w9aE98gKDs)
- **Issues**: Please report any bugs to the [bugs-suggestions-and-feedback](https://discord.com/channels/1296889247176982528/1298419569135980564) channel
- **Contributions**: DM me on Discord!