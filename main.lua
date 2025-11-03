require("Useful Lua Tools")

local str = "test input string"
local total, timePer, result = benchmark(cryptography.text_to_base64, 10000, str)

print("base64 encode")
print(string.format("Total time: %.9f", total))
print(string.format("Average time per run: %.9f", timePer))
print("Last result: " ..  result)

total, timePer, result = benchmark(cryptography.base64_to_text, 10000, result)

print("\nbase64 decode")
print(string.format("Total time: %.9f", total))
print(string.format("Average time per run: %.9f", timePer))
print("Last result: " ..  result)

total, timePer, result = benchmark(cryptography.text_to_base58, 10000, str)

print("\nbase58 encode")
print(string.format("Total time: %.9f", total))
print(string.format("Average time per run: %.9f", timePer))
print("Last result: " ..  result)

total, timePer, result = benchmark(cryptography.base58_to_text, 10000,  result)

print("\nbase58 decode")
print(string.format("Total time: %.9f", total))
print(string.format("Average time per run: %.9f", timePer))
print("Last result: " ..  result)

total, timePer, result = benchmark(cryptography.text_to_base32, 10000, str)

print("\nbase32 encode")
print(string.format("Total time: %.9f", total))
print(string.format("Average time per run: %.9f", timePer))
print("Last result: " ..  result)

total, timePer, result = benchmark(cryptography.base32_to_text, 10000,  result)

print("\nbase32 decode")
print(string.format("Total time: %.9f", total))
print(string.format("Average time per run: %.9f", timePer))
print("Last result: " ..  result)