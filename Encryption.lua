encryption = {}

---***SRG Custom Function***
---
---Converts a string (`s`) to ascii
---@param s string
---@return string
---@nodiscard
function encryption.ascii(s)
  local asciiCode = ""
  for i in #s do asciiCode = asciiCode .. s[i]:byte() .. " " end
  return asciiCode
end

