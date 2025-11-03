require("Useful Lua Tools")

local function test(name, input)
  print(string.format("\n=== Testing: %s ===", name))
  print(string.format("Input: %q (length: %d)", input, #input))
  
  -- Base64 roundtrip
  local b64 = cryptography.text_to_base64(input)
  local b64_decoded = cryptography.base64_to_text(b64)
  print(string.format("Base64: %s -> %s", b64, b64_decoded == input and "✓" or "✗ FAIL"))
  if b64_decoded ~= input then
    print(string.format("  Expected: %q", input))
    print(string.format("  Got:      %q", b64_decoded))
  end
  
  -- Base32 roundtrip
  local b32 = cryptography.text_to_base32(input)
  local b32_decoded = cryptography.base32_to_text(b32)
  print(string.format("Base32: %s -> %s", b32, b32_decoded == input and "✓" or "✗ FAIL"))
  if b32_decoded ~= input then
    print(string.format("  Expected: %q", input))
    print(string.format("  Got:      %q", b32_decoded))
  end
  
  -- Base58 roundtrip
  local b58 = cryptography.text_to_base58(input)
  local b58_decoded = cryptography.base58_to_text(b58)
  print(string.format("Base58: %s -> %s", b58, b58_decoded == input and "✓" or "✗ FAIL"))
  if b58_decoded ~= input then
    print(string.format("  Expected: %q", input))
    print(string.format("  Got:      %q", b58_decoded))
  end
end

-- Test cases
test("Empty string", "")
test("Single char", "a")
test("Two chars", "ab")
test("Three chars", "abc")
test("Four chars", "abcd")
test("Five chars", "abcde")
test("RFC 4648 'f'", "f")
test("RFC 4648 'fo'", "fo")
test("RFC 4648 'foo'", "foo")
test("RFC 4648 'foob'", "foob")
test("RFC 4648 'fooba'", "fooba")
test("RFC 4648 'foobar'", "foobar")
test("Original test", "test input string")
test("With numbers", "Hello123World456")
test("Special chars", "!@#$%^&*()_+-=[]{}|;:',.<>?")
test("Unicode-like", string.char(0, 1, 2, 127, 128, 255))
test("Repeated pattern", string.rep("ABC", 10))
test("Long string", string.rep("x", 100))

print("\n=== All tests completed ===")
