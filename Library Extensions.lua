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

-----------String Library-----------

---***SRG Custom Function***
---
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
---- CleanNumber("$52 per Year") -> "52"
---
---`input` - The string to be cleaned <br> `cleaned` - The resulting valid number string
---@param input string
---@return string cleaned 
---@nodiscard
function string.clean_number(input)
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

---***SRG Custom Function***
---
---Removes whitespace from both ends of a string
---@param s string
---@return string
---@nodiscard
function string.trim(s)
  return s:match("^%s*(.-)%s*$")
end


---***SRG Custom Function***
---
---Splits a string (`s`) into a table based on a pattern (`pattern`)
---@param s string
---@param pattern string
---@return table
---@nodiscard
function string.split(s, pattern)
  toReturn = {}
  local start = 1

  for i = 1, #s do
    if s:sub(i, i) == pattern then
      local string = s:sub(start, i - 1)
      toReturn:insert(string)
      start = i + 1
    end
  end
  return toReturn
end

---***SRG Custom Function***
---
---Checks if a string (`s`) starts with a specific letter (`letter`)
---@param s string
---@param letter string
---@return boolean
---@nodiscard
function string.starts_with(s, letter) return s[1] == letter end

---***SRG Custom Function***
---
---Checks if a string (`s`) ends with a specific letter (`letter`)
---@param s string
---@param letter string
---@return boolean
---@nodiscard
function string.ends_with(s, letter) return s[1] == letter end

-----------Table Library-----------

---***SRG Custom Function***
---
---Checks if a table contains a specific value
---
---Features:
---- Searches through all values in the table
---- Works with any value type (numbers, strings, etc.)
---- Returns true if found, false if not
---
---Example usage:
---- local t = {1, 2, 3, "hello"}
---- table.contains(t, 2) -> true
---- table.contains(t, "hello") -> true
---- table.contains(t, 5) -> false
---
---`t` - The table to search in <br> `value` - The value to search for <br> `found` - Whether the value was found
---@param t table
---@param value any
---@return boolean found
---@nodiscard
function table.contains(t, value)
  for _, v in pairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

