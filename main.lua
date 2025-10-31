require("Useful Lua Tools")
local f = io.open("benchmark.txt", "w") or error("Failed to open file")

f:write("=== SHA256 Performance Benchmark - Regular vs Inlined ===\n\n")

local function benchmark_unique(description, base_input, iterations, hash_func, func_name)
    f:write(description .. " [" .. func_name .. "] - UNIQUE INPUTS (no cache)\n")
    f:write("  Base input length: " .. #base_input .. " bytes\n")
    f:write("  Iterations: " .. iterations .. "\n")

    local start_time = os.clock()
    for i = 1, iterations do
        _ = hash_func(base_input .. tostring(i))
    end
    local end_time = os.clock()

    local elapsed = end_time - start_time
    local per_hash = (elapsed / iterations) * 1000
    local hashes_per_sec = iterations / elapsed

    f:write("  Total time: " .. string.format("%.6f", elapsed) .. " seconds\n")
    f:write("  Time per hash: " .. string.format("%.6f", per_hash) .. " ms\n")
    f:write("  Throughput: " .. string.format("%.0f", hashes_per_sec) .. " hashes/second\n\n")

    return elapsed, hashes_per_sec
end

local function benchmark_cached(description, input, iterations, hash_func, func_name)
    f:write(description .. " [" .. func_name .. "] - CACHED (same input repeated)\n")
    f:write("  Input length: " .. #input .. " bytes\n")
    f:write("  Iterations: " .. iterations .. "\n")

    _ = hash_func(input)

    local start_time = os.clock()
    for _ = 1, iterations do
        _ = hash_func(input)
    end
    local end_time = os.clock()

    local elapsed = end_time - start_time
    if elapsed == 0 then
        f:write("  Total time: <0.000001 seconds (too fast to measure accurately)\n")
        f:write("  Estimated throughput: >100,000,000 hashes/second\n\n")
    else
        local per_hash = (elapsed / iterations) * 1000
        local hashes_per_sec = iterations / elapsed
        f:write("  Total time: " .. string.format("%.6f", elapsed) .. " seconds\n")
        f:write("  Time per hash: " .. string.format("%.6f", per_hash) .. " ms\n")
        f:write("  Throughput: " .. string.format("%.0f", hashes_per_sec) .. " hashes/second\n\n")
    end
end

local function run_test_suite(hash_func, func_name)
    f:write("\n" .. string.rep("=", 70) .. "\n")
    f:write("Testing: " .. func_name .. "\n")
    f:write(string.rep("=", 70) .. "\n\n")

    f:write("--- UNIQUE INPUT TESTS (Cache Misses) ---\n\n")
    
    benchmark_unique("Test 1: Empty string + counter", "", 10000, hash_func, func_name)
    benchmark_unique("Test 2: Short string + counter", "abc", 10000, hash_func, func_name)
    benchmark_unique("Test 3: Medium string + counter", "The quick brown fox jumps over the lazy dog.", 10000, hash_func, func_name)
    
    local long_str = string.rep("a", 100)
    benchmark_unique("Test 4: Long string + counter", long_str, 5000, hash_func, func_name)
    
    local block_str = string.rep("x", 55)
    benchmark_unique("Test 5: Exactly 1 block + counter", block_str, 10000, hash_func, func_name)
    
    local two_block_str = string.rep("y", 56)
    benchmark_unique("Test 6: Just over 1 block + counter", two_block_str, 10000, hash_func, func_name)

    f:write("\n--- CACHED INPUT TESTS (Cache Hits) ---\n\n")
    
    benchmark_cached("Test 7: Cached empty string", "", 1000000, hash_func, func_name)
    benchmark_cached("Test 8: Cached short string", "abc", 1000000, hash_func, func_name)
    benchmark_cached("Test 9: Cached medium string", "The quick brown fox jumps over the lazy dog.", 1000000, hash_func, func_name)
end

run_test_suite(cryptography.sha256, "cryptography.sha256 (Regular)")

f:write("\n" .. string.rep("=", 70) .. "\n")
f:write("Benchmark Complete\n")
f:write(string.rep("=", 70) .. "\n\n")
f:write("NOTES:\n")
f:write("- Unique input tests append a counter to force cache misses\n")
f:write("- Cached tests repeat the same input to measure cache performance\n")
f:write("- SHA-256 processes data in 512-bit (64-byte) blocks\n")
f:write("- The inlined version sacrifices readability for raw performance\n")

f:close()
print("Benchmark results written to benchmark.txt")
