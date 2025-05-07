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