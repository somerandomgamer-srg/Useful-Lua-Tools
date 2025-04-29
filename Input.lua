---@param input string The input string to clean
---@return string cleaned The string with only valid number characters
local function cleanNum(input)
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

---@param message string The prompt message to display
---@return string input The user's input
function _G.Input(message)
  io.write(message .. ": ")
  return io.read()
end

---@param message string The prompt message to display
---@param numberOfInputs number The number of inputs to collect
---@return table inputs Table containing the user's inputs
function _G.InputTable(message, numberOfInputs)
  io.write(message)

  local inputs = {}
  for i = 1, numberOfInputs do
    io.write(string.format("\ninput %d:", i))
    inputs[i] = io.read()
  end
  return inputs
end

---@param message string The prompt message to display
---@return number input The user's numeric input (returns 0 if invalid)
function _G.InputNumber(message)
  io.write(message .. ": ")
  local num = tonumber(cleanNum(io.read()))
  if not num then print("Invalid number input") end
  return num and tonumber(num) or 0
end

---@param message string The prompt message to display
---@param numberOfInputs number The number of numeric inputs to collect
---@return table inputs Table containing the user's numeric inputs
function _G.InputNumberTable(message, numberOfInputs)
  io.write(message)

  local inputs = {}
  for i = 1, numberOfInputs do
    io.write(string.format("\ninput %d:", i))
    local num = tonumber(cleanNum(io.read()))
    if not num then print(string.format("Invalid number at input %d", i)) end
    inputs[i] = num and tonumber(num) or 0
  end
  return inputs
end
print
---@param message string The prompt message to display
---@return table inputs Table containing all inputs until empty input
function _G.InputLoop(message)
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
function _G.InputNumberLoop(message)

  local inputs = {}
  local current = 1

  io.write("(press enter with nothing typed to submit)" .. message)
  while true do
    io.write(string.format("\nInput %d:", current))
    local input = io.read()
    if input == "" then break end

    local num = tonumber(cleanNum(input))
    if not num then print(string.format("Invalid number at input %d", current))
    else
      inputs[current] = num and tonumber(num) or 0
      current = current + 1
    end
  end

  return inputs or {}
end