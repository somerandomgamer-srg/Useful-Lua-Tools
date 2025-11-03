require("Useful Lua Tools")

local function testMalformedPadding(name, decoder, input, expectedError)
  print(string.format("Testing %s with malformed padding: %q", name, input))
  local success, err = pcall(decoder, input)
  if success then
    print("  ✗ FAIL: Should have raised an error but succeeded")
  else
    if err:match(expectedError) then
      print("  ✓ PASS: Correctly raised error: " .. err)
    else
      print("  ✗ FAIL: Wrong error. Expected pattern: " .. expectedError)
      print("       Got: " .. err)
    end
  end
end

print("=== Testing Malformed Padding ===\n")

-- Base64 malformed padding
print("--- Base64 Padding Validation ---")
testMalformedPadding("base64_to_text", cryptography.base64_to_text, "A=BC", "padding character in non%-terminal position")
testMalformedPadding("base64_to_text", cryptography.base64_to_text, "AB==CD", "padding character in non%-terminal position")
testMalformedPadding("base64_to_text", cryptography.base64_to_text, "AB=C", "padding character in non%-terminal position")
testMalformedPadding("base64_to_text", cryptography.base64_to_text, "ABC=DEF", "padding character in non%-terminal position")
testMalformedPadding("base64_to_text", cryptography.base64_to_text, "ABCD===", "too many padding characters")
testMalformedPadding("base64_to_text", cryptography.base64_to_text, "ABCD====", "too many padding characters")
testMalformedPadding("base64_to_text", cryptography.base64_to_text, "=", "padding character")
testMalformedPadding("base64_to_text", cryptography.base64_to_text, "==", "padding character")
testMalformedPadding("base64_to_text", cryptography.base64_to_text, "A=", "1 padding character requires 3")
testMalformedPadding("base64_to_text", cryptography.base64_to_text, "ABCDE=", "1 padding character requires 3")

-- Base32 malformed padding
print("\n--- Base32 Padding Validation ---")
testMalformedPadding("base32_to_text", cryptography.base32_to_text, "A=BC", "padding character in non%-terminal position")
testMalformedPadding("base32_to_text", cryptography.base32_to_text, "AB==CD==", "padding character in non%-terminal position")
testMalformedPadding("base32_to_text", cryptography.base32_to_text, "ABCDEFG=H", "padding character in non%-terminal position")
testMalformedPadding("base32_to_text", cryptography.base32_to_text, "ABCDEFGH=======", "too many padding characters")
testMalformedPadding("base32_to_text", cryptography.base32_to_text, "ABCDEFGH========", "too many padding characters")
testMalformedPadding("base32_to_text", cryptography.base32_to_text, "=", "padding without payload")
testMalformedPadding("base32_to_text", cryptography.base32_to_text, "======", "padding without payload")
testMalformedPadding("base32_to_text", cryptography.base32_to_text, "A======", "6 padding characters require 2")
testMalformedPadding("base32_to_text", cryptography.base32_to_text, "ABCD===", "3 padding characters require 5")
testMalformedPadding("base32_to_text", cryptography.base32_to_text, "AB==", "2 padding characters not allowed")

-- Valid padding should still work
print("\n--- Valid Padding (should succeed) ---")

local function testValidPadding(name, encoder, decoder, input)
  print(string.format("Testing %s with: %q", name, input))
  local encoded = encoder(input)
  local decoded = decoder(encoded)
  if decoded == input then
    print(string.format("  ✓ PASS: %q -> %q -> %q", input, encoded, decoded))
  else
    print(string.format("  ✗ FAIL: Expected %q but got %q", input, decoded))
  end
end

testValidPadding("base64", cryptography.text_to_base64, cryptography.base64_to_text, "a")
testValidPadding("base64", cryptography.text_to_base64, cryptography.base64_to_text, "ab")
testValidPadding("base64", cryptography.text_to_base64, cryptography.base64_to_text, "abc")
testValidPadding("base32", cryptography.text_to_base32, cryptography.base32_to_text, "a")
testValidPadding("base32", cryptography.text_to_base32, cryptography.base32_to_text, "ab")
testValidPadding("base32", cryptography.text_to_base32, cryptography.base32_to_text, "abcde")

print("\n=== All padding tests completed ===")
