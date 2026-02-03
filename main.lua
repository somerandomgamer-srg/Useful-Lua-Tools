require("Useful Lua Tools")

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

local function runBenchmark(name, iterations, input)
  local total, avg, result = benchmark(cryptography.hash, iterations, input)
  print(string.format("=== %s ===", name))
  print(string.format("  Iterations:     %d", iterations))
  print(string.format("  Total time:     %.4f seconds", total))
  print(string.format("  Avg per call:   %.6f seconds (%.2f µs)", avg, avg * 1000000))
  print(string.format("  Ops/second:     %.2f", iterations / total))
  print()
  return { name = name, opsPerSecond = iterations / total }
end

local results = {}
results[1] = runBenchmark("Short String (13 bytes)", 5000, shortStr)
results[2] = runBenchmark("Medium String (450 bytes)", 2000, mediumStr)
results[3] = runBenchmark("Long String (10KB)", 500, longStr)
results[4] = runBenchmark("Empty String", 5000, "")

print("╔════════════════════════════════════════════════════════════╗")
print("║                      Summary                               ║")
print("╚════════════════════════════════════════════════════════════╝")
print()

local fastest, slowest = results[1], results[1]
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
