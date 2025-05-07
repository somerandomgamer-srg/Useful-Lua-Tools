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
---@param value any The value to check
---@param type_of_object "nil"|"number"|"string"|"boolean"|"table"|"function"|"thread"|"userdata" The type to check against
---@return boolean
function isType(value, type_of_object) return type(value) == type_of_object end

