1. `ult.version`
  - The version of Useful Lua Tools
  - "Major Update"."Minor Update"."Patch"

2. `ult.contributors`
  - The people who contributed to Useful Lua Tools

3. `ult.min_lua_ver`
  - The minimum version of Lua required to run Useful Lua Tools

4. `ult.release_date`
  - The release date of the current ULT version

5. `ult.build`
  - The current build of Useful Lua Tools
  - `Project` - `version` - `date of release` - `minimum lua version`

6. `system.os`
  - The OS the system is running on, or nil if it cannot be determined
  - `Windows` | `Linux` | `MacOS` | `ChromeOS`

7. `system.is_windows`
  - true if the host system is running on Windows, false otherwise

8. `system.is_mac`
  - true if the host system is running on MacOS, false otherwise

9. `system.is_linux`
  - true if the host system is running on Linux, false otherwise

10. `system.is_chrome`
  - true if the host system is running on Chrome OS, false otherwise

11. `system.uname`
  - The system Unix Name, or nil if it cannot be determined

12. `system.cores`
  - Amount of CPU Cores the host system has, or nil if it cannot be determined

13. `system.architecture`
  - The CPU architecture of the host system, or nil if it cannot be determined

14. `system.is_linux_based`
  - true if the host system is built on Linux, false otherwise

15. `math.average(t)`
  - Calculates the average from a list of numbers.

16. `math.median(t)`
  - Finds middle value in list. For even-length lists, averages two middle values.

17. `math.range(t)`
  - Calculates the range from a list of numbers.

18. `math.mode(t)`
  - Calculates the mode from a list of numbers.

19. `math.standard_deviation(t)`
  - Calculates the standard deviation from a list of numbers.

20. `math.sum(t)`
  - Calculates the sum from a list of numbers.

21. `math.gcd(x, y)`
  - Finds the greatest common factor between `x` and `y`.

22. `math.lcm(x, y)`
  - Finds the least common multiple between `x` and `y`.

23. `math.is_prime(x)`
  - Checks if `x` is a prime number.

24. `math.quadratic(a, b, c)`
  - Solves a quadratic equation in the form `a`x² + `b`x + `c` using the quadratic formula.

25. `math.aos(a, b)`
  - Calculates the axis of symmetry for a quadratic function using `a` and `b` coefficients.

26. `math.vertex(a, b, c)`
  - Calculates the vertex point of a quadratic function using `a`, `b`, and `c` coefficients.

27. `math.sinh(x)`
  - Calculates the hyperbolic sine of `x`.

28. `math.cosh(x)`
  - Calculates the hyperbolic cosine of `x`.

29. `math.tanh(x)`
  - Calculates the hyperbolic tangent of `x`.

30. `math.asinh(x)`
  - Calculates the inverse hyperbolic sine of `x`.

31. `math.acosh(x)`
  - Calculates the inverse hyperbolic cosine of `x`.

32. `math.atanh(x)`
  - Calculates the inverse hyperbolic tangent of `x`.

33. `math.round(x, precision)`
  - Rounds `x` to `precision` decimal places (whole number if no precision given).

34. `math.fib(n)`
  - Calculates the `n`th term of the Fibonacci Sequence.

35. `math.is_odd(x)`
  - Checks if `x` is an odd number.

36. `math.is_even(x)`
  - Checks if `x` is an even number.

37. `math.is_perfect_square(x)`
  - Checks if `x` has a whole number square root

38. `math.factorial(x)`
  - Calculates the factorial of `x`

39. `math.factors(x)`
  - Returns all factors of `x`

40. `math.is_perfect(x)`
  - Checks if `x` is perfect (sum of factors equals the number)

41. `math.is_deficient(x)`
  - Checks if `x` is deficient (sum of factors less than number)

42. `math.is_abundant(x)`
  - Checks if `x` is abundant (sum of factors greater than number)

43. `math.classify_number(x)`
  - Classifies `x` as Perfect, Deficient, or Abundant

44. `math.z_score(x, t)`
  - Calculates the z-score of `x` in a dataset (`t`)

45. `math.permutation(x, r)`
  - Calculates the number of ways to arrange `r` items from `x` items

46. `math.combination(x, r)`
  - Calculates the number of ways to choose `r` items from `x` items

47. `math.secant(x)`
  - Calculates the secant of `x`

48. `math.cosecant(x)`
  - Calculates the cosecant of `x`

49. `math.cotangent(x)`
  - Calculates the cotangent of `x`

50. `math.asecant(x)`
  - Calculates the inverse secant of `x`

51. `math.acosecant(x)`
  - Calculates the inverse cosecant of `x`

52. `math.acotangent(x)`
  - Calculates the inverse cotangent of `x`

53. `math.midpoint(x, y)`
    - Calculates the midpoint between `x` and `y`

54. `math.is_whole(x)`
  - Checks if `x` is a whole number

55. `string.clean_number(s)`
  - `tonumber()` conversion but better. Properly cleans a string (`s`) to ensure it's in a valid number format.

56. `string.trim(s)`
  - Removes whitespace from both ends of a string.

57. `string.split(s, pattern)`
  - Splits `s` into a table based on `pattern`.

58. `string.starts_with(s, letter)`
  - Checks if `s` starts with `letter`.

59. `string.ends_with(s, letter)`
  - Checks if `s` ends with `letter`.

60. `string.pad(s, string_char, length, include_start, include_end)`
  - Adds `string_char` to `s`'s start if `include_start` is true and to its end if `include_end` is true, repeating it `length` times.`

61. `string.capitalize(s)`
  - Capitalizes the first character of a string.

62. `string.title_case(s, sep)`
  - Capitalizes the first letter of each word in `s` using the specified separator `sep` (default is space).

63. `string.count(s, pattern)`
  - Returns the amount of occurrences `pattern` occurs in `s`.

64. `string.is_palindrome(s)`
  - Checks if a string reads the same forwards and backwards

65. `table.contains(t, value)`
  - Recursively checks if `t` contains `value`.

66. `table.csv_to_table(s)`
  - Converts a CSV string (`s`) into a table.

67. `table.to_csv(t)`
  - Converts a table (`t`) to a CSV string.

68. `table.reverse(t)`
  - Reverses the order of elements in `t`.

69. `table.shuffle(t, n)`
  - Shuffles the order of elements in `t` `n` times.

70. `table.count_keys(t)`
  - Counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences.

71. `table.deep_count_keys(t, separator)`
  - Recursively counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences.

72. `table.intersection(t1, t2)`
  - Returns a table containing the similarities between `t1` and `t2`

73. `table.difference(t1, t2)`
  - Returns a table containing the differences between `t1` and `t2`
 
74. `table.shuffle_randomseed(t, seed, n)`
  - Shuffles the order of elements in `t` once using the randomseed (`seed`)

75. `table.keypair_reverse(t)`
  - Returns a reversed key-pair table of `t` in which each `key = value` turns into `value = key`.

76. `table.last(t)`
  - Returns the last element in `t`.

77. `table.first(t)`
  - Returns the first element in `t`.

78. `table.copy(t)`
  - Returns a copy of the table `t`.

79. `input.string(message)`
  - Gets string input with an optional print `message`.

80. `input.table(message, number_of_inputs)`
  - Returns a table with `number_of_inputs` string inputs with an optional print `message`.

81. `input.number(message)`
  - Gets numeric input with an optional print `message`.

82. `input.number_table(message, number_of_inputs)`
  - Returns a table with `number_of_inputs` numberic inputs with an optional print `message`.

83. `input.loop(message)`
  - Returns a table of string inputs until empty submission with an optional print `message`.

84. `input.number_loop(message)`
  - Returns a table of numeric inputs until empty submission with an optional print `message`.

85. `cryptography.text_to_ascii(s)`
  - Converts plaintext to ASCII code numbers.

86. `cryptography.ascii_to_text(s)`
  - Converts ASCII code numbers to plaintext.

87. `cryptography.text_to_hex(s)`
  - Converts plaintext to hexadecimal.

88. `cryptography.hex_to_text(s)`
  - Converts hexadecimal to text.

89. `cryptography.text_to_binary(s)`
  - Converts plaintext to binary.

90. `cryptography.binary_to_text(s)`
  - Converts binary to plaintext.

91. `cryptography.text_to_octal(s)`
  - Converts plaintext to octal.

92. `cryptography.octal_to_text(s)`
  - Converts octal to plaintext.

93. `cryptography.text_to_morse(s)`
  - Converts plaintext to morse code.

94. `cryptography.morse_to_text(s)`
  - Converts morse code to plaintext.

95. `cryptography.text_to_base64(s)`
  - Converts plaintext to base64.

96. `cryptography.base64_to_text(s)`
  - Converts base64 to plaintext.

97. `cryptography.text_to_base32(s)`
  - Converts plaintext to base32.

98. `cryptography.base32_to_text(s)`
  - Converts base32 to plaintext.

99. `cryptography.xor(s, key)`
  - Performs XOR encryption/decryption on `s` using a `key`.

100. `cryptography.caesar_cipher(s, shift)`
  - Applies Caesar cipher encryption to `s` with specified `shift`.

101. `cryptography.rot13(s)`
  - Applies ROT13 encryption on `s` (Caesar cipher with shift of 13).

102. `cryptography.uuid_v4()`
  - Generates a random UUID (version 4)

103. `cryptography.bswap(x)`
  - Performs bitwise SWAP operation on `x`.

104. `cryptography.rol(x, disp)`
  - Performs a bitwise left rotation on `x` by specified positions (`disp`).

105. `cryptography.ror(x, disp)`
  - Performs a bitwise right rotation on `x` by specified positions (`disp`).

106. `cryptography.number_to_bit(x)`
  - Converts `x` to its binary representation.

106. `cryptography.number_to_hex(x)`
  - Converts `x` to its hexadecimal representation.

107. `cryptography.btest(a, b)`
  - Returns a boolean signaling whether the bitwise AND of its operands is different from zero.

108. `cryptography.extract(n, field, width)`
  - Returns the unsigned number formed by the bits `field` to `field + width - 1` from `n`.

109. `cryptography.replace(n, v, field, width)`
  - Returns a copy of `n` with the bits `field` to `field + width - 1` replaced by the value `v`.

110. `color.rgb_to_hex(rgb)`
  - Converts RGB(`r`,`g`,`b`) to HEX(`RRGGBB`)

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

116. `wait(x)`
  - Yields the code for `x` seconds. (Similar to python's wait function).

117. `is_type(value, type_of_object)`
  - Checks if `value` is a `type_of_object`.

118. `benchmark(func, iterations)`
  - Runs `func` `iterations` times.

119. `execution_time(func)`
  - Runs `func` and returns the time it takes to run `func`.

120. `delay(t, func)`
  - Yields `t` seconds before running `func` without stopping other code.

121. `delay_stop(t, func)`
  - Yields `t` seconds before running `func` while stopping other code.