1. `ult.version`
  - The version of Useful Lua Tools
  - "Major Update"."Minor Update"."Patch"
  - Type: `variable`
  - Returns `string`

2. `ult.contributors`
  - The people who contributed to Useful Lua Tools
  - Type: `variable`
  - Returns `table`

3. `ult.min_lua_ver`
  - The minimum version of Lua required to run Useful Lua Tools
  - Type: `variable`
  - Returns `string`

4. `ult.release_date`
  - The release date of the current ULT version
  - Type: `variable`
  - Returns `string`

5. `ult.build`
  - The current build of Useful Lua Tools
  - `Project` - `version` - `date of release` - `minimum lua version`
  - Type: `variable`
  - Returns `string`

6. `system.os`
  - The OS the system is running on, or nil if it cannot be determined
  - `Windows` | `Linux` | `MacOS` | `ChromeOS`
  - Type: `variable`
  - Returns `string` or `nil`

7. `system.is_windows`
  - true if the host system is running on Windows, false otherwise
  - Type: `variable`
  - Returns `boolean`

8. `system.is_mac`
  - true if the host system is running on MacOS, false otherwise
  - Type: `variable`
  - Returns `boolean`

9. `system.is_linux`
  - true if the host system is running on Linux, false otherwise
  - Type: `variable`
  - Returns `boolean`

10. `system.is_chrome`
  - true if the host system is running on Chrome OS, false otherwise
  - Type: `variable`
  - Returns `boolean`

11. `system.uname`
  - The system Unix Name, or nil if it cannot be determined
  - Type: `variable`
  - Returns `string` or `nil`

12. `system.cores`
  - Amount of CPU Cores the host system has, or nil if it cannot be determined
  - Type: `variable`
  - Returns `number` or `nil`

13. `system.architecture`
  - The CPU architecture of the host system, or nil if it cannot be determined
  - Type: `variable`
  - Returns `string` or `nil`

14. `system.is_linux_based`
  - true if the host system is built on Linux, false otherwise
  - Type: `variable`
  - Returns `boolean`

15. `math.average(t)`
  - Calculates the average from a list of numbers.
  - Type: `function`
  - Arguments:
    - `t`:
      - R
      - table
  - Returns `number`

16. `math.median(t)`
  - Finds middle value in list. For even-length lists, averages two middle values.
  - Type: `function`
  - Arguments:
    - `t`:
      - R
      - table
  - Returns `number`

17. `math.range(t)`
  - Calculates the range from a list of numbers.
  - Type: `function`
  - Arguments:
    - `t`:
      - R
      - table
  - Returns `number`

18. `math.mode(t)`
  - Calculates the mode from a list of numbers.
  - Type: `function`
  - Arguments:
    - `t`:
      - R
      - table
  - Returns `number`

19. `math.standard_deviation(t)`
  - Calculates the standard deviation from a list of numbers.
  - Type: `function`
  - Arguments:
    - `t`:
      - R
      - table
  - Returns `number`

20. `math.sum(t)`
  - Calculates the sum from a list of numbers.
  - Type: `function`
  - Arguments:
    - `t`:
      - R
      - table
  - Returns `number`

21. `math.gcd(x, y)`
  - Finds the greatest common factor between `x` and `y`.
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
    - `y`:
      - R
      - number
  - Returns `number`

22. `math.lcm(x, y)`
  - Finds the least common multiple between `x` and `y`.
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
    - `y`:
      - R
      - number
  - Returns `number`

23. `math.is_prime(x)`
  - Checks if `x` is a prime number.
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `boolean`

24. `math.quadratic(a, b, c)`
  - Solves a quadratic equation in the form `a`x² + `b`x + `c` using the quadratic formula.
  - Type: `function`
  - Arguments:
    - `a`:
      - R
      - number
    - `b`:
      - R
      - number
    - `c`:
      - R
      - number
  - Returns `number`

25. `math.aos(a, b)`
  - Calculates the axis of symmetry for a quadratic function using `a` and `b` coefficients.
  - Type: `function`
  - Arguments:
    - `a`:
      - R
      - number
    - `b`:
      - R
      - number
  - Returns `number`

26. `math.vertex(a, b, c)`
  - Calculates the vertex point of a quadratic function using `a`, `b`, and `c` coefficients.
  - Type: `function`
  - Arguments:
    - `a`:
      - R
      - number
    - `b`:
      - R
      - number
    - `c`:
      - R
      - number
  - Returns `number`

27. `math.sinh(x)`
  - Calculates the hyperbolic sine of `x`.
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `number`

28. `math.cosh(x)`
  - Calculates the hyperbolic cosine of `x`.
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `number`

29. `math.tanh(x)`
  - Calculates the hyperbolic tangent of `x`.
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `number`

30. `math.asinh(x)`
  - Calculates the inverse hyperbolic sine of `x`.
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `number`

31. `math.acosh(x)`
  - Calculates the inverse hyperbolic cosine of `x`.
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `number`

32. `math.atanh(x)`
  - Calculates the inverse hyperbolic tangent of `x`.
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `number`

33. `math.round(x, precision)`
  - Rounds `x` to `precision` decimal places (whole number if no precision given).
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
    - `precision`:
      - O
      - number
- Returns `number`

34. `math.fib(n)`
  - Calculates the `n`th term of the Fibonacci Sequence.
  - Arguments:
    - `n`:
      - R
      - number
  - Returns `number`

35. `math.is_odd(x)`
  - Checks if `x` is an odd number.
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `boolean`

36. `math.is_even(x)`
  - Checks if `x` is an even number.
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `boolean`

37. `math.is_perfect_square(x)`
  - Checks if `x` has a whole number square root
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `boolean`

38. `math.factorial(x)`
  - Calculates the factorial of `x`
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `number`

39. `math.factors(x)`
  - Returns all factors of `x`
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `table`

40. `math.is_perfect(x)`
  - Checks if `x` is perfect (sum of factors equals the number)
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `boolean`

41. `math.is_deficient(x)`
  - Checks if `x` is deficient (sum of factors less than number)
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `boolean`

42. `math.is_abundant(x)`
  - Checks if `x` is abundant (sum of factors greater than number)
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `boolean`

43. `math.classify_number(x)`
  - Classifies `x` as Perfect, Deficient, or Abundant
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `string`

44. `math.z_score(x, t)`
  - Calculates the z-score of `x` in a dataset (`t`)
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
    - `t`:
      - R
      - table
  - Returns `number`

45. `math.permutation(x, r)`
  - Calculates the number of ways to arrange `r` items from `x` items
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
    - `r`:
      - R
      - number
  - Returns `number`

46. `math.combination(x, r)`
  - Calculates the number of ways to choose `r` items from `x` items
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
    - `r`:
      - R
      - number
  - Returns `number`

47. `math.secant(x)`
  - Calculates the secant of `x`
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `number`

48. `math.cosecant(x)`
  - Calculates the cosecant of `x`
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `number`

49. `math.cotangent(x)`
  - Calculates the cotangent of `x`
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `number`

50. `math.asecant(x)`
  - Calculates the inverse secant of `x`
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `number`

51. `math.acosecant(x)`
  - Calculates the inverse cosecant of `x`
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `number`

52. `math.acotangent(x)`
  - Calculates the inverse cotangent of `x`
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `number`

53. `math.midpoint(x, y)`
    - Calculates the midpoint between `x` and `y`
    - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
    - `y`:
      - R
      - number
  - Returns `number`

54. `math.is_whole(x)`
  - Checks if `x` is a whole number
  - Type: `function`
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `boolean`

55. `string.clean_number(s)`
  - `tonumber()` conversion but better. Properly cleans a string (`s`) to ensure it's in a valid number format.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `string`

56. `string.trim(s)`
  - Removes whitespace from both ends of a string.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `string`

57. `string.split(s, pattern)`
  - Splits `s` into a table based on `pattern`.
  - Arguments:
    - `s`:
      - R
      - string
    - `pattern`:
      - R
      - string
  - Returns `table`

58. `string.starts_with(s, letter)`
  - Checks if `s` starts with `letter`.
  - Arguments:
    - `s`:
      - R
      - string
    - `letter`:
      - R
      - string
  - Returns `boolean`

59. `string.ends_with(s, letter)`
  - Checks if `s` ends with `letter`.
  - Arguments:
    - `s`:
      - R
      - string
    - `letter`:
      - R
      - string
  - Returns `boolean`

60. `string.pad(s, string_char, length, include_start, include_end)`
  - Adds `string_char` to `s`'s start if `include_start` is true and to its end if `include_end` is true, repeating it `length` times.`
  - Arguments:
    - `s`:
      - R
      - string
    - `string_char`:
      - R
      - string
    - `length`:
      - R
      - number
    - `include_start`:
      - O
      - boolean
    - `include_end`:
      - O
      - boolean
  - Returns `string`

61. `string.capitalize(s)`
  - Capitalizes the first character of a string.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `string`

62. `string.title_case(s, sep)`
  - Capitalizes the first letter of each word in `s` using the specified separator `sep` (default is space).
  - Arguments:
    - `s`:
      - R
      - string
    - `sep`:
      - O
      - string
  - Returns `string`

63. `string.count(s, pattern)`
  - Returns the amount of occurrences `pattern` occurs in `s`.
  - Arguments:
    - `s`:
      - R
      - string
    - `pattern`:
      - R
      - string
  - Returns `string`

64. `string.is_palindrome(s)`
  - Checks if a string reads the same forwards and backwards
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `boolean`

65. `table.contains(t, value)`
  - Recursively checks if `t` contains `value`.
  - Returns (`true`, `number of instances`) or (`false`, `0`)
  - Arguments:
    - `t`:
      - R
      - table
    - `value`:
      - R
      - any
  - Returns `boolean`, `number`

66. `table.csv_to_table(s)`
  - Converts a CSV string (`s`) into a table.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `table`

67. `table.to_csv(t)`
  - Converts a table (`t`) to a CSV string.
  - Arguments:
    - `t`:
      - R
      - table
  - Returns `string`

68. `table.reverse(t)`
  - Reverses the order of elements in `t`.
  - Arguments:
    - `t`:
      - R
      - table
  - Returns `table`

69. `table.shuffle(t, n)`
  - Shuffles the order of elements in `t` `n` times.
  - NOTE: If `n` is not given, `t` will only shuffle once
  - Arguments:
    - `t`:
      - R
      - table
    - `n`:
      - O
      - number
  - Returns `table`

70. `table.count_keys(t)`
  - Counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences.
  - Arguments:
    - `t`:
      - R
      - table
  - Returns `number`, `table`: (key = amount_of_occurrences)

71. `table.deep_count_keys(t, separator)`
  - Recursively counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences.
  - The keys in nested tables are joined using `separator` (defaults to ".")
  - Arguments:
    - `t`:
      - R
      - table
    - `seperator`:
      - O
      - string
  - Returns `number`, `table`: (key = amount_of_occurrences)

72. `table.intersection(t1, t2)`
  - Returns a table containing the similarities between `t1` and `t2`
  - NOTE: This function ONLY works on lists/arrays
  - Arguments:
    - `t1`:
      - R
      - table
    - `t2`:
      - R
      - table
  - Returns `table`

73. `table.difference(t1, t2)`
  - Returns a table containing the differences between `t1` and `t2`
  - NOTE: This function ONLY works on lists/arrays
  - Arguments:
    - `t1`:
      - R
      - table
    - `t2`:
      - R
      - table
  - Returns `table`
 
74. `table.shuffle_randomseed(t, seed, n)`
  - Shuffles the order of elements in `t` `n` times using the randomseed (`seed`)
  - NOTE: If `n` is not given, `t` will only shuffle once
  - Arguments:
    - `t`:
      - R
      - table
    - `seed`:
      - R
      - number
    - `n`:
      - O
      - number
  - Returns `table`

75. `table.keypair_reverse(t)`
  - Returns a reversed key-pair table of `t` in which each `key = value` turns into `value = key`.
  - Arguments:
    - `t`:
      - R
      - table
  - Returns `table`

76. `table.last(t)`
  - Returns the last element in `t`.
  - Arguments:
    - `t`:
      - R
      - table
  - Returns `any`

77. `table.first(t)`
  - Returns the first element in `t`.
  - Arguments:
    - `t`:
      - R
      - table
  - Returns `any`

78. `table.copy(t)`
  - Returns a copy of the table `t`.
  - Arguments:
    - `t`:
      - R
      - table
  - Returns `table`

79. `input.string(message)`
  - Gets string input with an optional print `message`.
  - Arguments:
    - `message`:
      - O
      - string
  - Returns `string`

80. `input.table(number_of_inputs, message)`
  - Returns a table with `number_of_inputs` string inputs with an optional print `message`.
  - Arguments:
    - `number_of_inputs`:
      - R
      - number
    - `message`:
      - O
      - string
  - Returns `string`

81. `input.number(message)`
  - Gets numeric input with an optional print `message`.
  - Arguments:
    - `message`:
      - O
      - string
  - Returns `number`

82. `input.number_table(number_of_inputs, message)`
  - Returns a table with `number_of_inputs` numeric inputs with an optional print `message`.
  - Arguments:
    - `number_of_inputs`:
      - R
      - number
    - `message`:
      - O
      - string
  - Returns `string`

83. `input.loop(message)`
  - Returns a table of string inputs until empty submission with an optional print `message`.
  - Arguments:
    - `message`:
      - O
      - string
  - Returns `table`

84. `input.number_loop(message)`
  - Returns a table of numeric inputs until empty submission with an optional print `message`.
  - Arguments:
    - `message`:
      - O
      - string
  - Returns `table`

85. `cryptography.text_to_ascii(s)`
  - Converts plaintext to ASCII code numbers.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `s`

86. `cryptography.ascii_to_text(s)`
  - Converts ASCII code numbers to plaintext.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `s`

87. `cryptography.text_to_hex(s)`
  - Converts plaintext to hexadecimal.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `s`

88. `cryptography.hex_to_text(s)`
  - Converts hexadecimal to text.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `s`

89. `cryptography.text_to_binary(s, x)`
  - Converts plaintext to binary (`x` bits).
  - `x` defaults to `8` if not given.
  - Arguments:
    - `s`:
      - R
      - string
    - `x`:
      - O
      - number
  - Returns `s`

90. `cryptography.binary_to_text(s, x)`
  - Converts binary (`x` bits) to plaintext.
  - `x` defaults to `8` if not given.
  - Arguments:
    - `s`:
      - R
      - string
    - `x`:
      - O
      - number
  - Returns `s`

91. `cryptography.text_to_octal(s)`
  - Converts plaintext to space-seperated octal.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `s`

92. `cryptography.octal_to_text(s)`
  - Converts space-seperated octal to plaintext.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `s`

93. `cryptography.text_to_morse(s)`
  - Converts plaintext to morse code.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `s`

94. `cryptography.morse_to_text(s)`
  - Converts morse code to plaintext.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `s`

95. `cryptography.text_to_base64(s)`
  - Converts plaintext to base64.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `s`

96. `cryptography.base64_to_text(s)`
  - Converts base64 to plaintext.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `s`

97. `cryptography.text_to_base32(s)`
  - Converts plaintext to base32.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `s`

98. `cryptography.base32_to_text(s)`
  - Converts base32 to plaintext.
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `s`

99. `cryptography.xor(s, key)`
  - Performs XOR encryption/decryption on `s` using `key`
  - Note: XOR is symmetric - use the same key to decrypt
  - Arguments:
    - `s`:
      - R
      - string
    - `key`:
      - R
      - string
  - Returns `s`

100. `cryptography.caesar_cipher(s, shift)`
  - Applies Caesar cipher encryption to `s` with specified `shift`.
  - Arguments:
    - `s`:
      - R
      - string
    - `shift`:
      - R
      - number
  - Returns `s`

101. `cryptography.rot13(s)`
  - Applies ROT13 encryption on `s` (Caesar cipher with shift of 13).
  - Arguments:
    - `s`:
      - R
      - string
  - Returns `s`

102. `cryptography.uuid_v4()`
  - Generates a random UUID (version 4)
  - UUID V4 format: `xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`
  - `x`: 0-9 and a-f
  - Hyphens (-) separate sections
  - The `4` in the third section indicates it's a version 4 UUID
  - `y`: 8, 9, a, or b
  - Arguments:
    - None
  - Returns `string`

103. `cryptography.bswap(x)`
  - Performs bitwise SWAP operation on `x`.
  - Arguments:
    - `x`:
      - R
      - number
  - Returns `number`

104. `cryptography.rol(x, disp)`
  - Performs a bitwise left rotation on `x` by specified positions (`disp`).
  - Arguments:
  - `x`:
    - R
    - number
  - `disp`:
    - R
    - number
  - Returns `number`

105. `cryptography.ror(x, disp)`
  - Performs a bitwise right rotation on `x` by specified positions (`disp`).
  - Arguments:
  - `x`:
    - R
    - number
  - `disp`:
    - R
    - number
  - Returns `number`

106. `cryptography.number_to_bit(x)`
  - Converts `x` to its binary representation.
  - Arguments:
  - `x`:
    - R
    - number
  - Returns `string`

106. `cryptography.number_to_hex(x)`
  - Converts `x` to its hexadecimal representation.
  - Arguments:
  - `x`:
    - R
    - number
  - Returns `string`

107. `cryptography.btest(a, b)`
  - Returns a boolean signaling whether the bitwise AND of its operands is different from zero.
  - Arguments:
  - `a`:
    - R
    - number
  - `b`:
    - R
    - number
  - Returns `boolean`

108. `cryptography.extract(n, field, width)`
  - Returns the unsigned number formed by the bits `field` to `field + width - 1` from `n`.
  - Arguments:
    - `n`:
      - R
      - number
    - `field`:
      - R
      - number
    - `width`
      - O
      - number
  - Returns `number`

109. `cryptography.replace(n, v, field, width)`
  - Returns a copy of `n` with the bits `field` to `field + width - 1` replaced by the value `v`.
  - Arguments:
    - `n`:
      - R
      - number
    - `v`:
      - R
      - number
    - `field`:
      - R
      - number
    - `width`:
      - O
      - number
  - Returns `number`

110. `color.rgb_to_hex(rgb)`
  - Converts RGB(`r`,`g`,`b`) to HEX(`RRGGBB`)
  - Type: `function`
  - Arguments:
    - `r`:
      - R
      - number

111. `color.rgb_to_hsv(rgb)`
  - Converts RGB(`r`,`g`,`b`) to HSV(`h`,`s`,`v`)

112. `color.hex_to_rgb(hex)`
  - Converts HEX(`RRGGBB`) to RGB(`r`,`g`,`b`)

113. `color.hex_to_hsv(hex)`
  - Converts HEX(`RRGGBB`) to hsv(`h`,`s`,`v`)

114. `color.hsv_to_rgb(hsv)`
  - Converts HSV(`h`,`s`,`v`) to RGB(`r`,`g`,`b`)

115. `color.hsv_to_hex(hsv)`
  - Converts HSV(`h`,`s`,`v`) to HEX(`RRGGBB`)

116. `remote.register(name, func)`
  - Registers a function under the given `name`. When `remote.call()` is called with this `name`, the registered `func` will be executed.

117. `remote.unregister(name)`
  - Removes the function registered under the given `name`, making it unavailable for `remote.call()`.

118. `remote.call(name)`
  - Calls the function registered under the given `name` and returns its result (if any).

119. `wait(x)`
  - Yields the code for `x` seconds. (Similar to python's wait function).

120. `is_type(value, type_of_object)`
  - Checks if `value` is a `type_of_object`.

121. `benchmark(func, iterations)`
  - Runs `func` `iterations` times.

122. `execution_time(func)`
  - Runs `func` and returns the time it takes to run `func`.

123. `delay(t, func)`
  - Yields `t` seconds before running `func` without stopping other code.

124. `delay_stop(t, func)`
  - Yields `t` seconds before running `func` while stopping other code.