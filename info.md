# Extensions
## Math Library
1. math.average(t): Calculates arithmetic mean from a list of numbers. Sums all numbers and divides by count.
2. math.median(t): Finds the middle value in a sorted list. For even-length lists, averages the two middle values.
3. math.range(t): Calculates the difference between the maximum and minimum values in a dataset.
4. math.mode(t): Finds the most frequently occurring value in a dataset.
5. math.standard_deviation(t): Measures data spread. Calculates square root of average squared deviations from mean.
6. math.sum(t): Calculates total by adding all numbers in a table.
7. math.gcd(x, y): Finds largest number that divides both x and y without remainder.
8. math.is_prime(x): Returns true if number is only divisible by 1 and itself.
9. math.lcm(x, y): Finds smallest positive number divisible by both x and y.
10. math.quadratic(a, b, c): Solves ax² + bx + c = 0 using quadratic formula, returns two roots.
11. math.aos(a, b): Calculates x-coordinate of vertex (-b/2a) for quadratic functions.
12. math.vertex(a, b, c): Returns (x,y) coordinates of quadratic function's highest/lowest point.
13. math.sinh(x): Calculates hyperbolic sine
14. math.cosh(x): Calculates hyperbolic cosine
15. math.tanh(x): Calculates hyperbolic tangent
16. math.acosh(x): Calculates inverse hyperbolic cosine
17. math.atanh(x): Calculates inverse hyperbolic tangent
18. math.asinh(x): Calculates inverse hyperbolic sine
19. math.round(x, precision): Rounds number to specified decimal places. If no precision given, rounds to whole number.
20. math.fibonacci(n): Generates the nth Fibonacci number using recursive calculation.
21. math.is_odd(x): Returns true if number divided by 2 has remainder of 1.
22. math.is_even(x): Returns true if number is divisible by 2 with no remainder.

## String Library
1. string.clean_number(s): Removes non-numeric characters except decimal points and minus signs. Handles multiple decimals by keeping first one.
2. string.trim(s): Removes whitespace from both ends of a string.
3. string.split(s, pattern): Creates table by splitting string at each occurrence of pattern.
4. string.starts_with(s, letter): Returns true if string's first character matches given letter.
5. string.ends_with(s, letter): Returns true if string's last character matches given letter.
6. string.pad(s, string_char, length, include_start, include_end): Adds padding characters to start/end of string to reach desired length.
7. string.capitalize(s): Makes first character uppercase, leaves rest unchanged.
8. string.title_case(s): Capitalizes first letter of each word using specified separator (default space).
9. string.count(s, pattern): Returns number of times pattern appears in string.

## Table Library
1. table.contains(t, value): Recursively searches table for value, returns (found/not found, count of instances).
2. table.csv_to_table(s): Parses CSV string into table. Handles quoted fields, commas within fields.
3. table.to_csv(t): Converts table to CSV string. Properly handles values with commas, quotes, newlines.
4. table.reverse(t): Creates new table with elements in reverse order.
5. table.shuffle(t): Randomly reorders elements using Fisher-Yates algorithm.
6. table.deep_count_keys(t, separator): Counts keys in nested tables, returns flattened path count using separator (default ".").

# Libraries I Made
## Input Library
1. input.string(message): Gets single string input with optional prompt message.
2. input.table(message, number_of_inputs): Collects multiple string inputs, numbers each prompt.
3. input.number(message): Gets numeric input, validates and cleans input, returns 0 if invalid.
4. input.number_table(message, number_of_inputs): Collects multiple numeric inputs with validation.
5. input.loop(message): Collects string inputs until empty submission.
6. input.number_loop(message): Collects numeric inputs until empty submission, validates each.

## Cryptography Library
### Conversion
1. text_to_ascii(s): Converts text to space-separated ASCII codes
2. ascii_to_text(s): Converts space-separated ASCII codes back to text
3. text_to_hex(s): Converts text to hexadecimal representation
4. hex_to_text(s): Converts hexadecimal back to text
5. text_to_binary(s): Converts text to space-separated 8-bit binary
6. binary_to_text(s): Converts space-separated binary back to text
7. text_to_morse(s): Converts text to morse code using dots and dashes
8. morse_to_text(s): Converts morse code back to text

### Bitwise Operations
9. bswap(x): Swaps byte order in 32-bit integer
10. rol(x, disp): Rotates bits left by specified positions
11. ror(x, disp): Rotates bits right by specified positions
12. number_to_bit(x): Normalizes number to 32-bit integer range
13. number_to_hex(x): Converts number to hexadecimal string
14. btest(a, b): Tests if bitwise AND of values is non-zero
15. extract(n, field, width): Extracts bit field from number
16. rrotate(x, disp): Right rotation with negative displacement handling
17. lrotate(x, disp): Left rotation with negative displacement handling
18. replace(n, v, field, width): Replaces bits in specific field

### Encryption/Decryption
19. xor(s, key): XOR encryption/decryption using provided key
20. caesar_cipher(s, shift): Shifts letters by specified amount
21. rot13(s): Caesar cipher with fixed 13-character shift

# Global Functions
1. wait(x): Pauses code execution for specified seconds
2. is_type(value, type_of_object): Type checking function returning boolean
3. benchmark(func, iterations): Measures average and total execution time
4. execution_time(func): Measures single execution time of function