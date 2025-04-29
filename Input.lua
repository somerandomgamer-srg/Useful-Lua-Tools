--- `input` - The string to be cleaned <br> `cleaned` - The resulting valid number string
---Cleans a string to ensure it's a valid number format
---
---Features:
---- Removes all non-numeric characters except decimal points and minus signs
---- Handles multiple decimal points by keeping only the first one
---- Preserves negative sign only if it's at the start
---
---Example usage:
---- CleanNumber("abc-123.45.6") -> "-123.456"
---- CleanNumber("12.34.56") -> "12.3456"
---- CleanNumber("ab12cd") -> "12"
---
---@param input string
---@return string cleaned 
---@nodiscard
function CleanNumber(input)
  local cleaned = input:gsub("[^0-9%.%-]", "")

  local firstDecimal = cleaned:find("%.")
  if firstDecimal then cleaned = cleaned:sub(1, firstDecimal)..cleaned:sub(firstDecimal + 1):gsub("%.", "") end

  local hasHyphen = cleaned:find("%-")
  if hasHyphen then
    cleaned = cleaned:gsub("%-", "")
    if hasHyphen == 1 then cleaned = "-" .. cleaned end
  end

  return cleaned
end

---Gets a single string input from the user
---
---Features:
---- Displays a custom prompt message
---- Returns the raw input as a string
---- No input validation or cleaning
---
---Example usage:
---- Input("Enter your name") -> Prompts "Enter your name: "
---- Returns exactly what the user types
---
---@param message string The prompt message to show
---@return string input The user's raw input
---@nodiscard
function Input(message)
  io.write(message .. ": ")
  return io.read()
end

---Collects multiple string inputs from the user
---
---Features:
---- Displays a main message followed by numbered prompts
---- Collects a specified number of inputs
---- Returns all inputs in a table
---
---Example usage:
---- InputTable("Enter 3 names", 3)
---- Will show:
----   Enter 3 names
----   input 1: (user types)
----   input 2: (user types)
----   input 3: (user types)
---
---@param message string The main prompt message
---@param number_of_inputs number How many inputs to collect
---@return table inputs Table containing all user inputs
---@nodiscard
function InputTable(message, number_of_inputs)
  io.write(message)

  local inputs = {}
  for i = 1, number_of_inputs do
    io.write(string.format("\ninput %d:", i))
    inputs[i] = io.read()
  end
  return inputs
end

---Gets a single numeric input from the user with validation
---
---Features:
---- Displays a custom prompt message
---- Automatically cleans and validates the input
---- Returns 0 if input is invalid
---- Handles decimal numbers and negative values
---
---Example usage:
---- InputNumber("Enter your age") -> Prompts and returns a number
---- Invalid inputs like "abc" return 0
---
---@param message string The prompt message to display
---@return number input The user's numeric input (returns 0 if invalid)
function InputNumber(message)
  io.write(message .. ": ")
  local num = tonumber(CleanNumber(io.read()))
  if not num then print("Invalid number input") end
  return num and tonumber(num) or 0
end

---Collects multiple numeric inputs from the user
---
---Features:
---- Displays a main message followed by numbered prompts
---- Validates and cleans each input
---- Replaces invalid numbers with 0
---- Handles decimals and negative numbers
---
---Example usage:
---- InputNumberTable("Enter 3 scores", 3)
---- Will show:
----   Enter 3 scores
----   input 1: (user types)
----   input 2: (user types)
----   input 3: (user types)
---
---@param message string The prompt message to display
---@param number_of_inputs number The number of numeric inputs to collect
---@return table inputs Table containing the user's numeric inputs
function InputNumberTable(message, number_of_inputs)
  io.write(message)

  local inputs = {}
  for i = 1, number_of_inputs do
    io.write(string.format("\ninput %d:", i))
    local num = tonumber(CleanNumber(io.read()))
    if not num then print(string.format("Invalid number at input %d", i)) end
    inputs[i] = num and tonumber(num) or 0
  end
  return inputs
end

---Collects string inputs until the user submits an empty input
---
---Features:
---- Displays a main message with instructions
---- Keeps collecting inputs until empty submission
---- Numbers each input prompt automatically
---- Returns all inputs in a table
---
---Example usage:
---- InputLoop("Enter names")
---- Will show:
----   (press enter with nothing typed to submit)Enter names
----   Input 1: John
----   Input 2: Jane
----   Input 3: (empty to finish)
---
---@param message string The prompt message to display
---@return table inputs Table containing all inputs until empty input
function InputLoop(message)
  local inputs = {}
  local current = 1

  io.write("(press enter with nothing typed to submit)" .. message)
  while true do
    io.write(string.format("\nInput %d:", current))
    local input = io.read()
    if input == "" then break end
    inputs[current] = tostring(input)
    current = current + 1
  end

  return inputs or {}
end

---Collects numeric inputs until the user submits an empty input
---
---Features:
---- Displays a main message with instructions
---- Validates and cleans each number input
---- Skips invalid numbers (doesn't add them to table)
---- Continues until empty submission
---- Handles decimals and negative numbers
---
---Example usage:
---- InputNumberLoop("Enter scores")
---- Will show:
----   (press enter with nothing typed to submit)Enter scores
----   Input 1: 95.5
----   Input 2: abc (invalid number message)
----   Input 2: 87
----   Input 3: (empty to finish)
---
---@param message string The prompt message to display
---@return table inputs Table containing all numeric inputs until empty input
function InputNumberLoop(message)

  local inputs = {}
  local current = 1

  io.write("(press enter with nothing typed to submit)" .. message)
  while true do
    io.write(string.format("\nInput %d:", current))
    local input = io.read()
    if input == "" then break end

    local num = tonumber(CleanNumber(input))
    if not num then print(string.format("Invalid number at input %d", current))
    else
      inputs[current] = num and tonumber(num) or 0
      current = current + 1
    end
  end

  return inputs or {}
end