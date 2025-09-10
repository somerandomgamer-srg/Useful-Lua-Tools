-- Useful Lua Tools Library Demo
require("Useful Lua Tools")

print("Useful Lua Tools v" .. ult.version .. " loaded successfully!")
print("Build:", ult.build)
print("Contributors:", table.concat(ult.contributors, ", "))

-- Test updated native bitwise operations (Lua 5.3+)
print("\nTesting native bitwise operations:")
print("- bswap(0x12345678):", string.format("0x%08X", cryptography.bswap(0x12345678)))
print("- rol(0xF0F0F0F0, 4):", string.format("0x%08X", cryptography.rol(0xF0F0F0F0, 4)))
print("- ror(0xF0F0F0F0, 4):", string.format("0x%08X", cryptography.ror(0xF0F0F0F0, 4)))
print("- btest(15, 8):", cryptography.btest(15, 8))
print("- extract(255, 4, 4):", cryptography.extract(255, 4, 4))
print("- replace(255, 0, 4, 4):", cryptography.replace(255, 0, 4, 4))
print("- number_to_bit(15):", cryptography.number_to_bit(15))

-- Test other functions
print("\nOther functions:")
print("- Random UUID4:", random.uuid(4))
print("- Caesar cipher 'test':", cryptography.caesar_cipher("test", 5))
print("- Split 'a,b,c':", table.concat(string.split("a,b,c", ","), " | "))

-- Test new remote and table functions
print("\nTesting new annotated functions:")
print("- table.index([1,2,3,4], 3):", table.index({1,2,3,4}, 3))
print("- table.index([1,2,3,4], 5):", table.index({1,2,3,4}, 5) or "nil")

-- Test remote library with multiple function registration
local test_results = {}
remote.register("demo", function() table.insert(test_results, "Function 1 called") end)
remote.register("demo", function() table.insert(test_results, "Function 2 called") end)
print("- remote.exists('demo'):", remote.exists("demo"))
print("- remote.count('demo'):", remote.count("demo"))
remote.call("demo")
print("- Remote call results:", table.concat(test_results, ", "))

print("\n✅ Library ready! Now using native Lua " .. _VERSION .. " bitwise operators (&, |, <<, >>).")
print("📋 All new annotations added and documentation updated!")