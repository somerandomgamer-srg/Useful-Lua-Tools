-- Test script for Useful Lua Tools
require("Useful Lua Tools")

print("=== Testing Useful Lua Tools ===")

-- Test basic functionality
print("\n--- Testing ULT version ---")
print("Version:", ult.version)
print("Build:", ult.build)

-- Test fixed functions
print("\n--- Testing Fixed Functions ---")

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