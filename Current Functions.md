1. `math.average(t)`
  - Calculates the average from a list of numbers.

2. `math.median(t)`
  - Finds middle value in list. For even-length lists, averages two middle values.

3. `math.range(t)`
  - Calculates the range from a list of numbers.

4. `math.mode(t)`
  - Calculates the mode from a list of numbers.

5. `math.standard_deviation(t)`
  - Calculates the standard deviation from a list of numbers.

6. `math.sum(t)`
  - Calculates the sum from a list of numbers.

7. `math.gcd(x, y)`
  - Finds the greatest common factor between `x` and `y`.

8. `math.lcm(x, y)`
  - Finds the least common multiple between `x` and `y`.

9. `math.is_prime(x)`
  - Checks if `x` is a prime number.

10. `math.quadratic(a, b, c)`
  - Solves a quadratic equation in the form `a`x² + `b`x + `c` using the quadratic formula.

11. `math.aos(a, b)`
  - Calculates the axis of symmetry for a quadratic function using `a` and `b` coefficients.

12. `math.vertex(a, b, c)`
  - Calculates the vertex point of a quadratic function using `a`, `b`, and `c` coefficients.

13. `math.sinh(x)`
  - Calculates the hyperbolic sine of `x`.

14. `math.cosh(x)`
  - Calculates the hyperbolic cosine of `x`.

15. `math.tanh(x)`
  - Calculates the hyperbolic tangent of `x`.

16. `math.asinh(x)`
  - Calculates the inverse hyperbolic sine of `x`.

17. `math.acosh(x)`
  - Calculates the inverse hyperbolic cosine of `x`.

18. `math.atanh(x)`
  - Calculates the inverse hyperbolic tangent of `x`.

19. `math.round(x, precision)`
  - Rounds `x` to `precision` decimal places (whole number if no precision given).

20. `math.fib(n)`
  - Calculates the `n`th term of the Fibonacci Sequence.

21. `math.is_odd(x)`
  - Checks if `x` is an odd number.

22. `math.is_even(x)`
  - Checks if `x` is an even number.

23. `math.is_perfect_square(x)`
  - Checks if `x` has a whole number square root

24. `math.factorial(x)`
  - Calculates the factorial of `x`

25. `math.factors(x)`
  - Returns all factors of `x`

26. `math.is_perfect(x)`
  - Checks if `x` is perfect (sum of factors equals the number)

27. `math.is_deficient(x)`
  - Checks if `x` is deficient (sum of factors less than number)

28. `math.is_abundant(x)`
  - Checks if `x` is abundant (sum of factors greater than number)

29. `math.classify_number(x)`
  - Classifies `x` as Perfect, Deficient, or Abundant

30. `math.z_score(x, t)`
  - Calculates the z-score of `x` in a dataset (`t`)

31. `math.permutation(x, r)`
  - Calculates the number of ways to arrange `r` items from `x` items

32. `math.combination(x, r)`
  - Calculates the number of ways to choose `r` items from `x` items

33. `math.secant(x)`
  - Calculates the secant of `x`

34. `math.cosecant(x)`
  - Calculates the cosecant of `x`

35. `math.cotangent(x)`
  - Calculates the cotangent of `x`

36. `math.asecant(x)`
  - Calculates the inverse secant of `x`

37. `math.acosecant(x)`
  - Calculates the inverse cosecant of `x`

38. `math.acotangent(x)`
  - Calculates the inverse cotangent of `x`

39. `math.midpoint(x, y)`
    - Calculates the midpoint between `x` and `y`

40. `math.is_whole(x)`
  - Checks if `x` is a whole number

41. `string.clean_number(s)`
  - `tonumber()` conversion but better. Properly cleans a string (`s`) to ensure it's in a valid number format.

42. `string.trim(s)`
  - Removes whitespace from both ends of a string.

43. `string.split(s, pattern)`
  - Splits `s` into a table based on `pattern`.

44. `string.starts_with(s, letter)`
  - Checks if `s` starts with `letter`.

45. `string.ends_with(s, letter)`
  - Checks if `s` ends with `letter`.

46. `string.pad(s, string_char, length, include_start, include_end)`
  - Adds `string_char` to `s`'s start if `include_start` is true and to its end if `include_end` is true, repeating it `length` times.`

47. `string.capitalize(s)`
  - Capitalizes the first character of a string.

48. `string.title_case(s, sep)`
  - Capitalizes the first letter of each word in `s` using the specified separator `sep` (default is space).

49. `string.count(s, pattern)`
  - Returns the amount of occurrences `pattern` occurs in `s`.

50. `string.is_palindrome(s)`
  - Checks if a string reads the same forwards and backwards

51. `table.contains(t, value)`
  - Recursively checks if `t` contains `value`.

52. `table.csv_to_table(s)`
  - Converts a CSV string (`s`) into a table.

53. `table.to_csv(t)`
  - Converts a table (`t`) to a CSV string.

54. `table.reverse(t)`
  - Reverses the order of elements in `t`.

55. `table.shuffle(t, n)`
  - Shuffles the order of elements in `t` `n` times.

56. `table.count_keys(t)`
  - Counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences.

57. `table.deep_count_keys(t, separator)`
  - Recursively counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences.

58. `table.intersection(t1, t2)`
  - Returns a table containing the similarities between `t1` and `t2`

59. `table.difference(t1, t2)`
  - Returns a table containing the differences between `t1` and `t2`
 
60. `table.shuffle_randomseed(t, seed, n)`
  - Shuffles the order of elements in `t` once using the randomseed (`seed`)

61. `table.keypair_reverse(t)`
  - Returns a reversed key-pair table of `t` in which each `key = value` turns into `value = key`.

62. `table.last(t)`
  - Returns the last element in `t`.

63. `table.first(t)`
  - Returns the first element in `t`.

64. `input.string(message)`
  - Gets string input with an optional print `message`.

65. `input.table(message, number_of_inputs)`
  - Collects `number_of_inputs` strings with an optional print `message`.

66. `input.number(message)`
  - Gets validated numeric input with an optional print `message`.

67. `input.number_table(message, number_of_inputs)`
  - Collects `number_of_inputs` numbers with an optional print `message`.

68. `input.loop(message)` / `input.number_loop(message)`
  - Collects inputs until empty submission with an optional print `message`.

69. `cryptography.text_to_ascii(s)`
  - Converts plaintext to ASCII code numbers.

70. `cryptography.ascii_to_text(s)`
  - Converts ASCII code numbers to plaintext.

71. `cryptography.text_to_hex(s)`
  - Converts plaintext to hexadecimal.

72. `cryptography.hex_to_text(s)`
  - Converts hexadecimal to text.

73. `cryptography.text_to_binary(s)`
  - Converts plaintext to binary.

74. `cryptography.binary_to_text(s)`
  - Converts binary to plaintext.

75. `cryptography.text_to_octal(s)`
  - Converts plaintext to octal.

76. `cryptography.octal_to_text(s)`
  - Converts octal to plaintext.

77. `cryptography.text_to_morse(s)`
  - Converts plaintext to morse code.

78. `cryptography.morse_to_text(s)`
  - Converts morse code to plaintext.

79. `cryptography.text_to_base64(s)`
  - Converts plaintext to base64.

80. `cryptography.base64_to_text(s)`
  - Converts base64 to plaintext.

81. `cryptography.text_to_base32(s)`
  - Converts plaintext to base32.

82. `cryptography.base32_to_text(s)`
  - Converts base32 to plaintext.

83. `cryptography.xor(s, key)`
  - Performs XOR encryption/decryption on `s` using a `key`.

84. `cryptography.caesar_cipher(s, shift)`
  - Applies Caesar cipher encryption to `s` with specified `shift`.

85. `cryptography.rot13(s)`
  - Applies ROT13 encryption on `s` (Caesar cipher with shift of 13).

86. `cryptography.uuid_v4()`
  - Generates a random UUID (version 4)

87. `cryptography.bswap(x)`
  - Performs bitwise SWAP operation on `x`.

88. `cryptography.rol(x, disp)`
  - Performs a bitwise left rotation on `x` by specified positions (`disp`).

89. `cryptography.ror(x, disp)`
  - Performs a bitwise right rotation on `x` by specified positions (`disp`).

90. `cryptography.number_to_bit(x)`
  - Converts `x` to its binary representation.

91. `cryptography.number_to_hex(x)`
  - Converts `x` to its hexadecimal representation.

92. `cryptography.btest(a, b)`
  - Returns a boolean signaling whether the bitwise AND of its operands is different from zero.

93. `cryptography.extract(n, field, width)`
  - Returns the unsigned number formed by the bits `field` to `field + width - 1` from `n`.

94. `cryptography.replace(n, v, field, width)`

95. `wait(x)`
  - Yields the code for `x` seconds. (Similar to python's wait function).

96. `is_type(value, type_of_object)`
  - Checks if `value` is a `type_of_object`.

97. `benchmark(func, iterations)`
  - Runs `func` `iterations` times.

98. `execution_time(func)`
  - Runs `func` and returns the time it takes to run `func`.

99. `delay(t, func)`
  - Yields `t` seconds before running `func` without stopping other code.

100. `delay_stop(t, func)`
  - Yields `t` seconds before running `func` while stopping other code.