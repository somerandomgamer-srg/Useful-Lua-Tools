local function errorMsg(expected, name, value)
  error(string.format("%s expected for '%s', given: %s (%s)", expected, name, tostring(value), type(value)))
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

---@class cryptographylib
cryptography = {}

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
---Performs bitwise XOR operation between `a` and `b`
---@param a number
---@param b number
---@return number
---@nodiscard
function cryptography.bxor(a, b)
  if type(a) ~= "number" then errorMsg("Number", "a", a) end
  if type(b) ~= "number" then errorMsg("Number", "b", b) end

  return a ~ b
end

---***SRG Custom Function***
---
---Performs bitwise AND operation between `a` and `b`
---@param a number
---@param b number
---@return number
---@nodiscard
function cryptography.band(a, b)
  if type(a) ~= "number" then errorMsg("Number", "a", a) end
  if type(b) ~= "number" then errorMsg("Number", "b", b) end

  return a & b
end

---***SRG Custom Function***
---
---Performs bitwise NOT operation on `x`
---@param x number
---@return number
---@nodiscard
function cryptography.bnot(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  return ~x
end

---***SRG Custom Function***
---
---Performs bitwise OR operation between `a` and `b`
---@param a number
---@param b number
---@return number
---@nodiscard
function cryptography.bor(a, b)
  if type(a) ~= "number" then errorMsg("Number", "a", a) end
  if type(b) ~= "number" then errorMsg("Number", "b", b) end

  return a | b
end

---***SRG Custom Function***
---
---Performs bitwise SWAP operation on `x`
---@param x number
---@return number
---@nodiscard
function cryptography.bswap(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) | ((x & 0xFF0000) >> 8) | ((x >> 24) & 0xFF)
end

function cryptography.rshift(x, amount)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(amount) ~= "number" then errorMsg("Number", "amount", amount) end

  return x >> amount
end

function cryptography.lshift(x, amount)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(amount) ~= "number" then errorMsg("Number", "amount", amount) end

  return x << amount
end

function cryptography.rol(x, amount)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(amount) ~= "number" then errorMsg("Number", "amount", amount) end

  return ((x << amount) | (x >> (32 - amount))) & 0xFFFFFFFF
end

function cryptography.ror(x, amount)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(amount) ~= "number" then errorMsg("Number", "amount", amount) end

  return ((x >> amount) | (x << (32 - amount))) & 0xFFFFFFFF
end

function cryptography.number_to_bit(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  return x & 0xFFFFFFFF
end

function cryptography.number_to_hex(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  return string.format("%x", x & 0xFFFFFFFF)
end

bit3

---***SRG Custom Function***
---
---Performs XOR encryption/decryption on a string (`s`) using a key (`key`)
---Note: XOR is symmetric - use the same key to decrypt
---@param s string
---@param key string
---@return string
---@nodiscard
function cryptography.xor(s, key)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if type(key) ~= "string" then error("String expected for 'key', given: " .. type(key)) end

  local encrypted = ""

  for i = 1, #s do
    local charByte = string.byte(s:sub(i, i))
    local keyByte = string.byte(key:sub((i - 1) % #key + 1, (i - 1) % #key + 1))
    local encryptedByte = cryptography.bxor(charByte, keyByte)
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
  if type(shift) ~= "number" then error("Number expected for 'shift', given: " .. type(shift)) end

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