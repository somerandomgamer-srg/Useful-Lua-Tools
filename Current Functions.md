# SRG Library Documentation

## Math Library Extensions
1. `math.average(t)`
    - Calculates arithmetic mean from a list of numbers.

2. `math.median(t)`
    - Finds middle value in sorted list. For even-length lists, averages two middle values.

3. `math.range(t)`
    - Calculates the range from a list of numbers.

4. `math.mode(t)`
    - Calculates the mode from a list of numbers.

5. `math.standard_deviation(t)`
    - Calculates the standard deviation from a list of numbers.

6. `math.sum(t)`
    - Calculates the sum from a list of numbers.

7. `math.gcd(x, y)`
    - Finds the greatest common factor between 2 numbers (`x` and `y`).

8. `math.lcm(x, y)`
    - Finds the least common multiple between 2 numbers (`x` and `y`).

9. `math.is_prime(x)`
    - Checks if a number (`x`) is a prime number.
  
10. `math.quadratic(a, b, c)`
    - Solves a quadratic equation in the form ax² + bx + c using the quadratic formula.

11. `math.aos(a, b)`
    - Calculates the axis of symmetry for a quadratic function using `a` and `b` coefficients.

12. `math.vertex(a, b, c)`
    - Calculates the vertex point of a quadratic function using `a`, `b`, and `c` coefficients.

13. `math.sinh(x)`
    - Calculates the hyperbolic sine of x.

14. `math.cosh(x)`
    - Calculates the hyperbolic cosine of x.

15. `math.tanh(x)`
    - Calculates the hyperbolic tangent of x.

16. `math.asinh(x)`
    - Calculates the inverse hyperbolic sine of x.
  
17. `math.acosh(x)`
    - Calculates the inverse hyperbolic cosine of x.

18. `math.atanh(x)`
    - Calculates the inverse hyperbolic tangent of x.

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

## String Library Extensions
39. `string.clean_number(s)`
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

40. `string.trim(s)`
    - Removes whitespace from both ends of a string.

41. `string.split(s, pattern)`
    - Splits `s` into a table based on `pattern`.

42. `string.starts_with(s, letter)`
    - Checks if `s` starts with `letter`.

43. `string.ends_with(s, letter)`
    - Checks if `s` ends with `letter`.

44. `string.pad(s, string_char, length, include_start, include_end)`
    - Adds `string_char` to `s`'s start if `include_start` is true and to its end if `include_end` is true, repeating it `length` times.

45. `string.capitalize(s)`
    - Capitalizes the first character of a string.

46. `string.title_case(s, sep)`
    - Capitalizes the first letter of each word in `s` using the specified separator `sep` (default is space).

47. `string.count(s, pattern)`
    - Returns the amount of occurrences `pattern` occurs in `s`.

48. `string.is_palindrome(s)`
    - Checks if a string reads the same forwards and backwards

## Table Library Extensions
49. `table.contains(t, value)`
    - Recursively checks if `t` contains `value`.
    - Returns (`true`, `number of instances`) or (`false`, `0`).

50. `table.csv_to_table(s)`
    - Converts a CSV string (`s`) into a table.

51. `table.to_csv(t)`
    - Converts a table (`t`) to a CSV string.

52. `table.reverse(t)`
    - Reverses the order of elements in `t`.

53. `table.shuffle(t, n)`
    - Shuffles the order of elements in `t` `n` times.

54. `table.count_keys(t)`
    - Counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences.

55. `table.deep_count_keys(t, separator)`
    - Recursively counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences.

56. `table.intersection(t1, t2)`
    - Returns a table containing the similarities between `t1` and `t2`

57. `table.difference(t1, t2)`
    - Returns a table containing the differences between `t1` and `t2`
  
58. `table.shuffle_randomseed(t, seed, n)`
    - Shuffles the order of elements in `t` `n` times using the randomseed (`seed`)

## Input Library
59. `input.string(message)`
    - Gets string input.

60. `input.table(message, number_of_inputs)`
    - Collects multiple strings.

61. `input.number(message)`
    - Gets validated numeric input.

62. `input.number_table(message, number_of_inputs)`
    - Collects multiple numbers.

63. `input.loop(message)` / `input.number_loop(message)`
    - Collects inputs until empty submission.

## Cryptography Library
64. `cryptography.text_to_ascii(s)`
    - Converts a string from plaintext to ASCII code numbers.

65. `cryptography.ascii_to_text(s)`
    - Converts ASCII code numbers back to text.

66. `cryptography.text_to_hex(s)`
    - Converts a string from plaintext to hexadecimal.

67. `cryptography.hex_to_text(s)`
    - Converts hexadecimal back to text.

68. `cryptography.text_to_binary(s)`
    - Converts a string from plaintext to binary.
  
69. `cryptography.binary_to_text(s)`
    - Converts binary back to text.

70. `cryptography.text_to_morse(s)`
    - Converts plaintext to morse code.

71. `cryptography.morse_to_text(s)`
    - Converts morse code back to plaintext.

72. `cryptography.xor(s, key)`
    - Performs XOR encryption/decryption on a string using a key.

73. `cryptography.caesar_cipher(s, shift)`
    - Applies Caesar cipher encryption to a string with specified shift.

74. `cryptography.rot13(s)`
    - Applies ROT13 encryption (Caesar cipher with shift of 13).

75. `cryptography.uuid_v4()`
    - Generates a random UUID (version 4)
  
76. `cryptography.bswap(x)`
    - Performs bitwise SWAP operation.
  
77. `cryptography.rol(x, disp)`
    - Performs a bitwise left rotation by specified positions.
  
78. `cryptography.ror(x, disp)`
    - Performs a bitwise right rotation by specified positions.
  
79. `cryptography.number_to_bit(x)`
    - Converts a number to a 32-bit integer.
  
80. `cryptography.number_to_hex(x)`
    - Converts a number to its hexadecimal representation.
  
81. `cryptography.btest(a, b)`
    - Tests if bitwise AND of operands is non-zero.
  
82. `cryptography.extract(n, field, width)`
    - Extracts bits from a number.

83. `cryptography.replace(n, v, field, width)`
    - Replaces bits in a number with another value.

## Global Functions
84. `wait(x)`
    - Yields the code for `x` seconds. (Similar to python's wait function)

85. `is_type(value, type_of_object)`
    - Checks if `value` is a `type_of_object`

86. `benchmark(func, iterations)`
    - Runs `func` `iterations` times

87. `execution_time(func)`
    - Runs `func` and returns the time it takes to run `func`

88. `delay(t, func)`
    - Yields `t` seconds before running `func` without stopping other code.

89. `delay_stop(t, func)`
    - Yields `t` seconds before running `func` while stopping other code.