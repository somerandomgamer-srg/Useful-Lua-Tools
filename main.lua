require("Useful Lua Tools")

local function benchmark(name, func, iterations)
  iterations = iterations or 1000
  
  collectgarbage("collect")
  local startMem = collectgarbage("count")
  local startTime = os.clock()
  
  for i = 1, iterations do
    func()
  end
  
  local endTime = os.clock()
  local endMem = collectgarbage("count")
  
  local elapsed = endTime - startTime
  local avgTime = elapsed / iterations
  local memDelta = endMem - startMem
  
  print(string.format("=== %s ===", name))
  print(string.format("  Iterations:     %d", iterations))
  print(string.format("  Total time:     %.4f seconds", elapsed))
  print(string.format("  Avg per call:   %.6f seconds (%.2f µs)", avgTime, avgTime * 1000000))
  print(string.format("  Ops/second:     %.2f", iterations / elapsed))
  print(string.format("  Memory delta:   %.2f KB", memDelta))
  print()
  
  return {
    name = name,
    iterations = iterations,
    totalTime = elapsed,
    avgTime = avgTime,
    opsPerSecond = iterations / elapsed,
    memoryDelta = memDelta
  }
end

print("╔════════════════════════════════════════════════════════════╗")
print("║       Hash Function Benchmark (SHA-256 Inspired)          ║")
print("╚════════════════════════════════════════════════════════════╝")
print()

local shortStr = "Hello, World!"
local mediumStr = string.rep("The quick brown fox jumps over the lazy dog. ", 10)
local longStr = string.rep("A", 10000)

print("Test Data Sizes:")
print(string.format("  Short:  %d bytes", #shortStr))
print(string.format("  Medium: %d bytes", #mediumStr))
print(string.format("  Long:   %d bytes", #longStr))
print()

local results = {}

results[1] = benchmark("Short String (13 bytes)", function()
  cryptography.hash(shortStr)
end, 5000)

results[2] = benchmark("Medium String (450 bytes)", function()
  cryptography.hash(mediumStr)
end, 2000)

results[3] = benchmark("Long String (10KB)", function()
  cryptography.hash(longStr)
end, 500)

results[4] = benchmark("Empty String", function()
  cryptography.hash("")
end, 5000)

results[5] = benchmark("Binary Data (256 bytes)", function()
  local binary = ""
  for i = 0, 255 do
    binary = binary .. string.char(i)
  end
  cryptography.hash(binary)
end, 1000)

print("╔════════════════════════════════════════════════════════════╗")
print("║                      Summary                               ║")
print("╚════════════════════════════════════════════════════════════╝")
print()

local fastest = results[1]
local slowest = results[1]
for _, r in ipairs(results) do
  if r.opsPerSecond > fastest.opsPerSecond then fastest = r end
  if r.opsPerSecond < slowest.opsPerSecond then slowest = r end
end

print(string.format("Fastest: %s (%.2f ops/sec)", fastest.name, fastest.opsPerSecond))
print(string.format("Slowest: %s (%.2f ops/sec)", slowest.name, slowest.opsPerSecond))
print()

print("Sample Hash Outputs:")
print(string.format("  hash(\"\"):           %s", cryptography.hash("")))
print(string.format("  hash(\"hello\"):      %s", cryptography.hash("hello")))
print(string.format("  hash(\"Hello\"):      %s", cryptography.hash("Hello")))
print()
print("Benchmark complete!")
