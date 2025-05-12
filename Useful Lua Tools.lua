---------Initiation and Module Variables---------

---Error message formatter
local function errorMsg(expected, name, value)
  error(string.format("%s expected for '%s', given: %s (%s)", expected, name, tostring(value), type(value)))
end

---Main function for table.shuffle
local function shuffleTable(t)
  local shuffled = {}
  while #t > 0 do
    local random = t[math.random(#t)]

    shuffled:insert(random)
    t:remove(random)
  end

  return shuffled
end

---Main function for table.deep_count_keys
local function countRecursive(t, prefix, separator)
  prefix = prefix or ""
  local keyTable = {}
  local amount = 0

  for key, value in pairs(t) do
    local currentPath = prefix == "" and key or prefix .. separator .. key
    if type(value) == "table" then
      local subAmount, subKeys = countRecursive(value, currentPath, separator)
      amount = amount + subAmount
      for k, v in pairs(subKeys) do keyTable[k] = v end
    end
    keyTable[currentPath] = keyTable[currentPath] + 1 or 0
    amount = amount + 1
  end
  return amount, keyTable
end

local morseCodeTable = {
  a=".-", b="-...", c="-.-.", d="-..", e=".", f="..-.", g="--.", h="....", i="..", j=".---", k="-.-",
  l=".-..", m="--", n="-.", o="---", p=".--.", q="--.-", r=".-.", s="...", t="-", u="..-", v="...-",
  w=".--", x="-..-", y="-.--", z="--..", ["1"]=".----", ["2"]="..---", ["3"]="...--", ["4"]="....-",
  ["5"]=".....", ["6"]="-....", ["7"]="--...", ["8"]="---..", ["9"]="----.", ["0"]="-----",
  [" "] = "/", ["!"]="-.-.--", ["@"]=".--.-.", ["&"]=".-...", ["("]="-.--.", [")"]="-.--.-",
  ["-"]="-....-", ["="]="-...-", ["+"]=".-.-.", [":"]="---...", ["'"]=".----.", ['"']=".-..-.",
  [","]="--..--", ["."]=".-.-.-", ["/"]="-..-.", ["?"]="..--.."
}

---------Initiate Variables---------

-- ---The golden ratio (math`(1 + math.sqrt(5)) / 2`)
-- ---@type number
-- math.gr = (1 + math.sqrt(5)) / 2

---------Initiate Libraries---------

---@class cryptographylib
cryptography = {}

---@class inputlib
input = {}

---------Cryptography Library---------

---***SRG Custom Function***
---
---Converts a string (`s`) from plaintext to ascii
---@param s string
---@return string
---@nodiscard
function cryptography.text_to_ascii(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local asciiCode = ""
  for i in s do asciiCode = asciiCode .. s[i]:byte() .. " " end
  return string.trim(asciiCode)
end

---***SRG Custom Function***
---
---Converts ASCII codes to text
---@param s string
---@return string
---@nodiscard
function cryptography.ascii_to_text(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if not s:match("^%d+%s*") then error("Input must be space-separated ASCII numbers") end

  local text = ""
  for num in s:gmatch("%d+") do
    local n = tonumber(num)
    if n < 0 or n > 255 then error("ASCII values must be between 0 and 255") end
    text = text .. string.char(n)
  end
  return text
end

---***SRG Custom Function***
---
---Converts a string (`s`) from plaintext to hexadecimal
---@param s string
---@return string
---@nodiscard
function cryptography.text_to_hex(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local hexCode = ""
  for i = 1, #s do hexCode = hexCode .. string.format("%02X", s[i]:byte()) end
  return hexCode
end

---***SRG Custom Function***
---
---Converts hexadecimal to text
---@param s string
---@return string
---@nodiscard
function cryptography.hex_to_text(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local text = ""
  for hex in s:gmatch("..") do text = text .. string.char(tonumber(hex, 16)) end
  return text
end

---***SRG Custom Function***
---
---Converts a string (`s`) from plaintext to binary
---@param s string
---@return string
---@nodiscard
function cryptography.text_to_binary(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local binaryCode = ""
  for i = 1, #s do
    local charCode = string.byte(s, i)
    local binary = string.format("%08b", charCode)
    binaryCode = binaryCode .. binary .. " "
  end
  return string.trim(binaryCode)
end

---***SRG Custom Function***
---
---Converts binary string to text
---@param s string
---@return string
---@nodiscard
function cryptography.binary_to_text(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local text = ""
  for binary in s:gmatch("%d+") do text = text .. string.char(tonumber(binary, 2)) end
  return text
end

---***SRG Custom Function***
---
---Converts plaintext to morse code
---@param s string
---@return string
---@nodiscard
function cryptography.text_to_morse(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local morse = ""
  for c in s:lower():gmatch(".") do
    local code = morseCodeTable[c]
    if code then morse = morse .. code .. " " end
  end
  return string.trim(morse)
end

---***SRG Custom Function***
---
---Converts a string (`s`) from morse code to plaintext
---@param s string
---@return string
---@nodiscard
function cryptography.morse_to_text(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local text = ""
  local morseToText = {}

  for char, morse in pairs(morseCodeTable) do morseToText[morse] = char end

  s = s:gsub(" / ", "  ")
  for symbol in s:gmatch("%S+") do
    local char = morseToText[symbol]
    if char then text = text .. char end
  end
  return string.trim(text)
end

---***SRG Custom Function***
---
---Generates a random UUID (version 4)
---
---UUID V4 format: `xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`
---- `x`: 0-9 and a-f
---- Hyphens (-) separate sections
---- The `4` in the third section indicates it's a version 4 UUID
---- `y`: 8, 9, a, or b
---@return string
---@nodiscard
function cryptography.uuid_v4()
  local returnValue = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  returnValue = string.gsub(returnValue, "x", function() return ("0123456789abcdef")[math.random(16)] end)
  returnValue = string.gsub(returnValue, "y", function() return ("89ab")[math.random(4)] end)
  return returnValue
end

---***SRG Custom Function***
---
---Performs bitwise SWAP operation on `x`.
---@param x number
---@return number
---@nodiscard
function cryptography.bswap(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) | ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF)
end

---***SRG Custom Function***
---
---performs a bitwise left rotation on `x` by `disp` positions.
---@param x number The number to rotate
---@param disp number The number of positions to rotate left
---@return number
function cryptography.rol(x, disp)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(disp) ~= "number" then errorMsg("Number", "disp", disp) end

  return ((x << disp) | (x >> (32 - disp))) & 0xFFFFFFFF
end

---***SRG Custom Function***
---
---Performs a bitwise right rotation on `x` by `disp` positions.
---@param x number The number to rotate
---@param disp number The number of positions to rotate right
---@return number
function cryptography.ror(x, disp)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(disp) ~= "number" then errorMsg("Number", "disp", disp) end

  return ((x >> disp) | (x << (32 - disp))) & 0xFFFFFFFF
end

---***SRG Custom Function***
---
---Converts `x` to a 32-bit integer, normalizing it to the valid bit range.
---@param x number
---@return number
function cryptography.number_to_bit(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return x & 0xFFFFFFFF
end

---***SRG Custom Function***
---
---@Converts `x` to its hexadecimal representation.
---@param x number
---@return string
function cryptography.number_to_hex(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return string.format("%x", x & 0xFFFFFFFF)
end

---***SRG Custom Function***
---
---Returns a boolean signaling whether the bitwise *and* of its operands /is different from zero.
---@param a number
---@param b number
---@return boolean
function cryptography.btest(a, b)
  if type(a) ~= "number" then errorMsg("Number", "a", a) end
  if type(b) ~= "number" then errorMsg("Number", "b", b) end

  return (a & b) ~= 0
end

---***SRG Custom Function***
---
---Returns the unsigned number formed by the bits `field` to `field + width - 1` from `n`.
---@param n number
---@param field number
---@param width? number
---@return number
function cryptography.extract(n, field, width)
  if type(n) ~= "number" then errorMsg("Number", "n", n) end
  if type(field) ~= "number" then errorMsg("Number", "field", field) end
  if width and type(width) ~= "number" then errorMsg("Number", "width", width) end

  width = width or 1
  return (n >> field) & ((1 << width) - 1)
end

---***SRG Custom Function***
---
---Returns the number `x` rotated `disp` bits to the right. Negative displacements rotate to the left.
---@param x number
---@param disp number
---@return number
function cryptography.rrotate(x, disp)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(disp) ~= "number" then errorMsg("Number", "disp", disp) end

  disp = disp % 32
  return ((x >> disp) | (x << (32 - disp))) & 0xFFFFFFFF
end

---***SRG Custom Function***
---
---Returns the number `x` rotated `disp` bits to the left. Negative displacements rotate to the right.
---@param x number
---@param disp number
---@return number
function cryptography.lrotate(x, disp)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(disp) ~= "number" then errorMsg("Number", "disp", disp) end

  disp = disp % 32
  return ((x << disp) | (x >> (32 - disp))) & 0xFFFFFFFF
end

---***SRG Custom Function***
---
---Returns a copy of `n` with the bits `field` to `field + width - 1` replaced by the value `v`.
---@param n number
---@param v number
---@param field number
---@param width number
---@return number
function cryptography.replace(n, v, field, width)
  if type(n) ~= "number" then errorMsg("Number", "n", n) end
  if type(v) ~= "number" then errorMsg("Number", "v", v) end
  if type(field) ~= "number" then errorMsg("Number", "field", field) end
  if width and type(width) ~= "number" then errorMsg("Number", "width", width) end

  width = width or 1
  local mask = ~(((1 << width) - 1) << field)
  return (n & mask) | ((v & ((1 << width) - 1)) << field)
end

---***SRG Custom Function***
---
---Performs XOR encryption/decryption on a string (`s`) using a key (`key`)
---
---Note: XOR is symmetric - use the same key to decrypt
---@param s string
---@param key string
---@return string
---@nodiscard
function cryptography.xor(s, key)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if type(key) ~= "string" then errorMsg("String", "key", key) end

  local encrypted = ""

  for i = 1, #s do
    local charByte = string.byte(s:sub(i, i))
    local keyByte = string.byte(key:sub((i - 1) % #key + 1, (i - 1) % #key + 1))
    local encryptedByte = charByte ~ keyByte
    encrypted = encrypted .. string.char(encryptedByte)
  end

  return encrypted
end

---***SRG Custom Function***
---
---Applies Caesar cipher encryption to a string (`s`) with specified shift (`shift`)
---@param s string
---@param shift number
---@return string
---@nodiscard
function cryptography.caesar_cipher(s, shift)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if type(shift) ~= "number" then errorMsg("Number", "shift", shift) end

  local encrypted = ""

  for i = 1, #s do
    local character = s:sub(i, i)
    if character:match("%a") then
      local base = character:match("%u") and 65 or 97
      encrypted = encrypted .. string.char(((string.byte(character) - base + shift) % 26) + base)
    else encrypted = encrypted .. character
    end
  end

  return encrypted
end

---***SRG Custom Function***
---
---Applies ROT13 encryption (Caesar cipher with shift of 13) to a string (`s`)
---@param s string
---@return string
---@nodiscard
function cryptography.rot13(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  return cryptography.caesar_cipher(s, 13)
end

---------Input Library---------

---***SRG Custom Function***
---
---Gets a single string input from the user
---@param message? string
---@return string
---@nodiscard
function input.string(message)
  if message then
    if type(message) ~= "string" then errorMsg("String", "message", message) end
  else message = ""
  end

  io.write(message .. ": ")
  local inp = io.read()
  if not inp then
    print("Failed to read input")
    return ""
  end
  return inp
end

---***SRG Custom Function***
---
---Collects multiple string inputs from the user
---@param message? string
---@param number_of_inputs number
---@return table inputs
---@nodiscard
function input.table(message, number_of_inputs)
  if message then
    if type(message) ~= "string" then errorMsg("String", "message", message) end
  else message = ""
  end

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

---***SRG Custom Function***
---
---Gets a single numeric input from the user with validation
---@param message? string
---@return number input
---@nodiscard
function input.number(message)
  if message then
    if type(message) ~= "string" then errorMsg("String", "message", message) end
  else message = ""
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

---***SRG Custom Function***
---
---Collects multiple numeric inputs from the user
---@param message? string
---@param number_of_inputs number
---@return table
---@nodiscard
function input.number_table(message, number_of_inputs)
  if message then
    if type(message) ~= "string" then errorMsg("String", "message", message) end
  else message = ""
  end

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
    local num = tonumber(string.clean_number(io.read()))
    if not num then print(string.format("Invalid number at input %d", i)) end
    inputs[i] = num and tonumber(num) or 0
  end
  return inputs
end

---***SRG Custom Function***
---
---Collects string inputs until the user submits an empty input
---@param message? string
---@return table
---@nodiscard
function input.loop(message)
  if message then
    if type(message) ~= "string" then errorMsg("String", "message", message) end
  else message = ""
  end

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

---***SRG Custom Function***
---
---Collects numeric inputs until the user submits an empty input
---@param message? string
---@return table
---@nodiscard
function input.number_loop(message)
if message then
  if type(message) ~= "string" then errorMsg("String", "message", message) end
else message = ""
end

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

---------Math Library Extension---------

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
---Finds the greatest common factor between `x` and `y`
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
---Checks if `x` is a prime number
---@param x number
---@return boolean
---@nodiscard
function math.is_prime(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  if x < 2 then return false
  else
    local prime = true
    for i = 2, x - 1 do
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
---Finds the least common multiple between `x` and `y`
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
---Calculates the hyperbolic sine of `x`
---@param x number
---@return number
---@nodiscard
math.sinh = function(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return (math.exp(x) - math.exp(-x)) / 2
end

---***SRG Custom Function***
---
---Calculates the hyperbolic cosine of `x`
---@param x number
---@return number
---@nodiscard
math.cosh = function(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return (math.exp(x) + math.exp(-x)) / 2
end

---***SRG Custom Function***
---
---Calculates the hyperbolic tangent of `x`
---@param x number
---@return number
---@nodiscard
math.tanh = function(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.sinh(x) / math.cosh(x)
end

---***SRG Custom Function***
---
---Calculates the inverse hyperbolic cosine of `x`
---@param x number
---@return number
---@nodiscard
function math.acosh(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.log(x + math.sqrt(x^2 - 1))
end

---***SRG Custom Function***
---
---Calculates the inverse hyperbolic tangent of `x`
---@param x number
---@return number
---@nodiscard
function math.atanh(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.log((1 + x)/(1 - x)) / 2
end

---***SRG Custom Function***
---
---Calculates the inverse hyperbolic sine of `x`
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
---
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
---
---NOTE: Floats are neither odd nor even
---@param x number
---@return number
function math.is_even(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return x % 2 == 0
end

---***SRG Custom Function***
---
---Randomly makes `x` positive or negative
---
---NOTE: Floats are neither odd nor even
---@param x number
---@return number
function math.random_sign(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  local r = math.random(2)
  if r == 2 then return -math.abs(x)
  else return math.abs(x)
  end
end

---***SRG Custom Function***
---
---Checks if the square root of `x` is a whole number or not
---
---NOTE: Floats are neither odd nor even
---@param x number
---@return number
function math.is_perfect_square(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.sqrt(x) == math.floor(math.sqrt(x))
end

---***SRG Custom Function***
---
---Calculates the factorial of `x`
---@param x number
---@return number
function math.factorial(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if x == 0 then return 1 end
  if x < 0 then error("`x` cannot be a negative number, given: " .. tostring(x)) end

  local fact = x
  for i = x - 1, 1, -1 do fact = fact * i end

  return fact
end

---***SRG Custom Function***
---
---Calculates the number of ways to arrange r items from x items
---@param x number
---@param r number
---@return number
---@nodiscard
function math.permutation(x, r)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(r) ~= "number" then errorMsg("Number", "r", r) end
  if x < r then error("`r` cannot be greater than `x`") end

  return math.factorial(x) / math.factorial(x - r)
end

---***SRG Custom Function***
---
---Calculates the number of ways to choose r items from x items
---@param x number
---@param r number
---@return number
---@nodiscard
function math.combination(x, r)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(r) ~= "number" then errorMsg("Number", "r", r) end
  if x < r then error("`r` cannot be greater than `x`") end

  return math.factorial(x) / (math.factorial(r) * math.factorial(x - r))
end

---***SRG Custom Function***
---
---Returns all factors of a number
---@param x number
---@return table
---@nodiscard
function math.factors(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if x < 0 then error("`x` cannot be a negative number, given: " .. tostring(x)) end
  if math.floor(x) ~= x then error("`x` must be a whole number") end


  local factors = {1, x}
  for i = 2, x - 1 do
    if x % i == 0 then factors:insert(i) end
  end

  return factors
end

---***SRG Custom Function***
---
---Checks if a number is perfect (sum of factors equals the number)
---@param x number
---@return boolean
---@nodiscard
function math.is_perfect(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.sum(math.factors(x)) - x == x
end

---***SRG Custom Function***
---
---Checks if a number is deficient (sum of factors less than number)
---@param x number
---@return boolean
---@nodiscard
function math.is_deficient(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.sum(math.factors(x)) - x < x
end

---***SRG Custom Function***
---
---Checks if a number is abundant (sum of factors greater than number)
---@param x number
---@return boolean
---@nodiscard
function math.is_abundant(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.sum(math.factors(x)) - x > x
end

---***SRG Custom Function***
---
---Classifies a number as Perfect, Deficient, or Abundant
---@param x number
---@return string
---@nodiscard
function math.classify_number(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  if math.is_perfect(x) then return "Perfect"
  elseif math.is_deficient(x) then return "Deficient"
  elseif math.is_abundant(x) then return "Abundant"
  else return "Unknown"
  end
end

---***SRG Custom Function***
---
---Calculates the z-score of a value in a dataset
---- Z = 0 → Exactly average (equal to the mean)
---- Z > 0 → Above the mean
---- Z < 0 → Below the mean
---- Z > 2 or Z < -2 → Unusual (more than 2 standard deviations away)
---- Z > 3 or Z < -3 → Extremely rare
---@param x number
---@param t table
---@return number
---@nodiscard
function math.z_score(x, t)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local avg = math.average(t)
  local dev = math.standard_deviation(t)

  return (x - avg) / dev
end

---***SRG Custom Function***
---
---Calculates the secant of x (1/cos(x))
---@param x number
---@return number
---@nodiscard
function math.secant(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  x = math.cos(x)

  if x == 0 then error("Secant is undefined for this input") end
  return 1 / x
end

---***SRG Custom Function***
---
---Calculates the cosecant of x (1/sin(x))
---@param x number
---@return number
---@nodiscard
function math.cosecant(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  x = math.sin(x)

  if x == 0 then error("Cosecant is undefined for this input") end
  return 1 / x
end

---***SRG Custom Function***
---
---Calculates the cotangent of x (1/tan(x))
---@param x number
---@return number
---@nodiscard
function math.cotangent(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  x = math.tan(x)

  if x == 0 then error("Cotangent is undefined for this input") end
  return 1 / x
end

---***SRG Custom Function***
---
---Calculates the inverse secant of x (arccos(1/x))
---@param x number
---@return number
---@nodiscard
function math.asecant(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.acos(1 / x)
end

---***SRG Custom Function***
---
---Calculates the inverse cosecant of x (arcsin(1/x))
---@param x number
---@return number
---@nodiscard
function math.acosecant(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.asin(1 / x)
end

---***SRG Custom Function***
---
---Calculates the inverse cotangent of x (arctan(1/x))
---@param x number
---@return number
---@nodiscard
function math.acotangent(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.atan(1 / x)
end

---------String Library Extension---------

---***SRG Custom Function***
---
---Cleans a `s` to ensure it's a valid number format
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
---Capitalizes the first letter of each word in `s`, seperating each word by the specified separator `sep` (default is space)
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

---***SRG Custom Function***
---
---Checks if `s` is a palindrome (the reversed string is the same as the original string)
---@param s string
---@return boolean
---@nodiscard
function string.is_palindrome(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  return s:reverse() == s
end

---------Table Library Extension---------

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

---***SRG Custom Function***
---
---Reverses the order of elements in `t`
---@param t table
---@return table
---@nodiscard
function table.reverse(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local reversed = {}
  for i = #t, 1, -1 do reversed:insert(i) end
  return reversed
end

---***SRG Custom Function***
---
---Shuffles the order of elements in `t` `n` times
---
---NOTE: If `n` is not given, `t` will only shuffle once
---@param t table
---@param n? number
---@return table
---@nodiscard
function table.shuffle(t, n)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end
  if n then
    if type(n) ~= "number" then errorMsg("Number", "n", n) end
  else
    n = 1
  end

  while n > 0 do
    t = shuffleTable(t)
    n = n - 1
  end

  return t
end

---***SRG Custom Function***
---
---Counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences
---@param t table
---@return number
---@return table Key_Table
---@nodiscard
function table.count_keys(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local keyTable = {}
  local amount = 0
  for key, _ in pairs(t) do
    keyTable[key] = keyTable[key] + 1 or 1
    amount = amount + 1
  end
  return amount, keyTable
end

---***SRG Custom Function***
---
---Recursively counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences.
---
---The keys in nested tables are joined using `separator` (defaults to ".")
---@param t table
---@param separator? string
---@return number Total_Number_of_Keys
---@return table Key_Table_With_Key_Paths_and_Their_Counts
---@nodiscard
function table.deep_count_keys(t, separator)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end
  separator = separator or "."

  return countRecursive(t, separator)
end

---------Global Functions---------

---***SRG Custom Function***
---
---Yields the code for `x` seconds (Similar to the python wait() function)
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
function is_type(value, type_of_object) return type(value) == type_of_object end

---***SRG Custom Function***
---
---Runs `func` `iterations` times
---
---NOTE: If `iterations` is not given, the code will run 10 times
---
---Returns:
---- `Total Execution Time`
---- `Average Execution Time Per Run`
---- `The Last Result (if return is added in the code)`
---@param func function
---@param iterations number
---@return number Total_Timer
---@return number Average_Time_Per_Run
---@return string Last_Result
function benchmark(func, iterations)
  if type(func) ~= "function" then errorMsg("Function", "func", func) end
  if iterations then
    if type(iterations) ~= "number" then errorMsg("Number", "iterations", iterations) end
  else
    iterations = 10
  end

  local startTime = os.clock()
  local lastResult

  for i = 1, iterations do
    local success, result = pcall(func)
    if not success then error("Error in iteration " .. i .. ": " .. result) end
    lastResult = result
  end

  local totalTime = os.clock() - startTime
  return totalTime, totalTime / iterations, lastResult
end

---***SRG Custom Function***
---
---Runs `func` and returns the time it takes to run `func`
---@param func function
---@return number Time
---@return string Result
function execution_time(func)
  if type(func) ~= "function" then errorMsg("Function", "func", func) end

  local start = os.clock()
  local success, result = pcall(func)
  if not success then error("Error executing function: " .. result) end

  return os.clock() - start, result
end

---***SRG Custom Function***
---
---Yields `t` seconds before running `func` without stopping other code.
---@param t number
---@param func function
---@return any
function delay(t, func)
  if type(t) ~= "number" then errorMsg("Number", "t", t) end
  if type(func) ~= "function" then errorMsg("Function", "func", func) end

  return coroutine.wrap(function()
    wait(t)
    return func()
  end)()
end

---***SRG Custom Function***
---
---Yields `t` seconds before running `func` while stopping other code.
---@param t number
---@param func function
---@return any
function delay_stop(t, func)
  if type(t) ~= "number" then errorMsg("Number", "t", t) end
  if type(func) ~= "function" then errorMsg("Function", "func", func) end

  wait(t)
  return func()
end