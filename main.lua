require("Useful Lua Tools")
local f = io.open("benchmark.txt", "w") or error("Failed to open file")

f:write("=== SHA256 Performance Benchmark ===\n\n")

-- Benchmark function
local function benchmark(description, input, iterations)
    f:write(description .. "\n")
    f:write("  Input length: " .. #input .. " bytes\n")
    f:write("  Iterations: " .. iterations .. "\n")

    local start_time = os.clock()
    for _ = 1, iterations do
        _ = cryptography.sha256(input)
    end
    local end_time = os.clock()

    local elapsed = end_time - start_time
    local per_hash = (elapsed / iterations) * 1000  -- milliseconds
    local hashes_per_sec = iterations / elapsed

    f:write("  Total time: " .. string.format("%.9f", elapsed) .. " seconds\n")
    f:write("  Time per hash: " .. string.format("%.9f", per_hash) .. " ms\n")
    f:write("  Throughput: " .. string.format("%.0f", hashes_per_sec) .. " hashes/second\n\n")

    return elapsed, hashes_per_sec
end

-- Test 1: Empty string (minimal input)
benchmark("Test 1: Empty string", "", 10000)

-- Test 2: Short string
benchmark("Test 2: Short string (3 bytes)", "abc", 10000)

-- Test 3: Medium string
benchmark("Test 3: Medium string (44 bytes)", "The quick brown fox jumps over the lazy dog.", 10000)

-- Test 4: Longer string (crosses 1 block boundary)
local long_str = string.rep("a", 100)
benchmark("Test 4: Long string (100 bytes)", long_str, 5000)

-- Test 5: Very long string (multiple blocks)
local very_long_str = string.rep("Lorem ipsum dolor sit amet, consectetur adipiscing elit. ", 10)
benchmark("Test 5: Very long string (" .. #very_long_str .. " bytes)", very_long_str, 2000)

-- Test 6: Exactly 1 block (512 bits = 64 bytes)
local block_str = string.rep("x", 55)  -- 55 bytes + padding = exactly 1 block
benchmark("Test 6: Exactly 1 block (55 bytes)", block_str, 10000)

-- Test 7: Just over 1 block (requires 2 blocks)
local two_block_str = string.rep("y", 56)  -- Forces 2 blocks
benchmark("Test 7: Just over 1 block (56 bytes)", two_block_str, 10000)

f:write("=== Benchmark Complete ===\n")
f:write("\nNote: Performance varies based on input length and block boundaries.\n")
f:write("SHA-256 processes data in 512-bit (64-byte) blocks.")