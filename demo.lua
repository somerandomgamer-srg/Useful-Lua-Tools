-- Demo script for Useful Lua Tools
require("Useful Lua Tools")

print("=== Useful Lua Tools Demo ===")
print("Version:", ult.version)
print("Build:", ult.build)
print("")

-- Test random functions
print("Testing Random Library Functions:")
print("UUID v4:", random.uuid(4))
print("Random sign of 5:", random.sign(5))
print("Random number (1-10, 2 decimals):", random.number(1, 10, 2))

-- Test random.choice with a simple table
local test_table = {"apple", "banana", "cherry", "date"}
print("Random choice from fruits:", random.choice(test_table))

print("")
print("Demo complete!")