-- Useful Lua Tools Library Demo
require("Useful Lua Tools")

print("Useful Lua Tools v" .. ult.version .. " loaded successfully!")
print("Build:", ult.build)
print("Contributors:", table.concat(ult.contributors, ", "))

-- Test updated bitwise operations
print("\nTesting updated bitwise operations:")
print("- bswap(0x12345678):", string.format("0x%08X", cryptography.bswap(0x12345678)))
print("- rol(0xF0F0F0F0, 4):", string.format("0x%08X", cryptography.rol(0xF0F0F0F0, 4)))
print("- ror(0xF0F0F0F0, 4):", string.format("0x%08X", cryptography.ror(0xF0F0F0F0, 4)))
print("- btest(15, 8):", cryptography.btest(15, 8))
print("- extract(255, 4, 4):", cryptography.extract(255, 4, 4))
print("- number_to_bit(15):", cryptography.number_to_bit(15))

-- Test other functions
print("\nOther functions:")
print("- Random UUID4:", random.uuid(4))
print("- Caesar cipher 'test':", cryptography.caesar_cipher("test", 5))
print("- Split 'a,b,c':", table.concat(string.split("a,b,c", ","), " | "))
print("\nLibrary ready for use! Now using native Lua 5.3+ bitwise operators.")