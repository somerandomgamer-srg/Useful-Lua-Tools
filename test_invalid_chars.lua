require("Useful Lua Tools")

local function testInvalid(name, decoder, input)
  print(string.format("Testing %s with invalid input: %q", name, input))
  local success, err = pcall(decoder, input)
  if success then
    print("  ✗ FAIL: Should have raised an error but succeeded")
  else
    print("  ✓ PASS: Correctly raised error: " .. err)
  end
end

print("=== Testing Invalid Character Handling ===\n")

-- Base64 invalid characters
testInvalid("base64_to_text", cryptography.base64_to_text, "ABCD$EFG")
testInvalid("base64_to_text", cryptography.base64_to_text, "!!!!")
testInvalid("base64_to_text", cryptography.base64_to_text, "ABC@")

-- Base32 invalid characters
testInvalid("base32_to_text", cryptography.base32_to_text, "ABCD1EFG")  -- '1' not in base32 alphabet
testInvalid("base32_to_text", cryptography.base32_to_text, "abcd")      -- lowercase not in default alphabet
testInvalid("base32_to_text", cryptography.base32_to_text, "ABCD@EFG")

-- Base58 invalid characters
testInvalid("base58_to_text", cryptography.base58_to_text, "ABC0DEF")  -- '0' not in base58 alphabet
testInvalid("base58_to_text", cryptography.base58_to_text, "ABCODEF")  -- 'O' not in base58 alphabet
testInvalid("base58_to_text", cryptography.base58_to_text, "ABClDEF")  -- 'l' not in base58 alphabet

print("\n=== All invalid character tests completed ===")
