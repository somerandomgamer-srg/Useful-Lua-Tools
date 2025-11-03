require("Useful Lua Tools")

print("Testing optimized base64 and base32 encoding with RFC 4648 test vectors...")
print("=" .. string.rep("=", 70))

-- RFC 4648 test vectors for base32
local rfc_tests = {
  {input = "", b64 = "", b32 = ""},
  {input = "f", b64 = "Zg==", b32 = "MY======"},
  {input = "fo", b64 = "Zm8=", b32 = "MZXQ===="},
  {input = "foo", b64 = "Zm9v", b32 = "MZXW6==="},
  {input = "foob", b64 = "Zm9vYg==", b32 = "MZXW6YQ="},
  {input = "fooba", b64 = "Zm9vYmE=", b32 = "MZXW6YTB"},
  {input = "foobar", b64 = "Zm9vYmFy", b32 = "MZXW6YTBOI======"}
}

local all_pass = true

for _, test in ipairs(rfc_tests) do
  local b64 = cryptography.text_to_base64(test.input)
  local b32 = cryptography.text_to_base32(test.input)
  
  local b64_match = b64 == test.b64
  local b32_match = b32 == test.b32
  
  print(string.format("\nInput: '%s'", test.input))
  print(string.format("  Base64: %s %s", b64, b64_match and "✓" or "✗ (expected: " .. test.b64 .. ")"))
  print(string.format("  Base32: %s %s", b32, b32_match and "✓" or "✗ (expected: " .. test.b32 .. ")"))
  
  if not b64_match or not b32_match then
    all_pass = false
  end
end

print("\n" .. string.rep("=", 70))
print(all_pass and "✓ All RFC 4648 tests PASSED!" or "✗ Some tests FAILED")
