---SRG Custom Function
---
---Calculates the average from a table of numbers
---@param table table
---@return number average
---@nodiscard
function math.average(table)
  local average = 0
  if type(table) == "table" then
    local total = 0
    for i = 1, #table do total = total + table[i] end
    average = total / #table
  end
  return average
end

---SRG Custom Function
---
---Calculates the median from a table of numbers
---@param table table
---@return number median
---@nodiscard
function math.median(table)
  table.sort(table)
  local middle = math.floor(#table / 2) + 1
  if table then
    if #table % 2 == 1 then return table[middle]
    else return (table[middle] + table[middle - 1]) / 2
    end
  end

  return 0
end

---SRG Custom Function
---
---Calculates the range from a table of numbers
---@param table table
---@return number range
---@nodiscard
function math.range(table)
  local minimum = math.min(table:unpack())
  local maximum = math.max(table:unpack())

  return maximum - minimum
end

---SRG Custom Function
---
---Calculates the mode from a table of numbers
---@param table table
---@return number average
---@nodiscard
function math.mode(table)
  local freq = {}
  for i = 1, #table do
    if freq[table[i]] then freq[table[i]] = freq[table[i]] + 1
    else freq[table[i]] = 1
    end
  end

  local toReturn
  local maxCount = 0
  for i, v in pairs(freq) do
    if v > maxCount then maxCount, toReturn = v, i end
  end

  return toReturn
end

---SRG Custom Function
---
---Calculates the standard deviation from a table of numbers
---@param table table
---@return number
---@nodiscard
function math.standard_deviation(table)
  local deviation = 0
  local avg = math.average(table)
  for i = 1, #table do deviation = deviation + (table[i] - avg)^2 end
  return math.sqrt(deviation / #table)
end

---SRG Custom Function
---
---Calculates the sum from a table of numbers
---@param table table
---@return number
---@nodiscard
function math.sum(table)
  local sum = 0
  for i in #table do sum = sum + table[i] end
  return sum
end


function math.asinh(x) return math.log(x + math.sqrt(x^2 + 1)) end

---SRG Custom Function
---
---Calculates the hyperbolic sine of x
---
---`x` - The input value <br> `result` - The hyperbolic sine of x
---@param x number
---@return number result
---@nodiscard
function math.sinh(x) return (math.exp(x) - math.exp(-x)) / 2 end

---SRG Custom Function
---
---Calculates the hyperbolic cosine of x
---
---`x` - The input value <br> `result` - The hyperbolic cosine of x
---@param x number
---@return number result
---@nodiscard
function math.cosh(x) return (math.exp(x) + math.exp(-x)) / 2 end

---SRG Custom Function
---
---Calculates the hyperbolic tangent of x
---
---`x` - The input value <br> `result` - The hyperbolic tangent of x
---@param x number
---@return number result
---@nodiscard
function math.tanh(x) return math.sinh(x) / math.cosh(x) end

---SRG Custom Function
---
---Calculates the inverse hyperbolic cosine of x
---
---`x` - The input value (must be >= 1) <br> `result` - The inverse hyperbolic cosine of x
---@param x number
---@return number result
---@nodiscard
function math.acosh(x) return math.log(x + math.sqrt(x^2 - 1)) end

---SRG Custom Function
---
---Calculates the inverse hyperbolic tangent of x
---
---`x` - The input value (must be between -1 and 1) <br> `result` - The inverse hyperbolic tangent of x
---@param x number
---@return number result
---@nodiscard
function math.atanh(x) return math.log((1 + x)/(1 - x)) / 2 end