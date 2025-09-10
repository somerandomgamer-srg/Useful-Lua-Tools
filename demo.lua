-- Demo script for Useful Lua Tools - Testing New Random Functions
require("Useful Lua Tools")

print("=== Useful Lua Tools - Random Library Demo ===")
print("Version:", ult.version)
print("")

-- Test all random functions
print("Testing Random Library Functions:")
print("UUID v4:", random.uuid(4))
print("Random sign of 5:", random.sign(5))
print("Random number (1-10, 2 decimals):", random.number(1, 10, 2))

local test_table = {"apple", "banana", "cherry", "date"}
print("Random choice from fruits:", random.choice(test_table))

-- Test new random functions
print("Random hex string (8 chars):", random.hex(8))
print("Random boolean:", random.boolean())
print("Random string (10 chars):", random.string(10))
print("Random string (5 chars, custom charset):", random.string(5, "ABC123"))

print("")
print("Demo complete!")