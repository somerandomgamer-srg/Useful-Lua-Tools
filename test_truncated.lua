require("Useful Lua Tools")

local function testTruncated(name, decoder, input)
  print(string.format("Testing %s with truncated input: %q (length: %d)", name, input, #input))
  local success, err = pcall(decoder, input)
  if success then
    print("  ✗ FAIL: Should have raised an error but succeeded")
  else
    print("  ✓ PASS: Correctly raised error: " .. err)
  end
end

print("=== Testing Truncated Input Handling ===\n")

-- Base64 truncated inputs (invalid lengths after padding removal)
-- Valid lengths mod 4: 0, 2, 3 (not 1)
testTruncated("base64_to_text", cryptography.base64_to_text, "A")      -- length 1 mod 4 = 1 (invalid)
testTruncated("base64_to_text", cryptography.base64_to_text, "ABCDE") -- length 5 mod 4 = 1 (invalid)

-- Base32 truncated inputs (invalid lengths after padding removal)
-- Valid lengths mod 8: 0, 2, 4, 5, 7 (not 1, 3, 6)
testTruncated("base32_to_text", cryptography.base32_to_text, "A")       -- length 1 mod 8 = 1 (invalid)
testTruncated("base32_to_text", cryptography.base32_to_text, "ABC")     -- length 3 mod 8 = 3 (invalid)
testTruncated("base32_to_text", cryptography.base32_to_text, "ABCDEF") -- length 6 mod 8 = 6 (invalid)

-- Valid truncated inputs (should work)
print("\n=== Testing Valid Truncated Inputs (should succeed) ===\n")

local function testValidTruncated(name, encoder, decoder, input)
  print(string.format("Testing %s with: %q", name, input))
  local encoded = encoder(input)
  local encodedNoPadding = encoded:gsub("=", "")  -- Remove padding
  local decoded = decoder(encodedNoPadding)
  if decoded == input then
    print(string.format("  ✓ PASS: %q -> %q -> %q", input, encoded, decoded))
  else
    print(string.format("  ✗ FAIL: Expected %q but got %q", input, decoded))
  end
end

-- Base64 valid partial groups
testValidTruncated("base64", cryptography.text_to_base64, cryptography.base64_to_text, "a")    -- 2 chars after padding removal
testValidTruncated("base64", cryptography.text_to_base64, cryptography.base64_to_text, "ab")   -- 3 chars after padding removal
testValidTruncated("base64", cryptography.text_to_base64, cryptography.base64_to_text, "abc")  -- 4 chars (full group)

-- Base32 valid partial groups
testValidTruncated("base32", cryptography.text_to_base32, cryptography.base32_to_text, "a")    -- 2 chars after padding removal
testValidTruncated("base32", cryptography.text_to_base32, cryptography.base32_to_text, "ab")   -- 4 chars after padding removal
testValidTruncated("base32", cryptography.text_to_base32, cryptography.base32_to_text, "abc")  -- 5 chars after padding removal
testValidTruncated("base32", cryptography.text_to_base32, cryptography.base32_to_text, "abcd") -- 7 chars after padding removal

print("\n=== All truncated input tests completed ===")
