require("Useful Lua Tools")

local total, timePer, result  = benchmark(cryptography.text_to_base58, 10000, "test input")
print(string.format("Total Time: %.9f", total))
print(string.format("Average Time Per Run: %.9f", timePer))
print("Last Result: " .. tostring(result))