require("Useful Lua Tools")

local time, timePer, result = benchmark(function() return 1 + 10 end, 1000)

print("Total Time: " .. time)
print("Average Time Per Run: " .. timePer)
print("Last Result: " ..  result)

