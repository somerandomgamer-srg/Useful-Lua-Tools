---Cleans a string to ensure it's a valid number format
---
---
---Removes non-numeric characters, handles decimals and negative signs
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

---@param message string
---@return table inputs
---@nodiscard
---Gets a string input from the user
function Input(message)
  io.write(message .. ": ")
  return io.read()
end

---@param message string
---@param number_of_inputs number
---@return table inputs
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

---@param message string The prompt message to display
---@return number input The user's numeric input (returns 0 if invalid)
function InputNumber(message)
  io.write(message .. ": ")
  local num = tonumber(CleanNumber(io.read()))
  if not num then print("Invalid number input") end
  return num and tonumber(num) or 0
end

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