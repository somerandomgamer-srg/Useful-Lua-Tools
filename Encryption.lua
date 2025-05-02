local morseCodeTable = {
  a=".-", b="-...", c="-.-.", d="-..", e=".", f="..-.", g="--.", h="....", i="..", j=".---", k="-.-",
  l=".-..", m="--", n="-.", o="---", p=".--.", q="--.-", r=".-.", s="...", t="-", u="..-", v="...-",
  w=".--", x="-..-", y="-.--", z="--..", ["1"]=".----", ["2"]="..---", ["3"]="...--", ["4"]="....-",
  ["5"]=".....", ["6"]="-....", ["7"]="--...", ["8"]="---..", ["9"]="----.", ["0"]="-----",
  [" "] = " / ", ["!"]="-.-.--", ["@"]=".--.-.", ["&"]=".-...", ["("]="-.--.", [")"]="-.--.-",
  ["-"]="-....-", ["="]="-...-", ["+"]=".-.-.", [":"]="---...". ["'"]=".----.", ['"']=".-..-.",
  [","]="--..--" ["."]=".-.-.-", ["/"]="-..-.", ["?"]="..--.."
}

encryption = {}

---***SRG Custom Function***
---
---Converts a string (`s`) from plaintext to ascii
---@param s string
---@return string
---@nodiscard
function encryption.text_to_ascii(s)
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
function encryption.text_to_hex(s)
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
function encryption.text_to_binary(s)
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
---Converts a string (`s`) from plaintext to morse code
---@param s string
---@return string
---@nodiscard
function encryption.text_to_morse(s)
  local text = ""
  for i = 1, #s do
    local char = s[i]
    if morseCodeTable[char] then text = text .. morseCodeTable[char] .. " " end
  end
  return string.trim(text)
end