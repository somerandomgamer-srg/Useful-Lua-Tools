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
  return string.trim(asciiCode)
end

---***SRG Custom Function***
---
---Converts a string (`s`) from plaintext to hexadecimal
---@param s string
---@return string
---@nodiscard
function text_to_hex(s)
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
function encryption.to_binary(s)
  local binaryCode = ""
  for i = 1, #s do
    local charCode = string.byte(s, i)
    local binary = string.format("%08b", charCode)
    binaryCode = binaryCode .. binary .. " "
  end
  return string.trim(binaryCode)
end

function encryption.from_ascii(s)
  local text = ""
  for ascii in string.split(s, " ") do text = text .. string.char(tonumber(ascii)) end
  return text
end

---Converts a string (`s`) from hexadecimal to plaintext
function encryption.from_hex(s)
  local text = ""
  for hexPair in s:gmatch("%x%x") do
    local char = string.char(tonumber(hexPair, 16))
    text = text .. char
  end
  return text
end

function encryption.from_binary(s)
  local text = ""
  for binary in s:gmatch("%S+") do
      local ascii = tonumber(binary, 2)
      text = text .. string.char(ascii)
  end
  return text
end
