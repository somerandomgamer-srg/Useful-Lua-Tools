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

---***SRG Custom Function***
---
---Performs ROT13 encryption/decryption on a string
---@param s string
---@return string
---@nodiscard
function encryption.rot13(s)
  return s:gsub('[A-Za-z]', function(c)
    local base = c <= 'Z' and 65 or 97
    return string.char(((c:byte() - base + 13) % 26) + base)
  end)
end

---***SRG Custom Function***
---
---Simple XOR encryption/decryption with a key
---@param s string
---@param key string
---@return string
---@nodiscard
function encryption.xor(s, key)
  local result = {}
  for i = 1, #s do
    local keyByte = key:byte((i-1) % #key + 1)
    result[i] = string.char(bit32.bxor(s:byte(i), keyByte))
  end
  return table.concat(result)
end

---***SRG Custom Function***
---
---Base64 encoding
---@param s string
---@return string
---@nodiscard
function encryption.base64_encode(s)
  local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  return ((s:gsub('.', function(x) 
    local r,b='',x:byte()
    for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
    return r
  end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
    if (#x < 6) then return '' end
    local c=0
    for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
    return b:sub(c+1,c+1)
  end)..({ '', '==', '=' })[#s%3+1])
end

---***SRG Custom Function***
---
---Vigenère cipher encryption
---@param s string
---@param key string
---@return string
---@nodiscard
function encryption.vigenere_encrypt(s, key)
  local result = {}
  for i = 1, #s do
    local c = s:byte(i)
    if c >= 65 and c <= 90 then
      local shift = key:byte((i-1) % #key + 1) - 65
      result[i] = string.char(((c - 65 + shift) % 26) + 65)
    elseif c >= 97 and c <= 122 then
      local shift = key:byte((i-1) % #key + 1) - 97
      result[i] = string.char(((c - 97 + shift) % 26) + 97)
    else
      result[i] = s:sub(i,i)
    end
  end
  return table.concat(result)
end

return encryption

