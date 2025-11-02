require("Useful Lua Tools")

local str = "qtVqoQ/4QqiqKvA="
local bin = cryptography.text_to_binary(str, 7)
print(bin)

print(cryptography.binary_to_text(bin, 7))