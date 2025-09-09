# 1. ULT Library Variables

### 1.1 `ult.version`
- **Type**: `variable`
- **Returns**: `string`
- **Description**: The version of Useful Lua Tools ("Major Update"."Minor Update"."Patch").

### 1.2 `ult.contributors`
- **Type**: `variable`
- **Returns**: `table`
- **Description**: The people who contributed to Useful Lua Tools.

### 1.3 `ult.min_lua_ver`
- **Type**: `variable`
- **Returns**: `string`
- **Description**: The minimum version of Lua required to run Useful Lua Tools.

### 1.4 `ult.release_date`
- **Type**: `variable`
- **Returns**: `string`
- **Description**: The release date of the current ULT version.

### 1.5 `ult.build`
- **Type**: `variable`
- **Returns**: `string`
- **Description**: The current build of Useful Lua Tools (`Project` - `version` - `date of release` - `minimum lua version`).

## 2. System Library Variables

### 2.1 `system.os`
- **Type**: `variable`
- **Returns**: `string` or `nil`
- **Description**: The OS the system is running on, or nil if it cannot be determined (`Windows` | `Linux` | `MacOS` | `ChromeOS`).

### 2.2 `system.is_windows`
- **Type**: `variable`
- **Returns**: `boolean`
- **Description**: True if the host system is running on Windows, false otherwise.

### 2.3 `system.is_mac`
- **Type**: `variable`
- **Returns**: `boolean`
- **Description**: True if the host system is running on MacOS, false otherwise.

### 2.4 `system.is_linux`
- **Type**: `variable`
- **Returns**: `boolean`
- **Description**: True if the host system is running on Linux, false otherwise.

### 2.5 `system.is_chrome`
- **Type**: `variable`
- **Returns**: `boolean`
- **Description**: True if the host system is running on Chrome OS, false otherwise.

### 2.6 `system.uname`
- **Type**: `variable`
- **Returns**: `string` or `nil`
- **Description**: The system Unix Name, or nil if it cannot be determined.

### 2.7 `system.cores`
- **Type**: `variable`
- **Returns**: `number` or `nil`
- **Description**: Amount of CPU Cores the host system has, or nil if it cannot be determined.

### 2.8 `system.architecture`
- **Type**: `variable`
- **Returns**: `string` or `nil`
- **Description**: The CPU architecture of the host system, or nil if it cannot be determined.

### 2.9 `system.is_linux_based`
- **Type**: `variable`
- **Returns**: `boolean`
- **Description**: True if the host system is built on Linux, false otherwise.

# 3. Math Library Functions

### 3.1 Statistical Functions

#### 3.1.1 `math.average(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `number`
- **Description**: Calculates the average from a list of numbers.

#### 3.1.2 `math.median(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `number`
- **Description**: Finds middle value in list. For even-length lists, averages two middle values.

#### 3.1.3 `math.range(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `number`
- **Description**: Calculates the range from a list of numbers.

#### 3.1.4 `math.mode(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `number`
- **Description**: Calculates the mode from a list of numbers.

#### 3.1.5 `math.standard_deviation(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `number`
- **Description**: Calculates the standard deviation from a list of numbers.

#### 3.1.6 `math.sum(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `number`
- **Description**: Calculates the sum from a list of numbers.

#### 3.1.7 `math.z_score(x, t)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `t`: `table` (R)
- **Returns**: `number`
- **Description**: Calculates the z-score of `x` in a dataset (`t`).

### 3.2 Number Theory Functions

#### 3.2.1 `math.gcd(x, y)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `y`: `number` (R)
- **Returns**: `number`
- **Description**: Finds the greatest common factor between `x` and `y`.

#### 3.2.2 `math.lcm(x, y)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `y`: `number` (R)
- **Returns**: `number`
- **Description**: Finds the least common multiple between `x` and `y`.

#### 3.2.3 `math.is_prime(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` is a prime number.

#### 3.2.4 `math.factorial(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the factorial of `x`.

#### 3.2.5 `math.factors(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `table`
- **Description**: Returns all factors of `x`.

#### 3.2.6 `math.fib(n)`
- **Type**: `function`
- **Arguments**: 
  - `n`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the `n`th term of the Fibonacci Sequence.

### 3.3 Algebraic Functions

#### 3.3.1 `math.quadratic(a, b, c)`
- **Type**: `function`
- **Arguments**: 
  - `a`: `number` (R)
  - `b`: `number` (R)
  - `c`: `number` (R)
- **Returns**: `number`
- **Description**: Solves a quadratic equation in the form `a`x² + `b`x + `c` using the quadratic formula.

#### 3.3.2 `math.aos(a, b)`
- **Type**: `function`
- **Arguments**: 
  - `a`: `number` (R)
  - `b`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the axis of symmetry for a quadratic function using `a` and `b` coefficients.

#### 3.3.3 `math.vertex(a, b, c)`
- **Type**: `function`
- **Arguments**: 
  - `a`: `number` (R)
  - `b`: `number` (R)
  - `c`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the vertex point of a quadratic function using `a`, `b`, and `c` coefficients.

### 3.4 Hyperbolic Functions

#### 3.4.1 `math.sinh(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the hyperbolic sine of `x`.

#### 3.4.2 `math.cosh(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the hyperbolic cosine of `x`.

#### 3.4.3 `math.tanh(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the hyperbolic tangent of `x`.

#### 3.4.4 `math.asinh(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the inverse hyperbolic sine of `x`.

#### 3.4.5 `math.acosh(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the inverse hyperbolic cosine of `x`.

#### 3.4.6 `math.atanh(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the inverse hyperbolic tangent of `x`.

### 3.5 Trigonometric Functions

#### 3.5.1 `math.secant(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the secant of `x`.

#### 3.5.2 `math.cosecant(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the cosecant of `x`.

#### 3.5.3 `math.cotangent(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the cotangent of `x`.

#### 3.5.4 `math.asecant(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the inverse secant of `x`.

#### 3.5.5 `math.acosecant(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the inverse cosecant of `x`.

#### 3.5.6 `math.acotangent(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the inverse cotangent of `x`.

### 3.6 Utility Functions

#### 3.6.1 `math.round(x, precision)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `precision`: `number` (O)
- **Returns**: `number`
- **Description**: Rounds `x` to `precision` decimal places (whole number if no precision given).

#### 3.6.2 `math.midpoint(x, y)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `y`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the midpoint between `x` and `y`.

### 3.7 Number Classification Functions

#### 3.7.1 `math.is_odd(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` is an odd number.

#### 3.7.2 `math.is_even(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` is an even number.

#### 3.7.3 `math.is_perfect_square(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` has a whole number square root.

#### 3.7.4 `math.is_perfect(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` is perfect (sum of factors equals the number).

#### 3.7.5 `math.is_deficient(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` is deficient (sum of factors less than number).

#### 3.7.6 `math.is_abundant(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` is abundant (sum of factors greater than number).

#### 3.7.7 `math.classify_number(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `string`
- **Description**: Classifies `x` as Perfect, Deficient, or Abundant.

#### 3.7.8 `math.is_whole(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` is a whole number.

### 3.8 Combinatorics Functions

#### 3.8.1 `math.permutation(x, r)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `r`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the number of ways to arrange `r` items from `x` items.

#### 3.8.2 `math.combination(x, r)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `r`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the number of ways to choose `r` items from `x` items.

## 4. String Library Functions

### 4.1 `string.clean_number(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: `tonumber()` conversion but better. Properly cleans a string (`s`) to ensure it's in a valid number format.

### 4.2 `string.trim(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Removes whitespace from both ends of a string.

### 4.3 `string.split(s, pattern)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `pattern`: `string` (R)
- **Returns**: `table`
- **Description**: Splits `s` into a table based on `pattern`.

### 4.4 `string.starts_with(s, letter)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `letter`: `string` (R)
- **Returns**: `boolean`
- **Description**: Checks if `s` starts with `letter`.

### 4.5 `string.ends_with(s, letter)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `letter`: `string` (R)
- **Returns**: `boolean`
- **Description**: Checks if `s` ends with `letter`.

### 4.6 `string.pad(s, string_char, length, include_start, include_end)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `string_char`: `string` (R)
  - `length`: `number` (R)
  - `include_start`: `boolean` (O)
  - `include_end`: `boolean` (O)
- **Returns**: `string`
- **Description**: Adds `string_char` to `s`'s start if `include_start` is true and to its end if `include_end` is true, repeating it `length` times.

### 4.7 `string.capitalize(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Capitalizes the first character of a string.

### 4.8 `string.title_case(s, sep)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `sep`: `string` (O)
- **Returns**: `string`
- **Description**: Capitalizes the first letter of each word in `s` using the specified separator `sep` (default is space).

### 4.9 `string.count(s, pattern)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `pattern`: `string` (R)
- **Returns**: `string`
- **Description**: Returns the amount of occurrences `pattern` occurs in `s`.

### 4.10 `string.is_palindrome(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `boolean`
- **Description**: Checks if a string reads the same forwards and backwards.

## 5. Table Library Functions

### 5.1 `table.contains(t, value)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
  - `value`: `any` (R)
- **Returns**: `boolean`, `number`
- **Description**: Recursively checks if `t` contains `value`. Returns (`true`, `number of instances`) or (`false`, `0`).

### 5.2 `table.csv_to_table(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `table`
- **Description**: Converts a CSV string (`s`) into a table.

### 5.3 `table.to_csv(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `string`
- **Description**: Converts a table (`t`) to a CSV string.

### 5.4 `table.reverse(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `table`
- **Description**: Reverses the order of elements in `t`.

### 5.5 `table.shuffle(t, n)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
  - `n`: `number` (O)
- **Returns**: `table`
- **Description**: Shuffles the order of elements in `t` `n` times. NOTE: If `n` is not given, `t` will only shuffle once.

### 5.6 `table.count_keys(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `number`, `table`
- **Description**: Counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences (key = amount_of_occurrences).

### 5.7 `table.deep_count_keys(t, separator)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
  - `separator`: `string` (O)
- **Returns**: `number`, `table`
- **Description**: Recursively counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences. The keys in nested tables are joined using `separator` (defaults to ".") (key = amount_of_occurrences).

### 5.8 `table.intersection(t1, t2)`
- **Type**: `function`
- **Arguments**: 
  - `t1`: `table` (R)
  - `t2`: `table` (R)
- **Returns**: `table`
- **Description**: Returns a table containing the similarities between `t1` and `t2`. NOTE: This function ONLY works on lists/arrays.

### 5.9 `table.difference(t1, t2)`
- **Type**: `function`
- **Arguments**: 
  - `t1`: `table` (R)
  - `t2`: `table` (R)
- **Returns**: `table`
- **Description**: Returns a table containing the differences between `t1` and `t2`. NOTE: This function ONLY works on lists/arrays.

### 5.10 `table.shuffle_randomseed(t, seed, n)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
  - `seed`: `number` (R)
  - `n`: `number` (O)
- **Returns**: `table`
- **Description**: Shuffles the order of elements in `t` `n` times using the randomseed (`seed`). NOTE: If `n` is not given, `t` will only shuffle once.

### 5.11 `table.keypair_reverse(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `table`
- **Description**: Returns a reversed key-pair table of `t` in which each `key = value` turns into `value = key`.

### 5.12 `table.last(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `any`
- **Description**: Returns the last element in `t`.

### 5.13 `table.first(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `any`
- **Description**: Returns the first element in `t`.

### 5.14 `table.copy(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `table`
- **Description**: Returns a copy of the table `t`.

## 6. Input Library Functions

### 6.1 `input.string(message)`
- **Type**: `function`
- **Arguments**: 
  - `message`: `string` (O)
- **Returns**: `string`
- **Description**: Gets string input with an optional print `message`.

### 6.2 `input.table(number_of_inputs, message)`
- **Type**: `function`
- **Arguments**: 
  - `number_of_inputs`: `number` (R)
  - `message`: `string` (O)
- **Returns**: `string`
- **Description**: Returns a table with `number_of_inputs` string inputs with an optional print `message`.

### 6.3 `input.number(message)`
- **Type**: `function`
- **Arguments**: 
  - `message`: `string` (O)
- **Returns**: `number`
- **Description**: Gets numeric input with an optional print `message`.

### 6.4 `input.number_table(number_of_inputs, message)`
- **Type**: `function`
- **Arguments**: 
  - `number_of_inputs`: `number` (R)
  - `message`: `string` (O)
- **Returns**: `string`
- **Description**: Returns a table with `number_of_inputs` numeric inputs with an optional print `message`.

### 6.5 `input.loop(message)`
- **Type**: `function`
- **Arguments**: 
  - `message`: `string` (O)
- **Returns**: `table`
- **Description**: Returns a table of string inputs until empty submission with an optional print `message`.

### 6.6 `input.number_loop(message)`
- **Type**: `function`
- **Arguments**: 
  - `message`: `string` (O)
- **Returns**: `table`
- **Description**: Returns a table of numeric inputs until empty submission with an optional print `message`.

## 7. Cryptography Library Functions

### 7.1 Text Conversion Functions

#### 7.1.1 `cryptography.text_to_ascii(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts plaintext to ASCII code numbers.

#### 7.1.2 `cryptography.ascii_to_text(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts ASCII code numbers to plaintext.

#### 7.1.3 `cryptography.text_to_hex(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts plaintext to hexadecimal.

#### 7.1.4 `cryptography.hex_to_text(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts hexadecimal to text.

#### 7.1.5 `cryptography.text_to_binary(s, x)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `x`: `number` (O)
- **Returns**: `string`
- **Description**: Converts plaintext to binary (`x` bits). `x` defaults to `8` if not given.

#### 7.1.6 `cryptography.binary_to_text(s, x)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `x`: `number` (O)
- **Returns**: `string`
- **Description**: Converts binary (`x` bits) to plaintext. `x` defaults to `8` if not given.

#### 7.1.7 `cryptography.text_to_octal(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts plaintext to space-seperated octal.

#### 7.1.8 `cryptography.octal_to_text(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts space-seperated octal to plaintext.

#### 7.1.9 `cryptography.text_to_morse(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts plaintext to morse code.

#### 7.1.10 `cryptography.morse_to_text(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts morse code to plaintext.

#### 7.1.11 `cryptography.text_to_base64(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts plaintext to base64.

#### 7.1.12 `cryptography.base64_to_text(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts base64 to plaintext.

#### 7.1.13 `cryptography.text_to_base32(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts plaintext to base32.

#### 7.1.14 `cryptography.base32_to_text(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts base32 to plaintext.

### 7.2 Encryption Functions

#### 7.2.1 `cryptography.xor(s, key)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `key`: `string` (R)
- **Returns**: `string`
- **Description**: Performs XOR encryption/decryption on `s` using `key`. Note: XOR is symmetric - use the same key to decrypt.

#### 7.2.2 `cryptography.caesar_cipher(s, shift)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `shift`: `number` (R)
- **Returns**: `string`
- **Description**: Applies Caesar cipher encryption to `s` with specified `shift`.

#### 7.2.3 `cryptography.rot13(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Applies ROT13 encryption on `s` (Caesar cipher with shift of 13).

### 7.3 Bitwise Operations

#### 7.3.1 `cryptography.bswap(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Performs bitwise SWAP operation on `x`.

#### 7.3.2 `cryptography.rol(x, disp)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `disp`: `number` (R)
- **Returns**: `number`
- **Description**: Performs a bitwise left rotation on `x` by specified positions (`disp`).

#### 7.3.3 `cryptography.ror(x, disp)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `disp`: `number` (R)
- **Returns**: `number`
- **Description**: Performs a bitwise right rotation on `x` by specified positions (`disp`).

#### 7.3.4 `cryptography.number_to_bit(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `string`
- **Description**: Converts `x` to its binary representation.

#### 7.3.5 `cryptography.number_to_hex(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `string`
- **Description**: Converts `x` to its hexadecimal representation.

#### 7.3.6 `cryptography.btest(a, b)`
- **Type**: `function`
- **Arguments**: 
  - `a`: `number` (R)
  - `b`: `number` (R)
- **Returns**: `boolean`
- **Description**: Returns a boolean signaling whether the bitwise AND of its operands is different from zero.

#### 7.3.7 `cryptography.extract(n, field, width)`
- **Type**: `function`
- **Arguments**: 
  - `n`: `number` (R)
  - `field`: `number` (R)
  - `width`: `number` (O)
- **Returns**: `number`
- **Description**: Returns the unsigned number formed by the bits `field` to `field + width - 1` from `n`.

#### 7.3.8 `cryptography.replace(n, v, field, width)`
- **Type**: `function`
- **Arguments**: 
  - `n`: `number` (R)
  - `v`: `number` (R)
  - `field`: `number` (R)
  - `width`: `number` (O)
- **Returns**: `number`
- **Description**: Returns a copy of `n` with the bits `field` to `field + width - 1` replaced by the value `v`.

## 8. Color Library Functions

### 8.1 `color.rgb_to_hex(r, g, b)`
- **Type**: `function`
- **Arguments**: 
  - `r`: `number` (R)
  - `g`: `number` (R)
  - `b`: `number` (R)
- **Returns**: `string`
- **Description**: Converts RGB(`r`,`g`,`b`) to HEX(`RRGGBB`).

### 8.2 `color.rgb_to_hsv(r, g, b)`
- **Type**: `function`
- **Arguments**: 
  - `r`: `number` (R)
  - `g`: `number` (R)
  - `b`: `number` (R)
- **Returns**: `number`, `number`, `number`
- **Description**: Converts RGB(`r`,`g`,`b`) to HSV(`h`,`s`,`v`).

### 8.3 `color.hex_to_rgb(hex)`
- **Type**: `function`
- **Arguments**: 
  - `hex`: `string` (R)
- **Returns**: `number`, `number`, `number`
- **Description**: Converts HEX(`RRGGBB`) to RGB(`r`,`g`,`b`).

### 8.4 `color.hex_to_hsv(hex)`
- **Type**: `function`
- **Arguments**: 
  - `hex`: `string` (R)
- **Returns**: `number`, `number`, `number`
- **Description**: Converts HEX(`RRGGBB`) to HSV(`h`,`s`,`v`).

### 8.5 `color.hsv_to_rgb(h, s, v)`
- **Type**: `function`
- **Arguments**: 
  - `h`: `number` (R)
  - `s`: `number` (R)
  - `v`: `number` (R)
- **Returns**: `number`, `number`, `number`
- **Description**: Converts HSV(`h`,`s`,`v`) to RGB(`r`,`g`,`b`).

### 8.6 `color.hsv_to_hex(h, s, v)`
- **Type**: `function`
- **Arguments**: 
  - `h`: `number` (R)
  - `s`: `number` (R)
  - `v`: `number` (R)
- **Returns**: `string`
- **Description**: Converts HSV(`h`,`s`,`v`) to HEX(`RRGGBB`).

## 9. Remote Library Functions

### 9.1 `remote.register(name, func)`
- **Type**: `function`
- **Arguments**: 
  - `name`: `string` (R)
  - `func`: `function` (R)
- **Returns**: `void`
- **Description**: Registers a function under the given `name`. When `remote.call()` is called with this `name`, the registered `func` will be executed.

### 9.2 `remote.unregister(name)`
- **Type**: `function`
- **Arguments**: 
  - `name`: `string` (R)
- **Returns**: `void`
- **Description**: Removes the function registered under the given `name`, making it unavailable for `remote.call()`.

### 9.3 `remote.call(name)`
- **Type**: `function`
- **Arguments**: 
  - `name`: `string` (R)
- **Returns**: `any?`
- **Description**: Calls the function registered under the given `name` and returns its result (if any).

## 10. Random Library

### 10.1 `random.uuid(v)`
- **Type**: `function`
- **Arguments**: 
  - `v`: `1 = UUID V1`, `4 = UUID V4`, `6 = UUID V6` (R)
- **Returns**: `string`
- **Description**: Generates a Universally Unique Identifier (UUID).
  - UUID V1:
    - Generates a time-based UUID (version 1) using MAC address and timestamp
    - Format: `time_low-time_mid-time_high_and_version-clock_seq-mac_address`
    - Based on timestamp and MAC address
    - Guarantees uniqueness across time and space
  - UUID V4:
    - Generates a purely random UUID (version 4)
    - Format: `xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`
    - `x`: 0-9 or a-f, `4` indicates version 4, `y`: 8, 9, a, or b
    - Extremely low collision probability
  - UUID V6:
    - Generates a time-based UUID (version 6) with reordered timestamp for chronological sorting
    - Format: `time_high-time_mid-time_low_and_version-clock_seq_and_variant-random_node`
    - Uses random node ID instead of MAC address for privacy
    - Maintains v1 uniqueness with better database performance

### 10.2 `random.sign(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Randomly makes `x` positive or negative.

### 10.3 `random.number(min, max, decimals)`
- **Type**: `function`
- **Arguments**: 
  - `min`: `number` (R)
  - `max`: `number` (R)
  - `decimals`: `number` (O)
- **Returns**: `number`
- **Description**: Generates a random number between `min` and `max` with optional decimal places. If `decimals` is not provided, returns a whole number.

### 10.4 `random.choice(t, amount)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
  - `amount`: `number` (O)
- **Returns**: `any|table`
- **Description**: Randomly selects element(s) from table `t`. Returns single element if `amount` < 2 or not provided, otherwise returns table of `amount` elements.

## 11. Global Functions

### 11.1 `wait(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `void`
- **Description**: Yields the code for `x` seconds. (Similar to python's wait function).

### 11.2 `is_type(value, type_of_object)`
- **Type**: `function`
- **Arguments**: 
  - `value`: `any` (R)
  - `type_of_object`: `"nil"|"number"|"string"|"boolean"|"table"|"function"|"thread"|"userdata"` (R)
- **Returns**: `boolean`
- **Description**: Checks if `value` is a `type_of_object`.

### 11.3 `benchmark(func, iterations)`
- **Type**: `function`
- **Arguments**: 
  - `func`: `function` (R)
  - `iterations`: `number` (o)
- **Returns**: `number`, `number`, `any`
- **Description**: Runs `func` `iterations` times. Returns Total Execution Time, Average Execution Time Per Run, The Last Result (if return is added in the code).
- **NOTE: If `iterations` is not given, the code will run 10 times**

### 11.4 `execution_time(func)`
- **Type**: `function`
- **Arguments**: 
  - `func`: `function` (R)
- **Returns**: `number`, `any`
- **Description**: Runs `func` and returns the time it takes to run `func`.

### 11.5 `delay(t, func)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `number` (R)
  - `func`: `function` (R)
- **Returns**: `void`
- **Description**: Yields `t` seconds before running `func` without stopping other code.

### 11.6 `delay_stop(t, func)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `number` (R)
  - `func`: `function` (R)
- **Returns**: `void`
- **Description**: Yields `t` seconds before running `func` while stopping other code.

# **Legend:**
- ## **R**: Required parameter
- ## **O**: Optional parameter

# Summary

## **Total Functions**: 135
## **Total Variables**: 9
## **Total Functions and Variables**: 144