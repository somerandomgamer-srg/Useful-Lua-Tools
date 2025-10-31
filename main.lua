require("Useful Lua Tools")
local f = io.open("benchmark.txt", "w") or error("Failed to open file")

f:write("=== SHA256 Performance Benchmark - Regular vs Inlined ===\n\n")

local function benchmark(description, input, iterations, hash_func, func_name)
    f:write(description .. " [" .. func_name .. "]\n")
    f:write("  Input length: " .. #input .. " bytes\n")
    f:write("  Iterations: " .. iterations .. "\n")

    local start_time = os.clock()
    for _ = 1, iterations do
        _ = hash_func(input)
    end
    local end_time = os.clock()

    local elapsed = end_time - start_time
    local per_hash = (elapsed / iterations) * 1000
    local hashes_per_sec = iterations / elapsed

    f:write("  Total time: " .. string.format("%.9f", elapsed) .. " seconds\n")
    f:write("  Time per hash: " .. string.format("%.9f", per_hash) .. " ms\n")
    f:write("  Throughput: " .. string.format("%.0f", hashes_per_sec) .. " hashes/second\n\n")

    return elapsed, hashes_per_sec
end

local function run_test_suite(hash_func, func_name)
    f:write("\n" .. string.rep("=", 60) .. "\n")
    f:write("Testing: " .. func_name .. "\n")
    f:write(string.rep("=", 60) .. "\n\n")

    benchmark("Test 1: Empty string", "", 10000, hash_func, func_name)
    benchmark("Test 2: Short string (3 bytes)", "abc", 10000, hash_func, func_name)
    benchmark("Test 3: Medium string (44 bytes)", "The quick brown fox jumps over the lazy dog.", 10000, hash_func, func_name)
    
    local long_str = string.rep("a", 100)
    benchmark("Test 4: Long string (100 bytes)", long_str, 5000, hash_func, func_name)
    
    local very_long_str = string.rep("Lorem ipsum dolor sit amet, consectetur adipiscing elit. ", 10)
    benchmark("Test 5: Very long string (" .. #very_long_str .. " bytes)", very_long_str, 2000, hash_func, func_name)
    
    local block_str = string.rep("x", 55)
    benchmark("Test 6: Exactly 1 block (55 bytes)", block_str, 10000, hash_func, func_name)
    
    local two_block_str = string.rep("y", 56)
    benchmark("Test 7: Just over 1 block (56 bytes)", two_block_str, 10000, hash_func, func_name)
end

run_test_suite(cryptography.sha256, "cryptography.sha256 (Regular)")
run_test_suite(cryptography.sha256_inlined, "cryptography.sha256_inlined (Inlined)")

f:write("\n" .. string.rep("=", 60) .. "\n")
f:write("Benchmark Complete\n")
f:write(string.rep("=", 60) .. "\n\n")
f:write("Note: Performance varies based on input length and block boundaries.\n")
f:write("SHA-256 processes data in 512-bit (64-byte) blocks.\n")
f:write("\nThe inlined version removes function call overhead by directly\n")
f:write("inlining all helper functions (choose, maj, bsig0, bsig1, etc.).\n")

f:close()
print("Benchmark results written to benchmark.txt")
