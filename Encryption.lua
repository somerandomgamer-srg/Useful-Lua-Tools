local hexTable = {}
local binaryTable = {}

for i = 32, 126 do 
  local char = string.char(i)
  local hex = string.format("%02X", i)
  local binary = string.format("%08b", i)
  hexTable[char] = hex
  binaryTable[char] = binary
end

encryption = {}

---***SRG Custom Function***
---
---Converts a string (`s`) from plaintext to ascii
---@param s string
---@return string
---@nodiscard
function encryption.to_ascii(s)
  local asciiCode = ""
  for i in s do asciiCode = asciiCode .. s[i]:byte() .. " " end
  return asciiCode
end

---***SRG Custom Function***
---
---Converts a string (`s`) from plaintext to hexadecimal
---@param s string
---@return string
---@nodiscard
function encryption.to_hex(s)
  local hexCode = ""
  for i in s do
    if hexTable[i] then hexCode = hexCode .. hexTable[i] end
  end
  return hexCode
end

---***SRG Custom Function***
---
---Converts a string (`s`) from plaintext to binary
---@param s string
---@return string
---@nodiscard
function encryption.to_binary(s)
  local binaryCode = ""
  for i in s do
    if binaryTable[i] then binaryCode = binaryCode .. binaryTable[i] .. " " end
  end
  return binaryCode
end

