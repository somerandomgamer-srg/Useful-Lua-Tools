require("Library Extensions")

---@class inputlib
input = {}

---Gets a single string input from the user
---
---Features:
---- Displays an optional custom prompt message
---- Returns the raw input as a string
---- No input validation or cleaning
---
---Example usage:
---- Input("Enter your name")
---- Returns exactly what the user types
---
---`message` - The prompt message to display
---@param message string
---@return string
---@nodiscard
function input.string(message)
  if message and type(message) ~= "string" then error("Input message must be a string") end

  io.write(message .. ": ")
  local inp = io.read()
  if not inp then
    print("Failed to read input")
    return ""
  end
  return inp
end

---Collects multiple string inputs from the user
---
---Features:
---- Displays an optional main message followed by numbered prompts
---- Collects a specified number of inputs
---- Returns all inputs in a table
---
---Example usage:
---- InputTable("Enter 3 names", 3)
----   Will show:
----     Enter 3 scores
----     input 1: (user types)
----     input 2: (user types)
----     input 3: (user types)
----   User types:
----     input 1: Rebecca
----     input 2: James
----     input 3: Tommy
----   Will return:
----     {"Rebecca", "James", "Tommy"}
---
---`message` - The prompt message to display
---`number_of_inputs` - How many inputs to collect
---@param message string
---@param number_of_inputs number
---@return table inputs
---@nodiscard
function input.table(message, number_of_inputs)
  if message and type(message) ~= "string" then error("Input message must be a string") end
  if type(number_of_inputs) ~= "number" then
    error("Number of inputs must be a number")
    return {}
  end
  if number_of_inputs < 1 then
    error("Number of inputs must be greater than 0")
    return {}
  end

  io.write(message)
  local inputs = {}
  for i = 1, number_of_inputs do
    io.write(string.format("\ninput %d:", i))
    local inp = io.read()
    if not inp then
      print("Failed to read input at input #" .. i)
      return {}
    end
    inputs[i] = inp
  end
  return inputs
end

---Gets a single numeric input from the user with validation
---
---Features:
---- Displays an optional custom prompt message
---- Automatically cleans and validates the input
---- Returns 0 if input is invalid
---- Handles decimal numbers and negative values
---
---Example usage:
---- InputNumber("Enter your age") -> Prompts and returns a number
---- Invalid inputs like "abc" return 0
---
---`message` - The prompt message to display
---@param message string
---@return number input
---@nodiscard
function input.number(message)
  if type(message) ~= "string" then
    error("Input message must be a string")
    return 0
  end

  io.write(message .. ": ")
  local inp = io.read()
  if not inp then
    print("Failed to read input")
    return 0
  end

  local num = tonumber(string.clean_number(inp))
  if not num then
    print("Invalid number input")
    return 0
  end
  return num
end

---Collects multiple numeric inputs from the user
---
---Features:
---- Displays an optional main message followed by numbered prompts
---- Validates and cleans each input
---- Replaces invalid numbers with 0
---- Handles decimals and negative numbers
---
---Example usage:
---- input.number_table("Enter 3 scores", 3)
---- Will show:
----   Enter 3 scores
----   input 1: (user types)
----   input 2: (user types)
----   input 3: (user types)
---- User types:
----   input 1: 95
----   input 2: abc (Invalid number input)
----   input 3: 87
---- Will return:
----   {95, 0, 87}
---
---`message` - The prompt message to display
---`number_of_inputs` - The number of numeric inputs to collect
---@param message string
---@param number_of_inputs number
---@return table
---@nodiscard
function input.number_table(message, number_of_inputs)
  if message then io.write(message) end

  local inputs = {}
  for i = 1, number_of_inputs do
    io.write(string.format("\ninput %d:", i))
    local num = tonumber(string.clean_number(io.read()))
    if not num then print(string.format("Invalid number at input %d", i)) end
    inputs[i] = num and tonumber(num) or 0
  end
  return inputs
end

---Collects string inputs until the user submits an empty input
---
---Features:
---- Displays an optional main message with instructions
---- Keeps collecting inputs until empty submission
---- Numbers each input prompt automatically
---- Returns all inputs in a table
---
---Example usage:
---- input.loop("Enter names")
---- Will show:
----   (press enter with nothing typed to submit) Enter names
----   Input 1: (user types)
----   Input 2: (user types)
----   Input 3: (user types)
---- User types:
----   Input 1: John
----   Input 2: Jane
----   Input 3:
---- Will return:
----   {"John", "Jane"}
---
---`message` - The prompt message to display
---@param message string
---@return table
---@nodiscard
function input.loop(message)
  local inputs = {}
  local current = 1

  io.write("(press enter with nothing typed to submit) " .. message)
  while true do
    io.write(string.format("\nInput %d:", current))
    local inp = io.read()
    if inp == "" then break end
    inputs[current] = tostring(inp)
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
---- input.number_loop("Enter scores")
---- Will show:
----   (press enter with nothing typed to submit) Enter scores
----   input 1: (user types)
----   input 2: (user types)
----   input 3: (user types)
----   input 4: (user types)
---- User types:
----   input 1: 95.5
----   input 2: abc (Not a numerical input, so it will put 0 as that input)
----   input 3: 87
----   input 4:
---- Will return:
----  {95.5, 0, 87}
---
---`message` - The prompt message to display
---@param message string
---@return table
---@nodiscard
function input.number_loop(message)
  local inputs = {}
  local current = 1

  io.write("(press enter with nothing typed to submit) " .. message)
  while true do
    io.write(string.format("\nInput %d:", current))
    local inp = io.read()
    if inp == "" then break end

    local num = tonumber(string.clean_number(inp))
    if not num then print(string.format("Invalid number at input %d", current)) end
    inputs[current] = num and tonumber(num) or 0
    current = current + 1
  end

  return inputs or {}
end