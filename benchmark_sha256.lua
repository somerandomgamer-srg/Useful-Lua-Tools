require("Useful Lua Tools")

print("=== SHA256 Benchmark ===\n")

-- Test different input sizes
local test_cases = {
  {name = "Short string (10 chars)", data = "HelloWorld"},
  {name = "Medium string (100 chars)", data = string.rep("a", 100)},
  {name = "Long string (1000 chars)", data = string.rep("b", 1000)},
  {name = "Very long string (10000 chars)", data = string.rep("c", 10000)},
}

for _, test in ipairs(test_cases) do
  print("Testing: " .. test.name)
  
  -- Benchmark with 100 iterations
  local total_time, avg_time, result = benchmark(function()
    return cryptography.sha256(test.data)
  end, 100)
  
  print("  SHA256 Hash: " .. result)
  print("  Total time (100 runs): " .. string.format("%.6f", total_time) .. " seconds")
  print("  Average time per run: " .. string.format("%.6f", avg_time) .. " seconds")
  print("  Operations per second: " .. string.format("%.2f", 1/avg_time) .. " ops/sec")
  print()
end

print("=== Single Execution Time Test ===\n")
local test_string = "The quick brown fox jumps over the lazy dog"
local exec_time, hash = execution_time(function()
  return cryptography.sha256(test_string)
end)

print("Input: \"" .. test_string .. "\"")
print("SHA256: " .. hash)
print("Execution time: " .. string.format("%.6f", exec_time) .. " seconds")
print("\nBenchmark complete!")
