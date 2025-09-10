-- Useful Lua Tools Library Demo
require("Useful Lua Tools")

print("Useful Lua Tools v" .. ult.version .. " loaded successfully!")
print("Build:", ult.build)
print("Contributors:", table.concat(ult.contributors, ", "))

-- Quick functionality test
print("\nQuick test:")
print("- Random UUID4:", random.uuid(4))
print("- Caesar cipher 'test':", cryptography.caesar_cipher("test", 5))
print("- Split 'a,b,c':", table.concat(string.split("a,b,c", ","), " | "))
print("\nLibrary ready for use!")