require("Useful Lua Tools")

local str = "test input string"
local total, timePer, result = benchmark(cryptography.text_to_base64, 10000, str)

print(string.format("Total time: %.9f", total))
print(string.format("Average time per run: %.9f", timePer))
print("Last result: " ..  result)

total, timePer, result = benchmark(cryptography.text_to_base58, 10000, str)

print(string.format("Total time: %.9f", total))
print(string.format("Average time per run: %.9f", timePer))
print("Last result: " ..  result)

total, timePer, result = benchmark(cryptography.text_to_base32, 10000, str)

print(string.format("Total time: %.9f", total))
print(string.format("Average time per run: %.9f", timePer))
print("Last result: " ..  result)