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
  if type(func) ~= "function" then errorMsg("Function", "func", func) end
  
  local start = os.clock()
  local success, result = pcall(func)
  if not success then error("Error executing function: " .. result) end
  
  return os.clock() - start, result
end

---***SRG Custom Function***
---
---Gets current CPU usage as a percentage
---@return number percentage
function get_cpu_usage()
  local f = io.open("/proc/stat", "r")
  if not f then return 0 end
  
  local stat = f:read("*l")
  f:close()
  
  local user, nice, system, idle = stat:match("cpu%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)")
  if not user then return 0 end
  
  local total = tonumber(user) + tonumber(nice) + tonumber(system) + tonumber(idle)
  local used = total - tonumber(idle)
  return (used / total) * 100
end

---***SRG Custom Function***
---
---Gets current memory usage in megabytes
---@return number megabytes
function get_memory_usage()
  local f = io.open("/proc/self/status", "r")
  if not f then return 0 end
  
  local mem = 0
  for line in f:lines() do
    local vmsize = line:match("VmSize:%s+(%d+)")
    if vmsize then
      mem = tonumber(vmsize)
      break
    end
  end
  f:close()
  
  return mem / 1024 -- Convert KB to MB
end