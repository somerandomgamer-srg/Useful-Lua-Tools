require("Useful Lua Tools")

print("Your 6-bit binary string:")
local binary = "010101001101101010010101000101000010111111000111000010010101010001010101010100111101000000"
print(binary)
print("\nDecoded to text (with non-printable chars):")
print(cryptography.binary_to_text(binary, 6))
print("\nDecoded to decimal values:")
for i = 1, #binary, 6 do
  local chunk = binary:sub(i, i + 5)
  local value = tonumber(chunk, 2)
  local char = value >= 32 and value <= 126 and string.char(value) or "."
  print(string.format("  %s = %2d (char: '%s')", chunk, value, char))
end