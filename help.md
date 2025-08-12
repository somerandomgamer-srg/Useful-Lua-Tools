# SRG Library Documentation

## Math Library Extensions
1. `math.average(t)`
  - Calculates arithmetic mean from a list of numbers.
  - ```lua
      local numbers = {1, 2, 3, 4, 5}
      print(math.average(numbers)) --> 3
    ```

2. `math.median(t)`
  - Finds middle value in sorted list. For even-length lists, averages two middle values.
  - ```lua
      local numbers = {1, 3, 5, 7}
      print(math.median(numbers)) --> 4 (average of 3 and 5)

      local oddNumbers = {1, 3, 5}
      print(math.median(oddNumbers)) --> 3
    ```

3. `math.range(t)`
  - Calculates the range from a list of numbers.
  - ```lua
      local numbers = {10, 20, 30, 40, 50}
      print(math.range(numbers)) --> 40 (50 - 10)
    ```

4. `math.mode(t)`
  - Calculates the mode from a list of numbers.
  - ```lua
      local numbers = {1, 2, 2, 3, 3, 3, 4}
      print(math.mode(numbers)) --> 3
    ```

5. `math.standard_deviation(t)`
  - Calculates the standard deviation from a list of numbers.
  - ```lua
      local numbers = {2, 4, 4, 4, 5, 5, 7, 9}
      print(math.standard_deviation(numbers)) --> 2.0
    ```

6. `math.sum(t)`
  - Calculates the sum from a list of numbers.
  - ```lua
      local numbers = {1, 2, 3, 4, 5}
      print(math.sum(numbers)) --> 15
    ```

7. `math.gcd(x, y)`
  - Finds the greatest common factor between `x` and `y`.
  - ```lua
      print(math.gcd(48, 18)) --> 6
      print(math.gcd(35, 10)) --> 5
    ```

8. `math.lcm(x, y)`
  - Finds the least common multiple between `x` and `y`.
  - ```lua
      print(math.lcm(4, 6)) --> 12
      print(math.lcm(21, 6)) --> 42
    ```

9. `math.is_prime(x)`
  - Checks if `x` is a prime number.
  - ```lua
      print(math.is_prime(7)) --> true
      print(math.is_prime(12)) --> false
    ```

10. `math.quadratic(a, b, c)`
  - Solves a quadratic equation in the form `a`x² + `b`x + `c` using the quadratic formula.
  - ```lua
      local x1, x2 = math.quadratic(1, -5, 6)
      print(x1, x2) --> 3, 2 (roots of x² - 5x + 6)
    ```

11. `math.aos(a, b)`
  - Calculates the axis of symmetry for a quadratic function using `a` and `b` coefficients.
  - ```lua
      print(math.aos(1, -6)) --> 3 (axis of symmetry for x² - 6x + 5)
    ```

12. `math.vertex(a, b, c)`
  - Calculates the vertex point of a quadratic function using `a`, `b`, and `c` coefficients.
  - ```lua
      local x, y = math.vertex(1, -4, 3)
      print(x, y) --> 2, -1 (vertex of x² - 4x + 3)
    ```

13. `math.sinh(x)`
  - Calculates the hyperbolic sine of `x`.
  - ```lua
      print(math.sinh(1)) --> 1.1752011936438
    ```

14. `math.cosh(x)`
  - Calculates the hyperbolic cosine of `x`.
  - ```lua
      print(math.cosh(1)) --> 1.5430806348152
    ```

15. `math.tanh(x)`
  - Calculates the hyperbolic tangent of `x`.
  - ```lua
      print(math.tanh(1)) --> 0.76159415595576
    ```

16. `math.asinh(x)`
  - Calculates the inverse hyperbolic sine of `x`.
  - ```lua
      print(math.asinh(1)) --> 0.88137358701954
    ```

17. `math.acosh(x)`
  - Calculates the inverse hyperbolic cosine of `x`.
  - ```lua
      print(math.acosh(2)) --> 1.3169578969248
    ```

18. `math.atanh(x)`
  - Calculates the inverse hyperbolic tangent of `x`.
  - ```lua
      print(math.atanh(0.5)) --> 0.54930614433405
    ```

19. `math.round(x, precision)`
  - Rounds `x` to `precision` decimal places (whole number if no precision given).
  - ```lua
      print(math.round(3.14159, 2)) --> 3.14
      print(math.round(3.14159)) --> 3
    ```

20. `math.fib(n)`
  - Calculates the `n`th term of the Fibonacci Sequence.
  - ```lua
      print(math.fibonacci(7)) --> 13
      print(math.fibonacci(10)) --> 55
    ```

21. `math.is_odd(x)`
  - Checks if `x` is an odd number.
  - NOTE: Floats are neither odd nor even.
  - ```lua
      print(math.is_odd(7)) --> true
    ```

22. `math.is_even(x)`
  - Checks if `x` is an even number.
  - NOTE: Floats are neither odd nor even.
  - ```lua
      print(math.is_even(4)) --> true
    ```

23. `math.is_perfect_square(x)`
  - Checks if `x` has a whole number square root
  - ```lua
      print(math.is_perfect_square(16)) --> true
      print(math.is_perfect_square(18)) --> false
    ```

24. `math.factorial(x)`
  - Calculates the factorial of `x`
  - ```lua
      print(math.factorial(5)) --> 120
      print(math.factorial(3)) --> 6
    ```

25. `math.factors(x)`
  - Returns all factors of `x`
  - ```lua
      print(table.concat(math.factors(12), ", ")) --> {1, 2, 3, 4, 6, 12}
    ```

26. `math.is_perfect(x)`
  - Checks if `x` is perfect (sum of factors equals the number)
  - ```lua
      print(math.is_perfect(28)) --> true
      print(math.is_perfect(15)) --> false
    ```

27. `math.is_deficient(x)`
  - Checks if `x` is deficient (sum of factors less than number)
  - ```lua
      print(math.is_deficient(15)) --> true
    ```

28. `math.is_abundant(x)`
  - Checks if `x` is abundant (sum of factors greater than number)
  - ```lua
      print(math.is_abundant(12)) --> true
    ```

29. `math.classify_number(x)`
  - Classifies `x` as Perfect, Deficient, or Abundant
  - ```lua
      print(math.classify_number(28)) --> "Perfect"
      print(math.classify_number(15)) --> "Deficient"
      print(math.classify_number(12)) --> "Abundant"
    ```

30. `math.z_score(x, t)`
  - Calculates the z-score of `x` in a dataset (`t`)
  - ```lua
      local data = {2, 4, 4, 4, 5, 5, 7, 9}
      print(math.z_score(7, data)) --> 1.5
    ```

31. `math.permutation(x, r)`
  - Calculates the number of ways to arrange `r` items from `x` items
  - ```lua
      print(math.permutation(5, 3)) --> 60
    ```

32. `math.combination(x, r)`
  - Calculates the number of ways to choose `r` items from `x` items
  - ```lua
      print(math.combination(5, 3)) --> 10
    ```

33. `math.secant(x)`
  - Calculates the secant of `x`
  - ```lua
      print(math.secant(math.pi/3)) --> 2.0
    ```

34. `math.cosecant(x)`
  - Calculates the cosecant of `x`
  - ```lua
      print(math.cosecant(math.pi/6)) --> 2.0
    ```

35. `math.cotangent(x)`
  - Calculates the cotangent of `x`
  - ```lua
      print(math.cotangent(math.pi/4)) --> 1.0
    ```

36. `math.asecant(x)`
  - Calculates the inverse secant of `x`
  - ```lua
      print(math.asecant(2)) --> 1.0472
    ```

37. `math.acosecant(x)`
  - Calculates the inverse cosecant of `x`
  - ```lua
      print(math.acosecant(2)) --> 0.5236
    ```

38. `math.acotangent(x)`
  - Calculates the inverse cotangent of `x`
  - ```lua
      print(math.acotangent(1)) --> 0.7854
    ```

39. `math.midpoint(x, y)`
    - Calculates the midpoint between `x` and `y`
    - ```lua
        math.midpoint(1, 5) --> 3
      ```

40. `math.is_whole(x)`
  - Checks if `x` is a whole number
  - ```lua
      math.is_whole(5) --> true
      math.is_whole(2.5) --> false
    ```

## String Library Extensions
41. `string.clean_number(s)`
  - Unlike simple `tonumber()` conversion, this function properly cleans a string (`s`) to ensure it's a valid number format:
    - Extracts numeric values from mixed text (e.g., "22 km" → "22")
    - Handles and corrects multiple decimal points (e.g., "3.23.3" → "3.233")
    - Handles and corrects multiple negative signs (e.g., "-4343-2" → "-43432")
    - Properly maintains negative signs only at the beginning
    - Strips all non-numeric characters while preserving the numeric value
  - Features:
    - Removes all non-numeric characters except decimal points and minus signs
    - Handles multiple decimal points by keeping only the first one
    - Preserves negative sign only if it's at the start
  - Example usage:
    - CleanNumber("abc-123.45.6") -> "-123.456"
    - CleanNumber("12.34.56") -> "12.3456"
    - CleanNumber("ab12cd") -> "12"
    - CleanNumber("$52 per Year") -> "52"
  - ```lua
      print(string.clean_number("abc-123.45.6")) --> "-123.456"
      print(string.clean_number("$52.99")) --> "52.99"
    ```

42. `string.trim(s)`
  - Removes whitespace from both ends of a string.
  - ```lua
      print(string.trim("  hello  ")) --> "hello"
    ```

43. `string.split(s, pattern)`
  - Splits `s` into a table based on `pattern`.
  - Example:
  - ```lua
      string.split("1 2 3 4 5", " ") -> {"1","2","3","4","5"}
      string.split("1-2-3-4-5", "-") -> {"1","2","3","4","5"}
      string.split("1 2:3 4 5", ":") -> {"1 2","3 4 5"}

      local t = string.split("1,2,3", ",")
      -- t = {"1", "2", "3"}

      local words = string.split("hello world", " ")
      -- words = {"hello", "world"}
    ```

44. `string.starts_with(s, letter)`
  - Checks if `s` starts with `letter`.
  - ```lua
      print(string.starts_with("Hello", "H")) --> true
    ```

45. `string.ends_with(s, letter)`
  - Checks if `s` ends with `letter`.
  - ```lua
      print(string.ends_with("World", "d")) --> true
    ```

46. `string.pad(s, string_char, length, include_start, include_end)`
  - Adds `string_char` to `s`'s start if `include_start` is true and to its end if `include_end` is true, repeating it `length` times.
  - ```lua
      print(string.pad("hello", "*", 2)) --> "**hello**"
      print(string.pad("hello", "-", 1, true, false)) --> "-hello"
    ```

47. `string.capitalize(s)`
  - Capitalizes the first character of a string.
  - ```lua
      print(string.capitalize("hello")) --> "Hello"
    ```

48. `string.title_case(s, sep)`
  - Capitalizes the first letter of each word in `s` using the specified separator `sep` (default is space).
  - ```lua
      print(string.title_case("hello world")) --> "Hello World"
      print(string.title_case("hello-world", "-")) --> "Hello-World"
    ```

49. `string.count(s, pattern)`
  - Returns the amount of occurrences `pattern` occurs in `s`.
  - ```lua
      print(string.count("hello world", "l")) --> 3
      print(string.count("hello hello", "hello")) --> 2
    ```

50. `string.is_palindrome(s)`
  - Checks if a string reads the same forwards and backwards
  - ```lua
      print(string.is_palindrome("racecar")) --> true
      print(string.is_palindrome("hello")) --> false
    ```

## Table Library Extensions
51. `table.contains(t, value)`
  - Recursively checks if `t` contains `value`.
  - Returns (`true`, `number of instances`) or (`false`, `0`).
  - ```lua
      local t = {1, 2, {3, 4, {5}}}
      local found, count = table.contains(t, 4)
      print(found, count) --> true, 1
    ```

52. `table.csv_to_table(s)`
  - Converts a CSV string (`s`) into a table.
  - ```lua
      local csv = "1,2,3\n4,5,6"
      local t = table.csv_to_table(csv)
      -- t = {{1,2,3}, {4,5,6}}
    ```

53. `table.to_csv(t)`
  - Converts a table (`t`) to a CSV string.
  - ```lua
      local csv_string = table.to_csv(t)
      -- csv_string = "1,2,3\n4,5,6"
    ```

54. `table.reverse(t)`
  - Reverses the order of elements in `t`.
  - ```lua
      local t = {1, 2, 3}
      local reversed = table.reverse(t)
      -- reversed = {3, 2, 1}
    ```

55. `table.shuffle(t, n)`
  - Shuffles the order of elements in `t` `n` times.
  - ```lua
      local t = {1, 2, 3, 4, 5}
      local shuffled = table.shuffle(t)
      -- shuffled = {3, 1, 5, 2, 4} (random order)
    ```

56. `table.count_keys(t)`
  - Counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences.
  - ```lua
      local t = {
        values = {
          apples = 5,
          fruits = {
            oranges = 3
          }
        }
      }
      local count, keys = table.count_keys(t)
      -- count = 4
      -- keys = {
      --   "values" = 1
      -- }
    ```

57. `table.deep_count_keys(t, separator)`
  - Recursively counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences.
  - The keys in nested tables are joined using `separator` (defaults to ".").
  - ```lua
      local t = {
        values = {
          apples = 5,
          fruits = {
            oranges = 3
          }
        }
      }
      local count, paths = table.deep_count_keys(t)
      -- count = 4
      -- paths = {
      --   "values" = 1,
      --   "values.apples" = 1,
      --   "values.fruits" = 1,
      --   "values.fruits.oranges" = 1
      -- }
    ```
58. `table.intersection(t1, t2)`
  - Returns a table containing the similarities between `t1` and `t2`
  - NOTE: This function ONLY works on lists/arrays
  - ```lua
      local t1 = {1, 2, 3, 4, 5}
      local t2 = {4, 5, 6, 7, 8}
      local common = table.intersection(t1, t2)
      -- common = {4, 5}
    ```

59. `table.difference(t1, t2)`
  - Returns a table containing the differences between `t1` and `t2`
  - NOTE: This function ONLY works on lists/arrays
  - ```lua
      local t1 = {1, 2, 3, 4, 5}
      local t2 = {4, 5, 6, 7, 8}
      local diff = table.difference(t1, t2)
      -- diff = {1, 2, 3, 6, 7, 8}
    ```

60. `table.shuffle_randomseed(t, seed, n)`
  - Shuffles the order of elements in `t` once using the randomseed (`seed`)
  - NOTE: If `n` is not given, `t` will only shuffle once
  - ```lua
      local t = {1, 2, 3, 4, 5}
      local shuffled = table.shuffle_randomseed(t, 12345)
      -- Using seed 12345 will always produce the same shuffle
      -- shuffled = {3, 1, 5, 2, 4}
      -- shuffled = {3, 1, 5, 2, 4}
    ```
61. `table.keypair_reverse(t)`
  - Returns a reversed key-pair table of `t` in which each `key = value` turns into `value = key`.
  - ```lua
      local t = {
        ["key1"] = 1, ["key2"] = 2, ["key3"] = 3, ["key4"] = 4, ["key5"] = 5
      }
      local reversed = table.keypair_reverse(t) --> { ["1"] = "key1", ["2"] = "key2", ["3"] = "key3", ["4"] = "key4", ["5"] = "key5" }
    ```

62. `table.last(t)`
  - Returns the last element in `t`.
  - ```lua
      local t = {1, 2, 3, 4, 5}
      local last = table.last(t) --> 5
    ```

63. `table.first(t)`
  - Returns the first element in `t`.
  - ```lua
      local t = {1, 2, 3, 4, 5}
      local first = table.first(t) --> 1
    ```

## Input Library
64. `input.string(message)`
  - Gets string input with an optional print `message`.
  - ```lua
      local name = input.string("Enter your name")
      -- Enter your name: John
      -- name = "John"
    ```

65. `input.table(message, number_of_inputs)`
  - Collects `number_of_inputs` strings with an optional print `message`.
  - ```lua
      local names = input.table("Enter 3 names", 3)
      -- Enter 3 names
      -- input 1: John
      -- input 2: Jane
      -- input 3: Bob
      -- names = {"John", "Jane", "Bob"}
    ```

66. `input.number(message)`
  - Gets validated numeric input with an optional print `message`.
  - ```lua
      local age = input.number("Enter your age")
      -- Enter your age: 25
      -- age = 25
    ```

67. `input.number_table(message, number_of_inputs)`
  - Collects `number_of_inputs` numbers with an optional print `message`.
  - ```lua
      local scores = input.number_table("Enter 3 scores", 3)
      -- Enter 3 scores
      -- input 1: 95
      -- input 2: 87
      -- input 3: 92
      -- scores = {95, 87, 92}
    ```

68. `input.loop(message)` / `input.number_loop(message)`
  - Collects inputs until empty submission with an optional print `message`.
  - ```lua
      local names = input.loop("Enter names")
      -- Enter names (press enter to finish)
      -- Input 1: John
      -- Input 2: Jane
      -- Input 3: 
      -- names = {"John", "Jane"}
    ```

## Cryptography Library
69. `cryptography.text_to_ascii(s)`
  - Converts plaintext to ASCII code numbers.
  - ```lua
      print(cryptography.text_to_ascii("Hello")) --> "72 101 108 108 111"
    ```

70. `cryptography.ascii_to_text(s)`
  - Converts ASCII code numbers to plaintext.
  - ```lua
      print(cryptography.ascii_to_text("72 101 108 108 111")) --> "Hello"
    ```

71. `cryptography.text_to_hex(s)`
  - Converts plaintext to hexadecimal.
  - ```lua
      print(cryptography.text_to_hex("Hello")) --> "48 65 6C 6C 6F"
    ```

72. `cryptography.hex_to_text(s)`
  - Converts hexadecimal to text.
  - ```lua
      print(cryptography.hex_to_text("48 65 6C 6C 6F")) --> "Hello"
    ```

73. `cryptography.text_to_binary(s)`
  - Converts plaintext to binary.
  - ```lua
      print(cryptography.text_to_binary("Hello")) --> "1001000 1100101 1101100 1101100 1101111"
    ```

74. `cryptography.binary_to_text(s)`
  - Converts binary to plaintext.
  - ```lua
      print(cryptography.binary_to_text("1001000 1100101 1101100 1101100 1101111")) --> "Hello"
    ```

75. `cryptography.text_to_octal(s)`
  - Converts plaintext to octal.
  - ```lua
      print(cryptography.text_to_octal("Hello")) --> "110 145 154 154 157"
    ```

76. `cryptography.octal_to_text(s)`
  - Converts octal to plaintext.
  - ```lua
      print(cryptograpy.octal_to_text("110 145 154 154 157") --> "Hello"
    ```

77. `cryptography.text_to_morse(s)`
  - Converts plaintext to morse code.
  - ```lua
      print(cryptography.text_to_morse("SOS")) --> "... --- ..."
    ```

78. `cryptography.morse_to_text(s)`
  - Converts morse code to plaintext.
  - ```lua
      print(cryptography.morse_to_text("... --- ...")) --> "sos"
    ```

79. `cryptography.text_to_base64(s)`
  - Converts plaintext to base64.
  - ```lua
      print(cryptography.text_to_base64("hello")) --> "SGVsbG8="
    ```

80. `cryptography.base64_to_text(s)`
  - Converts base64 to plaintext.
  - ```lua

      print(cryptography.base64_to_text("SGVsbG8=")) --> "hello"
    ```

81. `cryptography.text_to_base32(s)`
  - Converts plaintext to base32.
  - ```lua
      print(cryptography.text_to_base32("Hello")) --> "JBSWY3DP"
    ```

82. `cryptography.base32_to_text(s)`
  - Converts base32 to plaintext.
  - ```lua
      print(cryptography.base32_to_text("JBSWY3DP")) --> "Hello"
    ```

83. `cryptography.xor(s, key)`
  - Performs XOR encryption/decryption on `s` using a `key`.
  - Note: XOR is symmetric - use the same key to decrypt.
  - ```lua
      local message = "Hello"
      local key = "Key"
      local encrypted = cryptography.xor(message, key)
      local decrypted = cryptography.xor(encrypted, key)
      print(decrypted) --> "Hello"
    ```

84. `cryptography.caesar_cipher(s, shift)`
  - Applies Caesar cipher encryption to `s` with specified `shift`.
  - ```lua
      print(cryptography.caesar_cipher("Hello", 3)) --> "Khoor"
    ```

85. `cryptography.rot13(s)`
  - Applies ROT13 encryption on `s` (Caesar cipher with shift of 13).
  - ```lua
      print(cryptography.rot13("Hello")) --> "Uryyb"
    ```

86. `cryptography.uuid_v4()`
  - Generates a random UUID (version 4)
  - UUID V4 format: `xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`
    - `x`: 0-9 and a-f
    - Hyphens (-) separate sections
    - The `4` in the third section indicates it's a version 4 UUID
    - `y`: 8, 9, a, or b
  - ```lua
      local table = {}
      local function test()
        print("Hello, World!")
      end

      table[cryptography.uuid_v4()] = test
      --> table = {
      ---  "13925ae9-32df-482e-a13d-29dc32013dac" = test"
      --- }
    ```

87. `cryptography.bswap(x)`
  - Performs bitwise SWAP operation on `x`.
  - ```lua
      print(cryptography.bswap(0x12345678)) --> 0x78563412
    ```

88. `cryptography.rol(x, disp)`
  - Performs a bitwise left rotation on `x` by specified positions (`disp`).
  - ```lua
      print(cryptography.rol(0x12345678, 4)) --> 0x23456781
    ```

89. `cryptography.ror(x, disp)`
  - Performs a bitwise right rotation on `x` by specified positions (`disp`).
  - ```lua
      print(cryptography.ror(0x12345678, 4)) --> 0x81234567
    ```

90. `cryptography.number_to_bit(x)`
  - Converts `x` to its binary representation.
  - ```lua
      print(cryptography.number_to_bit(12345)) --> 000000000000000011000000111001
    ```

91. `cryptography.number_to_hex(x)`
  - Converts `x` to its hexadecimal representation.
  - ```lua
      print(cryptography.number_to_hex(255)) --> "ff"
    ```

92. `cryptography.btest(a, b)`
  - Returns a boolean signaling whether the bitwise AND of its operands is different from zero.
  - ```lua
      print(cryptography.btest(3, 2)) --> true
    ```

93. `cryptography.extract(n, field, width)`
  - Returns the unsigned number formed by the bits `field` to `field + width - 1` from `n`.
  - ```lua
      print(cryptography.extract(0xFF, 4, 4)) --> 0xF
    ```

94. `cryptography.replace(n, v, field, width)`
  - Returns a copy of `n` with the bits `field` to `field + width - 1` replaced by the value `v`.
  - ```lua
      print(cryptography.replace(0x1234, 0xF, 4, 4)) --> 0x12F4
    ```

## Global Functions

95. `wait(x)`
  - Yields the code for `x` seconds. (Similar to python's wait function).
  - ```lua
      print("Start")
      wait(2) -- Waits 2 seconds
      print("End")
    ```

96. `is_type(value, type_of_object)`
  - Checks if `value` is a `type_of_object`.
  - Available types:
    - |`nil`|`number`|`string`|`boolean`|`table`|`function`|`thread`|`userdata`|
      |-----|--------|--------|---------|-------|----------|--------|----------|
  - ```lua
      print(isType(42, "number")) --> true
      print(isType("hello", "string")) --> true
    ```

97. `benchmark(func, iterations)`
  - Runs `func` `iterations` times.
  - NOTE: If `iterations` is not given, the code will run 10 times.
  - Returns:
    - `Total Execution Time`
    - `Average Execution Time Per Run`
    - `The Last Result (if return is added in the code)`
  - ```lua
      local function test()
        for i = 1, 1000000 do
          local x = i * i
        end
      end

      local total, avg, _ = benchmark(test, 5)
      print(string.format("Total: %.3fs, Average: %.3fs", total, avg))
    ```

98. `execution_time(func)`
  - Runs `func` and returns the time it takes to run `func`.
  - ```lua
      local time, _ = execution_time(function()
        for i = 1, 1000000 do
          local x = i * i
        end
      end)
      print(string.format("Time: %.3fs", time))
    ```

99. `delay(t, func)`
  - Yields `t` seconds before running `func` without stopping other code.
  - ```lua
      print("Start")
      delay(2, function()
        print("This prints after 2 seconds")
      end)
      print("This prints immediately")
    ```

100. `delay_stop(t, func)`
  - Yields `t` seconds before running `func` while stopping other code.
  - ```lua
      print("Start")
      delay_stop(2, function()
        print("This prints after 2 seconds")
      end)
      print("This only prints after the delay")
    ```