require("Useful Lua Tools")

print("Testing optimized base64 and base32 encoding...")
print("=" .. string.rep("=", 50))

local tests = {
  "",
  "a",
  "ab",
  "abc",
  "Hello, World!",
  "The quick brown fox jumps over the lazy dog"
}

for _, test in ipairs(tests) do
  local b64 = cryptography.text_to_base64(test)
  local b32 = cryptography.text_to_base32(test)
  
  print(string.format("\nInput: '%s' (len=%d)", test, #test))
  print(string.format("Base64: %s", b64))
  print(string.format("Base32: %s", b32))
end

print("\n" .. string.rep("=", 50))
print("All tests completed!")
