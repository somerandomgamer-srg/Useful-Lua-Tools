require("Useful Lua Tools")

print("SHA256 Benchmark Test")
print("=====================\n")

local test_string = "The quick brown fox jumps over the lazy dog"
print("Input: " .. test_string)

local start_time = os.clock()
local result = cryptography.sha256(test_string)
local end_time = os.clock()

print("SHA256: " .. result)
print("Time: " .. string.format("%.6f", (end_time - start_time) * 1000) .. " ms")

print("\n" .. "Large string benchmark (10,000 iterations)")
local large_string = string.rep("a", 1000)
start_time = os.clock()
for i = 1, 10000 do
  cryptography.sha256(large_string)
end
end_time = os.clock()

print("Time for 10,000 iterations: " .. string.format("%.3f", (end_time - start_time)) .. " seconds")
print("Average time per hash: " .. string.format("%.6f", ((end_time - start_time) / 10000) * 1000) .. " ms")
