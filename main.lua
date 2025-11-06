require("Useful Lua Tools")

print("=== BigNum Power Function Tests ===\n")

print("Test 1: Positive whole exponent")
local a = bignum.new("2")
local result = bignum.pow(a, 10)
print("2^10 = " .. bignum.to_string(result))
print()

print("Test 2: Negative exponent")
local b = bignum.new("2")
local result2 = bignum.pow(b, -3, 5)
print("2^-3 = " .. bignum.to_string(result2))
print()

print("Test 3: Fractional exponent (square root)")
local c = bignum.new("16")
local result3 = bignum.pow(c, 0.5, 6)
print("16^0.5 = " .. bignum.to_string(result3))
print()

print("Test 4: Fractional exponent (cube root)")
local d = bignum.new("8")
local result4 = bignum.pow(d, 1/3, 6)
print("8^(1/3) = " .. bignum.to_string(result4))
print()

print("Test 5: Mixed - 4^2.5")
local e = bignum.new("4")
local result5 = bignum.pow(e, 2.5, 6)
print("4^2.5 = " .. bignum.to_string(result5))
print()

print("Test 6: Large number with positive exponent")
local f = bignum.new("123456789")
local result6 = bignum.pow(f, 3)
print("123456789^3 = " .. bignum.to_string(result6))
print()

print("Test 7: Decimal base number")
local g = bignum.new("1.5")
local result7 = bignum.pow(g, 3, 6)
print("1.5^3 = " .. bignum.to_string(result7))
