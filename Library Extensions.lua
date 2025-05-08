local function errorMsg(expected, name, value)
  error(string.format("%s expected for '%s', given: %s (%s)", expected, name, tostring(value), type(value)))
end

-----------Math Library-----------
---***SRG Custom Function***
---
---Calculates the average from a list of numbers
---@param t table
---@return number
---@nodiscard
function math.average(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local average
  local total = 0
  for i = 1, #t do total = total + t[i] end
  average = total / #t
  return average
end

---***SRG Custom Function***
---
---Calculates the median from a list of numbers
---@param t table
---@return number
---@nodiscard
function math.median(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  t:sort()
  local middle = math.floor(#t / 2) + 1
  if #t % 2 == 1 then return t[middle]
  else return (t[middle] + t[middle - 1]) / 2
  end
end

---***SRG Custom Function***
---
---Calculates the range from a list of numbers
---@param t table
---@return number
---@nodiscard
function math.range(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local minimum = math.min(t:unpack())
  local maximum = math.max(t:unpack())

  return maximum - minimum
end

---***SRG Custom Function***
---
---Calculates the mode from a list of numbers
---@param t table
---@return number
---@nodiscard
function math.mode(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local freq = {}
  for i = 1, #t do
    if freq[t[i]] then freq[t[i]] = freq[t[i]] + 1
    else freq[t[i]] = 1
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
---@param t table
---@return number
---@nodiscard
function math.standard_deviation(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local deviation = 0
  local avg = math.average(t)
  for i = 1, #t do deviation = deviation + (t[i] - avg)^2 end
  return math.sqrt(deviation / #t)
end

---***SRG Custom Function***
---
---Calculates the sum from a list of numbers
---@param t table
---@return number
---@nodiscard
function math.sum(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local sum = 0
  for i in #t do sum = sum + t[i] end
  return sum
end

---***SRG Custom Function***
---
---Finds the greatest common factor between 2 numbers (`x` and `y`)
---@param x number
---@param y number
---@return number
---@nodiscard
function math.gcd(x, y)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(y) ~= "number" then errorMsg("Number", "y", y) end

  local result
  local biggest = math.max(x, y)

  if x == y then result = x
  elseif x == 0 or y == 0 then result = "N/A"
  elseif x == 1 or y == 1 then result = 1
  else
    for i = 1, biggest do
      if x % i == 0 and y % i == 0 then result = i end
    end
  end

  return result
end

---***SRG Custom Function***
---
---Checks if a number (`x`) is a prime number
---@param x number
---@return boolean
---@nodiscard
function math.is_prime(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  if x < 2 then return false
  else
    local prime = true
    for i = 2, x - 1 do --Corrected loop condition
      if x % i == 0 then
        prime = false
        break
      end
    end
    return prime
  end
end

---***SRG Custom Function***
---
---Finds the least common multiple between 2 numbers (`x` and `y`)
---@param x number
---@param y number
---@return number
---@nodiscard
function math.lcm(x, y)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(y) ~= "number" then errorMsg("Number", "y", y) end

  return (x * y) / math.gcd(x, y)
end


---***SRG Custom Function***
---
---Solves a quadratic equation in the form ax² + bx + c using the quadratic formula
---@param a number
---@param b number
---@param c number
---@return number?
---@return number?
---@nodiscard
function math.quadratic(a, b, c)
  if type(a) ~= "number" then errorMsg("Number", "a", a) end
  if type(b) ~= "number" then errorMsg("Number", "b", b) end
  if type(c) ~= "number" then errorMsg("Number", "c", c) end

  local disc = b ^ 2 - 4 * a * c

  if disc < 0 then
    print("No real roots")
    return nil, nil
  end

  local temp = -b + math.sqrt(disc)
  local temp2 = -b - math.sqrt(disc)
  local temp3 = 2 * a
  local ans1 = temp / temp3
  local ans2 = temp2 / temp3
  return ans1, ans2
end

---***SRG Custom Function***
---
---Calculates the axis of symmetry for a quadratic function using `a` and `b` coefficients
---@param a number
---@param b number
---@return number
---@nodiscard
function math.aos(a, b)
  if type(a) ~= "number" then errorMsg("Number", "a", a) end
  if type(b) ~= "number" then errorMsg("Number", "b", b) end

  return -b / (2 * a)
end

---***SRG Custom Function***
---
---Calculates the vertex point of a quadratic function using `a`, `b`, and `c` coefficients
---@param a number
---@param b number
---@param c number
---@return number x
---@return number y
---@nodiscard
function math.vertex(a, b, c)
  if type(a) ~= "number" then errorMsg("Number", "a", a) end
  if type(b) ~= "number" then errorMsg("Number", "b", b) end
  if type(c) ~= "number" then errorMsg("Number", "c", c) end

  local aos = math.aos(a, b)

  return aos, a * aos ^ 2 + b * aos + c
end

---***SRG Custom Function***
---
---Calculates the hyperbolic sine of x
---@param x number
---@return number
---@nodiscard
math.sinh = function(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return (math.exp(x) - math.exp(-x)) / 2
end

---***SRG Custom Function***
---
---Calculates the hyperbolic cosine of x
---@param x number
---@return number
---@nodiscard
math.cosh = function(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return (math.exp(x) + math.exp(-x)) / 2
end

---***SRG Custom Function***
---
---Calculates the hyperbolic tangent of x
---@param x number
---@return number
---@nodiscard
math.tanh = function(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.sinh(x) / math.cosh(x)
end

---***SRG Custom Function***
---
---Calculates the inverse hyperbolic cosine of x
---@param x number
---@return number
---@nodiscard
function math.acosh(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.log(x + math.sqrt(x^2 - 1))
end

---***SRG Custom Function***
---
---Calculates the inverse hyperbolic tangent of x
---@param x number
---@return number
---@nodiscard
function math.atanh(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.log((1 + x)/(1 - x)) / 2
end

---***SRG Custom Function***
---
---Calculates the inverse hyperbolic sine of x
---@param x number
---@return number
---@nodiscard
function math.asinh(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.log(x + math.sqrt(x^2 + 1))
end

---***SRG Custom Function***
---
---Rounds `x` to `precision` decimal places (whole number if no precision given)
---@param x number
---@param precision? number
---@return number
function math.round(x, precision)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(precision) ~= "number" then errorMsg("Number", "precision", precision) end

  local mult = 10^(precision or 0)
  return math.floor(x * mult + 0.5) / mult
end

---***SRG Custom Function***
---
---Calculates the `n`th term of the Fibonacci Sequence
---@param n number
---@return number
function math.fib(n)
  if type(n) ~= "number" then errorMsg("Number", "n", n) end

  if n <= 0 then return 0
  elseif n == 1 then return 0
  elseif n == 2 then return 1
  else return math.fib(n-1) + math.fib(n-2)
  end
end

---***SRG Custom Function***
---
---Checks if `x` is an odd number
---NOTE: Floats are neither odd nor even
---@param x number
---@return number
function math.is_odd(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return x % 2 == 1
end

---***SRG Custom Function***
---
---Checks if `x` is an even number
---NOTE: Floats are neither odd nor even
---@param x number
---@return number
function math.is_even(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return x % 2 == 0
end

-----------String Library-----------

---***SRG Custom Function***
---
---Cleans a string (`s`) to ensure it's a valid number format
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
---@param s string
---@return string 
---@nodiscard
function string.clean_number(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local cleaned = s:gsub("[^0-9%.%-]", "")

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
---Removes whitespace from both ends of `s`
---@param s string
---@return string
---@nodiscard
function string.trim(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  return s:match("^%s*(.-)%s*$")
end

---***SRG Custom Function***
---
---Splits `s` into a table based on `pattern`
---
---Example:
---```lua
---  string.split("1 2 3 4 5", " ") -> {"1","2","3","4","5"}
---  string.split("1-2-3-4-5", "-") -> {"1","2","3","4","5"}
---  string.split("1 2:3 4 5", ":") -> {"1 2","3 4 5"}
---```
---@param s string
---@param pattern string
---@return table
---@nodiscard
function string.split(s, pattern)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if type(pattern) ~= "string" then errorMsg("String", "pattern", pattern) end

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
---Checks if `s` starts with `letter`
---@param s string
---@param letter string
---@return boolean
---@nodiscard
function string.starts_with(s, letter)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  return s[1] == letter
end

---***SRG Custom Function***
---
---Checks if `s` ends with `letter`
---@param s string
---@param letter string
---@return boolean
---@nodiscard
function string.ends_with(s, letter)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  return s[#s] == letter
end

---***SRG Custom Function***
---
---Adds `string_char` to `s`'s start if `include_start` is true and to its end if `include_end` is true, repeating it `length` times.
---@param s string
---@param string_char string
---@param length number
---@param include_start? boolean
---@param include_end? boolean
---@return string
---@nodiscard
function string.pad(s, string_char, length, include_start, include_end)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if type(string_char) ~= "string" then errorMsg("String", "string_char", string_char) end
  if type(length) ~= "number" then errorMsg("Number", "length", length) end
  if include_start and type(include_start) ~= "boolean" then errorMsg("Boolean", "include_start", include_start) end
  if include_end and type(include_end) ~= "boolean" then errorMsg("Boolean", "include_end", include_end) end

  if not include_start or not include_end then include_start, include_end = true, true end

  if include_start then s = string.rep(string_char, length) .. s end
  if include_start then s = s .. string.rep(string_char, length) end

  return s
end

---***SRG Custom Function***
---
---Capitalizes the first character of a string
---@param s string
---@return string
---@nodiscard
function string.capitalize(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if #s == 0 then return s end

  return s:sub(1, 1):upper() .. s:sub(2)
end

---***SRG Custom Function***
---
---Capitalizes the first letter of each word in `s` using the specified separator `sep` (default is space)
---@param s string
---@param sep? string 
---@return string
---@nodiscard
function string.title_case(s, sep)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if sep then
    if type(sep) ~= "string" then errorMsg("String", "sep", sep) end
  else
    sep = " "
  end
  if #s == 0 then return s end

  local capitalized = ""
  local t = string.split(s, sep)

  for _, word in ipairs(t) do capitalized = capitalized .. string.capitalize(word) end
  return capitalized
end

---***SRG Custom Function***
---
---Returns the amount of occurrences `pattern` occurs in `s`
---@param s string
---@param pattern? string 
---@return number
---@nodiscard
function string.count(s, pattern)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if not pattern or #pattern == 0 then pattern = " " end

  local amount = 0
  for _ in string.gmatch(s, pattern) do count = count + 1 end
  return amount
end
-----------Table Library-----------

---***SRG Custom Function***
---
---Recursively checks if `t` contains `value`
---
---Returns (`true`, `number of instances`) or (`false`, `0`)
---@param t table
---@param value any
---@return boolean
---@return number instances
---@nodiscard
function table.contains(t, value)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local amount = 0
  for _, v in pairs(t) do
    if v == value then amount = amount + 1
    elseif type(v) == "table" then
      local contains, instances = table.contains(v, value)
      if contains then amount = amount + instances end
    end
  end
  return amount > 0, amount
end

---***SRG Custom Function***
---
---Converts a CSV string (`s`) into a table 
---@param s string
---@return table
---@nodiscard
function table.csv_to_table(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local toReturn = {}
  local currentRow = {}
  local field = ""
  local inQuotes = false
  local i = 1
  local row = 1

  while i <= #s do
    local char = s:sub(i, i)

    if char == '"' then
      if inQuotes and s:sub(i + 1, i + 1) == '"' then
        field = field .. '"'
        i = i + 2
      else
        inQuotes = not inQuotes
        i = i + 1
      end
    elseif char == ',' and not inQuotes then
      table.insert(currentRow, field)
      field = ""
      i = i + 1
    elseif (char == '\n' or i == #s) and not inQuotes then
      if i == #s and char ~= '\n' then field = field .. char end
      table.insert(currentRow, field)
      toReturn[row] = currentRow
      currentRow = {}
      field = ""
      row = row + 1
      i = i + 1
    else
      field = field .. char
      i = i + 1
    end
  end

  return toReturn
end

---***SRG Custom Function***
---
---Converts a table (`t`) to a CSV string
---@param t table
---@return string
---@nodiscard
function table.to_csv(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local csv = ""
  for i = 1, #t do
    local row = t[i]
    if type(row) == "table" then
      for ii = 1, #row do
        local value = tostring(row[ii])
        if value:find('[,"\n]') then value = '"' .. value:gsub('"', '""') .. '"' end
        csv = csv .. value
        if ii < #row then csv = csv .. "," end
      end
      if i < #t then csv = csv .. "\n" end
      if i < #row then csv = csv .. "," end
    end
    if i < #t then csv = csv .. "\n" end
  end
  return csv
end

function table.reverse(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local reversed = {}
  for i = #t, 1, -1 do reversed:insert(i) end
  return reversed
end

function table.shuffle(t, n)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end
  if n then
    if type(n) ~= "number" then errorMsg("Number", "n", n) end
  else
    n = 1
  end

  local shuffled = {}
  for i = 1, #t do
    shuffled[i] = t[i]
  end

  while n > 0 do
    for i = #shuffled, 2, -1 do
      local j = math.random(i)
      shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
    end
    n = n - 1
  end

  return shuffled
end