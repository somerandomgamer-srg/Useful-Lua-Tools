-- Test script for Useful Lua Tools
require("Useful Lua Tools")

print("=== Testing Useful Lua Tools ===")

-- Test basic functionality
print("\n--- Testing ULT version ---")
print("Version:", ult.version)
print("Build:", ult.build)

-- Test UUID generation thoroughly
print("\n--- Testing UUID Generation ---")

-- Test UUID4 (should be random, proper format)
print("Testing UUID4...")
for i = 1, 3 do
  local uuid4_result = random.uuid(4)
  print("UUID4 #" .. i .. ":", uuid4_result)
  
  -- Validate format: xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
  local pattern = "^%x%x%x%x%x%x%x%x%-%x%x%x%x%-4%x%x%x%-[89ab]%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$"
  if uuid4_result:match(pattern) then
    print("  ✓ Valid UUID4 format")
  else
    print("  ✗ Invalid UUID4 format")
  end
end

-- Test UUID1 (time-based with MAC)
print("\nTesting UUID1...")
for i = 1, 3 do
  local uuid1_result = random.uuid(1)
  print("UUID1 #" .. i .. ":", uuid1_result)
  
  -- Validate format and version field
  if uuid1_result:match("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-1%x%x%x%-[89ab]%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
    print("  ✓ Valid UUID1 format")
  else
    print("  ✗ Invalid UUID1 format")
  end
end

-- Test UUID6 (time-based, reordered)
print("\nTesting UUID6...")
for i = 1, 3 do
  local uuid6_result = random.uuid(6)
  print("UUID6 #" .. i .. ":", uuid6_result)
  
  -- Validate format and version field
  if uuid6_result:match("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-6%x%x%x%-[89ab]%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
    print("  ✓ Valid UUID6 format")
  else
    print("  ✗ Invalid UUID6 format")
  end
end

-- Test fixed functions
print("\n--- Testing Other Fixed Functions ---")

-- Test random.choice
print("Testing random.choice...")
local test_table = {"apple", "banana", "cherry", "date"}
local single_choice = random.choice(test_table)
print("Single choice:", single_choice)

local multiple_choices = random.choice(test_table, 2)
print("Multiple choices:", table.concat(multiple_choices or {}, ", "))

-- Test string.split
print("\nTesting string.split...")
local split_result = string.split("hello,world,test", ",")
print("Split result:", table.concat(split_result, " | "))

-- Test string functions
print("\nTesting string functions...")
print("starts_with 'hello' and 'h':", string.starts_with("hello", "h"))
print("ends_with 'hello' and 'o':", string.ends_with("hello", "o"))

-- Test random.hex
print("\nTesting random.hex...")
print("Random hex (8 chars):", random.hex(8))

-- Test caesar cipher
print("\nTesting Caesar cipher...")
local encrypted = cryptography.caesar_cipher("hello", 3)
print("Encrypted 'hello' with shift 3:", encrypted)
local decrypted = cryptography.caesar_cipher(encrypted, -3)
print("Decrypted back:", decrypted)

print("\n=== All tests completed ===")