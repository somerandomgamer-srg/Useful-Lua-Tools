-----------Math Library-----------
---***SRG Custom Function***
---
---Calculates the average from a list of numbers
---@param list table
---@return number
---@nodiscard
function math.average(list)
  local average = 0
  if type(list) == "list" then
    local total = 0
    for i = 1, #list do total = total + list[i] end
    average = total / #list
  end
  return average
end

---***SRG Custom Function***
---
---Calculates the median from a list of numbers
---@param list table
---@return number
---@nodiscard
function math.median(list)
  list:sort()
  local middle = math.floor(#list / 2) + 1
  if list then
    if #list % 2 == 1 then return list[middle]
    else return (list[middle] + list[middle - 1]) / 2
    end
  end

  return 0
end

---***SRG Custom Function***
---
---Calculates the range from a list of numbers
---@param list table
---@return number
---@nodiscard
function math.range(list)
  local minimum = math.min(list:unpack())
  local maximum = math.max(list:unpack())

  return maximum - minimum
end

---***SRG Custom Function***
---
---Calculates the mode from a list of numbers
---@param list table
---@return number
---@nodiscard
function math.mode(list)
  local freq = {}
  for i = 1, #list do
    if freq[list[i]] then freq[list[i]] = freq[list[i]] + 1
    else freq[list[i]] = 1
    end
  end

  local toReturn
  local maxCount = 0
  for i, v in pairs(freq) do
    if v > maxCount then maxCount, toReturn = v, i end
  end

  return toReturn
end

---***SRG Custom Function***
---
---Calculates the standard deviation from a list of numbers
---@param list table
---@return number
---@nodiscard
function math.standard_deviation(list)
  local deviation = 0
  local avg = math.average(list)
  for i = 1, #list do deviation = deviation + (list[i] - avg)^2 end
  return math.sqrt(deviation / #list)
end

---***SRG Custom Function***
---
---Calculates the sum from a list of numbers
---@param list table
---@return number
---@nodiscard
function math.sum(list)
  local sum = 0
  for i in #list do sum = sum + list[i] end
  return sum
end

---***SRG Custom Function***
---
---Calculates the hyperbolic sine of x
---@param x number
---@return number
---@nodiscard
math.sinh = function(x) return (math.exp(x) - math.exp(-x)) / 2 end

---***SRG Custom Function***
---
---Calculates the hyperbolic cosine of x
---@param x number
---@return number
---@nodiscard
math.cosh = function(x) return (math.exp(x) + math.exp(-x)) / 2 end

---***SRG Custom Function***
---
---Calculates the hyperbolic tangent of x
---@param x number
---@return number
---@nodiscard
math.tanh = function(x) return math.sinh(x) / math.cosh(x) end

---***SRG Custom Function***
---
---Calculates the inverse hyperbolic cosine of x
---@param x number
---@return number
---@nodiscard
function math.acosh(x) return math.log(x + math.sqrt(x^2 - 1)) end

---***SRG Custom Function***
---
---Calculates the inverse hyperbolic tangent of x
---@param x number
---@return number
---@nodiscard
function math.atanh(x) return math.log((1 + x)/(1 - x)) / 2 end

---***SRG Custom Function***
---
---Calculates the inverse hyperbolic sine of x
---@param x number
---@return number
---@nodiscard
function math.asinh(x) return math.log(x + math.sqrt(x^2 + 1)) end

-----------Math Library-----------
