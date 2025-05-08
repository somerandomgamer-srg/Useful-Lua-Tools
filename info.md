# Extensions
## Math Library
1. math.average(t): Calculates average from a list of numbers
2. math.median(t): Calculates median from a list of numbers
3. math.range(t): Calculates range from a list of numbers
4. math.mode(t): Calculates mode from a list of numbers
5. math.standard_deviation(t): Calculates standard deviation
6. math.sum(t): Calculates sum of numbers in a table
7. math.gcd(x, y): Finds greatest common factor between 2 numbers
8. math.is_prime(x): Checks if a number is prime
9. math.lcm(x, y): Finds least common multiple between 2 numbers
10. math.quadratic(a, b, c): Solves quadratic equations
11. math.aos(a, b): Calculates axis of symmetry for quadratic functions
12. math.vertex(a, b, c): Calculates vertex point of quadratic functions
13. math.sinh(x): Hyperbolic sine
14. math.cosh(x): Hyperbolic cosine
15. math.tanh(x): Hyperbolic tangent
16. math.acosh(x): Inverse hyperbolic cosine
17. math.atanh(x): Inverse hyperbolic tangent
18. math.asinh(x): Inverse hyperbolic sine
19. math.round(x, precision): Rounds number to specified decimal places
20. math.fibonacci(n): Generates the `n`th Fibonacci number.
21. math.is_odd(x): Checks if a number is odd.
22. math.is_even(x): Checks if a number is even.
## String Library
1. string.clean_number(s): Cleans a string to ensure valid number format by removing non-numeric characters except decimal points and minus signs.
2. string.trim(s): Removes whitespace from both ends of a string.
3. string.split(s, pattern): Splits a string into a table based on a pattern.
4. string.starts_with(s, letter): Checks if string starts with given letter.
5. string.ends_with(s, letter): Checks if string ends with given letter.
6. string.pad(s, string_char, length, include_start, include_end): Adds padding characters to start and/or end of string.
7. string.capitalize(s): Capitalizes the first letter.
8. string.title_case(s): Capitalizes the first letter of every word.
9. string.count(s, pattern): Counts how many times `pattern` occurs in `s`.
## Table Library
1. table.contains(t, value): Recursively checks if table t contains value. Returns true/false and the number of instances found.
2. table.csv_to_table(s): Converts a CSV string into a table. Handles quoted fields and commas within fields.
3. table.to_csv(t): Converts a table to a CSV string. Handles values containing commas, quotes, or newlines.
4. table.reverse(t): Reverses the order of elements in a table.
5. table.shuffle(t): Randomly shuffles a table's elements.
# Libraries I Made
## Input Library
1. input.string(message): Gets a single string input with an optional prompt message.
2. input.table(message, number_of_inputs): Collects multiple string inputs.
3. input.number(message): Gets a single numeric input with validation.
4. input.number_table(message, number_of_inputs): Collects multiple numeric inputs.
5. input.loop(message): Collects string inputs until empty input.
6. input.number_loop(message): Collects numeric inputs until empty input.
## Cryptography Library
### Conversion
1. text_to_ascii(s): Converts text to ASCII codes
2. ascii_to_text(s): Converts ASCII codes to text
3. text_to_hex(s): Converts text to hexadecimal
4. hex_to_text(s): Converts hexadecimal to text
5. text_to_binary(s): Converts text to binary
6. binary_to_text(s): Converts binary to text
7. text_to_morse(s): Converts text to morse code
8. morse_to_text(s): Converts morse code to text
### Bitwise Operations
9. bswap(x): Performs bitwise SWAP
10. rol(x, disp): Rotates bits left
11. ror(x, disp): Rotates bits right
12. number_to_bit(x): Converts to 32-bit integer
13. number_to_hex(x): Converts number to hex
14. btest(a, b): Tests if bitwise AND is non-zero
15. extract(n, field, width): Extracts bit field
16. rrotate(x, disp): Rotates right with negative handling
17. lrotate(x, disp): Rotates left with negative handling
18. replace(n, v, field, width): Replaces bits in field
### Encryption/Decryption
19. xor(s, key): XOR encryption/decryption
20. caesar_cipher(s, shift): Caesar cipher encryption
21. rot13(s): ROT13 encryption (Caesar with shift 13)
# Global Variables
1. wait(x): Pauses execution for x seconds. (similar to Python's wait function)
2. is_type(value, type_of_object): Checks if a value matches the specified type.
3. benchmark(func, iterations): Measures execution time of a function.
4. execution_time(func): Measures how long it takes for a function to execute.