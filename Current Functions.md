# Current Functions

## Math Library Extensions

### Statistical Functions

- `math.average(t)`
  - Calculates arithmetic mean from a list of numbers.

- `math.median(t)`
  - Finds middle value in sorted list. For even-length lists, averages two middle values.

- `math.range(t)`
  - Calculates the range from a list of numbers.

- `math.mode(t)`
  - Calculates the mode from a list of numbers.

- `math.standard_deviation(t)`
  - Calculates the standard deviation from a list of numbers.

- `math.sum(t)`
  - Calculates the sum from a list of numbers.

### Number Theory Functions

- `math.gcd(x, y)`
  - Finds the greatest common factor between 2 numbers (`x` and `y`).

- `math.lcm(x, y)`
  - Finds the least common multiple between 2 numbers (`x` and `y`).

- `math.is_prime(x)`
  - Checks if a number (`x`) is a prime number.

### Quadratic Functions

- `math.quadratic(a, b, c)`
  - Solves a quadratic equation in the form ax² + bx + c using the quadratic formula.

- `math.aos(a, b)`
  - Calculates the axis of symmetry for a quadratic function using `a` and `b` coefficients.

- `math.vertex(a, b, c)`
  - Calculates the vertex point of a quadratic function using `a`, `b`, and `c` coefficients.

### Hyperbolic Functions

- `math.sinh(x)`
  - Calculates the hyperbolic sine of x.

- `math.cosh(x)`
  - Calculates the hyperbolic cosine of x.

- `math.tanh(x)`
  - Calculates the hyperbolic tangent of x.

- `math.asinh(x)`
  - Calculates the inverse hyperbolic sine of x.

- `math.acosh(x)`
  - Calculates the inverse hyperbolic cosine of x.

- `math.atanh(x)`
  - Calculates the inverse hyperbolic tangent of x.

### Number Utilities

- `math.round(x, precision)`
  - Rounds `x` to `precision` decimal places (whole number if no precision given).

- `math.fib(n)`
  - Calculates the `n`th term of the Fibonacci Sequence.

- `math.is_odd(x)`
  - Checks if `x` is an odd number.


- `table.freeze(t)`
  - Makes a table immutable by preventing modifications to its values.

- `table.is_frozen(t)`
  - Checks if a table is frozen.

- `table.unfreeze(t)`
  - Removes the immutability from a frozen table.


  - NOTE: Floats are neither odd nor even.

- `math.is_even(x)`
  - Checks if `x` is an even number.
  - NOTE: Floats are neither odd nor even.

## String Library Extensions

### String Manipulation

- `string.clean_number(s)`
  - Cleans a string (`s`) to ensure it's a valid number format.
  - Features:
    - Removes all non-numeric characters except decimal points and minus signs
    - Handles multiple decimal points by keeping only the first one
    - Preserves negative sign only if it's at the start
  - Example usage:
    - CleanNumber("abc-123.45.6") -> "-123.456"
    - CleanNumber("12.34.56") -> "12.3456"
    - CleanNumber("ab12cd") -> "12"
    - CleanNumber("$52 per Year") -> "52"

- `string.trim(s)`
  - Removes whitespace from both ends of a string.

- `string.split(s, pattern)`
  - Splits `s` into a table based on `pattern`.

- `string.starts_with(s, letter)`
  - Checks if `s` starts with `letter`.

- `string.ends_with(s, letter)`
  - Checks if `s` ends with `letter`.

- `string.pad(s, string_char, length, include_start, include_end)`
  - Adds `string_char` to `s`'s start if `include_start` is true and to its end if `include_end` is true, repeating it `length` times.

- `string.capitalize(s)`
  - Capitalizes the first character of a string.

- `string.title_case(s, sep)`
  - Capitalizes the first letter of each word in `s` using the specified separator `sep` (default is space).

- `string.count(s, pattern)`
  - Returns the amount of occurrences `pattern` occurs in `s`.

## Table Library Extensions

### Table Operations

- `table.contains(t, value)`
  - Recursively checks if `t` contains `value`.
  - Returns (`true`, `number of instances`) or (`false`, `0`).

- `table.csv_to_table(s)`
  - Converts a CSV string (`s`) into a table.

- `table.to_csv(t)`
  - Converts a table (`t`) to a CSV string.

- `table.reverse(t)`
  - Reverses the order of elements in `t`.

- `table.shuffle(t, n)`
  - Shuffles the order of elements in `t` `n` times.

- `table.count_keys(t)`
  - Counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences.

- `table.deep_count_keys(t, separator)`
  - Recursively counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences.
  - The keys in nested tables are joined using `separator` (defaults to ".").

## Input Library

### Input Functions

- `input.string(message)`
  - Gets string input.

- `input.table(message, number_of_inputs)`
  - Collects multiple strings.

- `input.number(message)`
  - Gets validated numeric input.

- `input.number_table(message, number_of_inputs)`
  - Collects multiple numbers.

- `input.loop(message)` / `input.number_loop(message)`
  - Collects inputs until empty submission.

## Cryptography Library

### Text Conversion

- `cryptography.text_to_ascii(s)`
  - Converts a string from plaintext to ASCII code numbers.

- `cryptography.ascii_to_text(s)`
  - Converts ASCII code numbers back to text.

- `cryptography.text_to_hex(s)`
  - Converts a string from plaintext to hexadecimal.

- `cryptography.hex_to_text(s)`
  - Converts hexadecimal back to text.

- `cryptography.text_to_binary(s)`
  - Converts a string from plaintext to binary.

- `cryptography.binary_to_text(s)`
  - Converts binary back to text.

- `cryptography.text_to_morse(s)`
  - Converts plaintext to morse code.

- `cryptography.morse_to_text(s)`
  - Converts morse code back to plaintext.

### Encryption

- `cryptography.xor(s, key)`
  - Performs XOR encryption/decryption on a string using a key.
  - Note: XOR is symmetric - use the same key to decrypt.

- `cryptography.caesar_cipher(s, shift)`
  - Applies Caesar cipher encryption to a string with specified shift.

- `cryptography.rot13(s)`
  - Applies ROT13 encryption (Caesar cipher with shift of 13).

- `cryptography.uuid_v4()`
  - Generates a random UUID (version 4)

### Bitwise Operations

- `cryptography.bswap(x)`
  - Performs bitwise SWAP operation.

- `cryptography.rol(x, disp)`
  - Performs a bitwise left rotation by specified positions.

- `cryptography.ror(x, disp)`
  - Performs a bitwise right rotation by specified positions.

- `cryptography.number_to_bit(x)`
  - Converts a number to a 32-bit integer.

- `cryptography.number_to_hex(x)`
  - Converts a number to its hexadecimal representation.

- `cryptography.btest(a, b)`
  - Tests if bitwise AND of operands is non-zero.

- `cryptography.extract(n, field, width)`
  - Extracts bits from a number.

- `cryptography.rrotate(x, disp)`
  - Rotates bits right (negative for left).

- `cryptography.lrotate(x, disp)`
  - Rotates bits left (negative for right).

- `cryptography.replace(n, v, field, width)`
  - Replaces bits in a number with another value.

## Global Functions

- `wait(x)`
  - Yields the code for `x` seconds. (Similar to python's wait function)

- `is_type(value, type_of_object)`
  - Checks if `value` is a `type_of_object`
      
- `benchmark(func, iterations)`
  - Runs `func` `iterations` times

- `execution_time(func)`
  - Runs `func` and returns the time it takes to run `func`