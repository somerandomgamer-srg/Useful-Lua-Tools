local function errorMsg(expected, name, value)
  error(string.format("%s expected for '%s', given: %s (%s)", expected, name, tostring(value), type(value)))
end

---***SRG Custom Function***
---
---Yields the code for `x` seconds. (Similar to python's wait function)
---@param x number
function wait(x)
  if x then
    if type(x) ~= "number" then errorMsg("Number", "x", x) end
    if x < 0 then error("'x' cannot be less than 0") end
  else x = 0.001
  end

  os.execute(string.format("sleep %d", x))
end

---***SRG Custom Function***
---
---Checks if `value` is a `type_of_object`
---@param value any
---@param type_of_object "nil"|"number"|"string"|"boolean"|"table"|"function"|"thread"|"userdata"
---@return boolean
function isType(value, type_of_object) return type(value) == type_of_object end

---
function benchmark(func, iterations)
  if type(func) ~= "function" then errorMsg("Function", "func", func) end
  if type(iterations) ~= "number" then errorMsg("Number", "iterations", iterations) end
  
  local startTime = os.clock()
  local lastResult
  
  for i = 1, iterations do
    local success, result = pcall(func)
    if not success then
      error("Error in iteration " .. i .. ": " .. result)
    end
    lastResult = result
  end
  
  local totalTime = os.clock() - startTime
  return totalTime, totalTime / iterations, lastResult
end

---
function execution_time(func)

end