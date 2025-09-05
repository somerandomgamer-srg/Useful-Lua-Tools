
# Current Functions and Variables

## ULT Library Variables

### `ult.version`
- **Type**: `variable`
- **Returns**: `string`
- **Description**: The version of Useful Lua Tools ("Major Update"."Minor Update"."Patch")

### `ult.contributors`
- **Type**: `variable`
- **Returns**: `table`
- **Description**: The people who contributed to Useful Lua Tools

### `ult.min_lua_ver`
- **Type**: `variable`
- **Returns**: `string`
- **Description**: The minimum version of Lua required to run Useful Lua Tools

### `ult.release_date`
- **Type**: `variable`
- **Returns**: `string`
- **Description**: The release date of the current ULT version

### `ult.build`
- **Type**: `variable`
- **Returns**: `string`
- **Description**: The current build of Useful Lua Tools (`Project` - `version` - `date of release` - `minimum lua version`)

## System Library Variables

### `system.os`
- **Type**: `variable`
- **Returns**: `string` or `nil`
- **Description**: The OS the system is running on, or nil if it cannot be determined (`Windows` | `Linux` | `MacOS` | `ChromeOS`)

### `system.is_windows`
- **Type**: `variable`
- **Returns**: `boolean`
- **Description**: true if the host system is running on Windows, false otherwise

### `system.is_mac`
- **Type**: `variable`
- **Returns**: `boolean`
- **Description**: true if the host system is running on MacOS, false otherwise

### `system.is_linux`
- **Type**: `variable`
- **Returns**: `boolean`
- **Description**: true if the host system is running on Linux, false otherwise

### `system.is_chrome`
- **Type**: `variable`
- **Returns**: `boolean`
- **Description**: true if the host system is running on Chrome OS, false otherwise

### `system.uname`
- **Type**: `variable`
- **Returns**: `string` or `nil`
- **Description**: The system Unix Name, or nil if it cannot be determined

### `system.cores`
- **Type**: `variable`
- **Returns**: `number` or `nil`
- **Description**: Amount of CPU Cores the host system has, or nil if it cannot be determined

### `system.architecture`
- **Type**: `variable`
- **Returns**: `string` or `nil`
- **Description**: The CPU architecture of the host system, or nil if it cannot be determined

### `system.is_linux_based`
- **Type**: `variable`
- **Returns**: `boolean`
- **Description**: true if the host system is built on Linux, false otherwise

## Math Library Functions

### Statistical Functions

#### `math.average(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `number`
- **Description**: Calculates the average from a list of numbers

#### `math.median(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `number`
- **Description**: Finds middle value in list. For even-length lists, averages two middle values

#### `math.range(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `number`
- **Description**: Calculates the range from a list of numbers

#### `math.mode(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `number`
- **Description**: Calculates the mode from a list of numbers

#### `math.standard_deviation(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `number`
- **Description**: Calculates the standard deviation from a list of numbers

#### `math.sum(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `number`
- **Description**: Calculates the sum from a list of numbers

#### `math.z_score(x, t)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `t`: `table` (R)
- **Returns**: `number`
- **Description**: Calculates the z-score of `x` in a dataset (`t`)

### Number Theory Functions

#### `math.gcd(x, y)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `y`: `number` (R)
- **Returns**: `number`
- **Description**: Finds the greatest common factor between `x` and `y`

#### `math.lcm(x, y)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `y`: `number` (R)
- **Returns**: `number`
- **Description**: Finds the least common multiple between `x` and `y`

#### `math.is_prime(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` is a prime number

#### `math.factorial(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the factorial of `x`

#### `math.factors(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `table`
- **Description**: Returns all factors of `x`

#### `math.fib(n)`
- **Type**: `function`
- **Arguments**: 
  - `n`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the `n`th term of the Fibonacci Sequence

### Algebraic Functions

#### `math.quadratic(a, b, c)`
- **Type**: `function`
- **Arguments**: 
  - `a`: `number` (R)
  - `b`: `number` (R)
  - `c`: `number` (R)
- **Returns**: `number`
- **Description**: Solves a quadratic equation in the form `a`x² + `b`x + `c` using the quadratic formula

#### `math.aos(a, b)`
- **Type**: `function`
- **Arguments**: 
  - `a`: `number` (R)
  - `b`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the axis of symmetry for a quadratic function using `a` and `b` coefficients

#### `math.vertex(a, b, c)`
- **Type**: `function`
- **Arguments**: 
  - `a`: `number` (R)
  - `b`: `number` (R)
  - `c`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the vertex point of a quadratic function using `a`, `b`, and `c` coefficients

### Hyperbolic Functions

#### `math.sinh(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the hyperbolic sine of `x`

#### `math.cosh(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the hyperbolic cosine of `x`

#### `math.tanh(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the hyperbolic tangent of `x`

#### `math.asinh(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the inverse hyperbolic sine of `x`

#### `math.acosh(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the inverse hyperbolic cosine of `x`

#### `math.atanh(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the inverse hyperbolic tangent of `x`

### Trigonometric Functions

#### `math.secant(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the secant of `x`

#### `math.cosecant(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the cosecant of `x`

#### `math.cotangent(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the cotangent of `x`

#### `math.asecant(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the inverse secant of `x`

#### `math.acosecant(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the inverse cosecant of `x`

#### `math.acotangent(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the inverse cotangent of `x`

### Utility Functions

#### `math.round(x, precision)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `precision`: `number` (O)
- **Returns**: `number`
- **Description**: Rounds `x` to `precision` decimal places (whole number if no precision given)

#### `math.midpoint(x, y)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `y`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the midpoint between `x` and `y`

### Number Classification Functions

#### `math.is_odd(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` is an odd number

#### `math.is_even(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` is an even number

#### `math.is_perfect_square(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` has a whole number square root

#### `math.is_perfect(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` is perfect (sum of factors equals the number)

#### `math.is_deficient(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` is deficient (sum of factors less than number)

#### `math.is_abundant(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` is abundant (sum of factors greater than number)

#### `math.classify_number(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `string`
- **Description**: Classifies `x` as Perfect, Deficient, or Abundant

#### `math.is_whole(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `boolean`
- **Description**: Checks if `x` is a whole number

### Combinatorics Functions

#### `math.permutation(x, r)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `r`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the number of ways to arrange `r` items from `x` items

#### `math.combination(x, r)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `r`: `number` (R)
- **Returns**: `number`
- **Description**: Calculates the number of ways to choose `r` items from `x` items

## String Library Functions

### `string.clean_number(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: `tonumber()` conversion but better. Properly cleans a string (`s`) to ensure it's in a valid number format

### `string.trim(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Removes whitespace from both ends of a string

### `string.split(s, pattern)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `pattern`: `string` (R)
- **Returns**: `table`
- **Description**: Splits `s` into a table based on `pattern`

### `string.starts_with(s, letter)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `letter`: `string` (R)
- **Returns**: `boolean`
- **Description**: Checks if `s` starts with `letter`

### `string.ends_with(s, letter)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `letter`: `string` (R)
- **Returns**: `boolean`
- **Description**: Checks if `s` ends with `letter`

### `string.pad(s, string_char, length, include_start, include_end)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `string_char`: `string` (R)
  - `length`: `number` (R)
  - `include_start`: `boolean` (O)
  - `include_end`: `boolean` (O)
- **Returns**: `string`
- **Description**: Adds `string_char` to `s`'s start if `include_start` is true and to its end if `include_end` is true, repeating it `length` times

### `string.capitalize(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Capitalizes the first character of a string

### `string.title_case(s, sep)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `sep`: `string` (O)
- **Returns**: `string`
- **Description**: Capitalizes the first letter of each word in `s` using the specified separator `sep` (default is space)

### `string.count(s, pattern)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `pattern`: `string` (R)
- **Returns**: `string`
- **Description**: Returns the amount of occurrences `pattern` occurs in `s`

### `string.is_palindrome(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `boolean`
- **Description**: Checks if a string reads the same forwards and backwards

## Table Library Functions

### `table.contains(t, value)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
  - `value`: `any` (R)
- **Returns**: `boolean`, `number`
- **Description**: Recursively checks if `t` contains `value`. Returns (`true`, `number of instances`) or (`false`, `0`)

### `table.csv_to_table(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `table`
- **Description**: Converts a CSV string (`s`) into a table

### `table.to_csv(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `string`
- **Description**: Converts a table (`t`) to a CSV string

### `table.reverse(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `table`
- **Description**: Reverses the order of elements in `t`

### `table.shuffle(t, n)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
  - `n`: `number` (O)
- **Returns**: `table`
- **Description**: Shuffles the order of elements in `t` `n` times. NOTE: If `n` is not given, `t` will only shuffle once

### `table.count_keys(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `number`, `table`
- **Description**: Counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences (key = amount_of_occurrences)

### `table.deep_count_keys(t, separator)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
  - `separator`: `string` (O)
- **Returns**: `number`, `table`
- **Description**: Recursively counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences. The keys in nested tables are joined using `separator` (defaults to ".") (key = amount_of_occurrences)

### `table.intersection(t1, t2)`
- **Type**: `function`
- **Arguments**: 
  - `t1`: `table` (R)
  - `t2`: `table` (R)
- **Returns**: `table`
- **Description**: Returns a table containing the similarities between `t1` and `t2`. NOTE: This function ONLY works on lists/arrays

### `table.difference(t1, t2)`
- **Type**: `function`
- **Arguments**: 
  - `t1`: `table` (R)
  - `t2`: `table` (R)
- **Returns**: `table`
- **Description**: Returns a table containing the differences between `t1` and `t2`. NOTE: This function ONLY works on lists/arrays

### `table.shuffle_randomseed(t, seed, n)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
  - `seed`: `number` (R)
  - `n`: `number` (O)
- **Returns**: `table`
- **Description**: Shuffles the order of elements in `t` `n` times using the randomseed (`seed`). NOTE: If `n` is not given, `t` will only shuffle once

### `table.keypair_reverse(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `table`
- **Description**: Returns a reversed key-pair table of `t` in which each `key = value` turns into `value = key`

### `table.last(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `any`
- **Description**: Returns the last element in `t`

### `table.first(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `any`
- **Description**: Returns the first element in `t`

### `table.copy(t)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `table` (R)
- **Returns**: `table`
- **Description**: Returns a copy of the table `t`

## Input Library Functions

### `input.string(message)`
- **Type**: `function`
- **Arguments**: 
  - `message`: `string` (O)
- **Returns**: `string`
- **Description**: Gets string input with an optional print `message`

### `input.table(number_of_inputs, message)`
- **Type**: `function`
- **Arguments**: 
  - `number_of_inputs`: `number` (R)
  - `message`: `string` (O)
- **Returns**: `string`
- **Description**: Returns a table with `number_of_inputs` string inputs with an optional print `message`

### `input.number(message)`
- **Type**: `function`
- **Arguments**: 
  - `message`: `string` (O)
- **Returns**: `number`
- **Description**: Gets numeric input with an optional print `message`

### `input.number_table(number_of_inputs, message)`
- **Type**: `function`
- **Arguments**: 
  - `number_of_inputs`: `number` (R)
  - `message`: `string` (O)
- **Returns**: `string`
- **Description**: Returns a table with `number_of_inputs` numeric inputs with an optional print `message`

### `input.loop(message)`
- **Type**: `function`
- **Arguments**: 
  - `message`: `string` (O)
- **Returns**: `table`
- **Description**: Returns a table of string inputs until empty submission with an optional print `message`

### `input.number_loop(message)`
- **Type**: `function`
- **Arguments**: 
  - `message`: `string` (O)
- **Returns**: `table`
- **Description**: Returns a table of numeric inputs until empty submission with an optional print `message`

## Cryptography Library Functions

### Text Conversion Functions

#### `cryptography.text_to_ascii(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts plaintext to ASCII code numbers

#### `cryptography.ascii_to_text(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts ASCII code numbers to plaintext

#### `cryptography.text_to_hex(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts plaintext to hexadecimal

#### `cryptography.hex_to_text(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts hexadecimal to text

#### `cryptography.text_to_binary(s, x)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `x`: `number` (O)
- **Returns**: `string`
- **Description**: Converts plaintext to binary (`x` bits). `x` defaults to `8` if not given

#### `cryptography.binary_to_text(s, x)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `x`: `number` (O)
- **Returns**: `string`
- **Description**: Converts binary (`x` bits) to plaintext. `x` defaults to `8` if not given

#### `cryptography.text_to_octal(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts plaintext to space-seperated octal

#### `cryptography.octal_to_text(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts space-seperated octal to plaintext

#### `cryptography.text_to_morse(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts plaintext to morse code

#### `cryptography.morse_to_text(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts morse code to plaintext

#### `cryptography.text_to_base64(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts plaintext to base64

#### `cryptography.base64_to_text(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts base64 to plaintext

#### `cryptography.text_to_base32(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts plaintext to base32

#### `cryptography.base32_to_text(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Converts base32 to plaintext

### Encryption Functions

#### `cryptography.xor(s, key)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `key`: `string` (R)
- **Returns**: `string`
- **Description**: Performs XOR encryption/decryption on `s` using `key`. Note: XOR is symmetric - use the same key to decrypt

#### `cryptography.caesar_cipher(s, shift)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
  - `shift`: `number` (R)
- **Returns**: `string`
- **Description**: Applies Caesar cipher encryption to `s` with specified `shift`

#### `cryptography.rot13(s)`
- **Type**: `function`
- **Arguments**: 
  - `s`: `string` (R)
- **Returns**: `string`
- **Description**: Applies ROT13 encryption on `s` (Caesar cipher with shift of 13)

### UUID Generation

#### `cryptography.uuid_v4()`
- **Type**: `function`
- **Arguments**: None
- **Returns**: `string`
- **Description**: Generates a random UUID (version 4). UUID V4 format: `xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx` where `x`: 0-9 and a-f, Hyphens (-) separate sections, The `4` in the third section indicates it's a version 4 UUID, `y`: 8, 9, a, or b

### Bitwise Operations

#### `cryptography.bswap(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `number`
- **Description**: Performs bitwise SWAP operation on `x`

#### `cryptography.rol(x, disp)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `disp`: `number` (R)
- **Returns**: `number`
- **Description**: Performs a bitwise left rotation on `x` by specified positions (`disp`)

#### `cryptography.ror(x, disp)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
  - `disp`: `number` (R)
- **Returns**: `number`
- **Description**: Performs a bitwise right rotation on `x` by specified positions (`disp`)

#### `cryptography.number_to_bit(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `string`
- **Description**: Converts `x` to its binary representation

#### `cryptography.number_to_hex(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `string`
- **Description**: Converts `x` to its hexadecimal representation

#### `cryptography.btest(a, b)`
- **Type**: `function`
- **Arguments**: 
  - `a`: `number` (R)
  - `b`: `number` (R)
- **Returns**: `boolean`
- **Description**: Returns a boolean signaling whether the bitwise AND of its operands is different from zero

#### `cryptography.extract(n, field, width)`
- **Type**: `function`
- **Arguments**: 
  - `n`: `number` (R)
  - `field`: `number` (R)
  - `width`: `number` (O)
- **Returns**: `number`
- **Description**: Returns the unsigned number formed by the bits `field` to `field + width - 1` from `n`

#### `cryptography.replace(n, v, field, width)`
- **Type**: `function`
- **Arguments**: 
  - `n`: `number` (R)
  - `v`: `number` (R)
  - `field`: `number` (R)
  - `width`: `number` (O)
- **Returns**: `number`
- **Description**: Returns a copy of `n` with the bits `field` to `field + width - 1` replaced by the value `v`

## Color Library Functions

### `color.rgb_to_hex(r, g, b)`
- **Type**: `function`
- **Arguments**: 
  - `r`: `number` (R)
  - `g`: `number` (R)
  - `b`: `number` (R)
- **Returns**: `string`
- **Description**: Converts RGB(`r`,`g`,`b`) to HEX(`RRGGBB`)

### `color.rgb_to_hsv(r, g, b)`
- **Type**: `function`
- **Arguments**: 
  - `r`: `number` (R)
  - `g`: `number` (R)
  - `b`: `number` (R)
- **Returns**: `number`, `number`, `number`
- **Description**: Converts RGB(`r`,`g`,`b`) to HSV(`h`,`s`,`v`)

### `color.hex_to_rgb(hex)`
- **Type**: `function`
- **Arguments**: 
  - `hex`: `string` (R)
- **Returns**: `number`, `number`, `number`
- **Description**: Converts HEX(`RRGGBB`) to RGB(`r`,`g`,`b`)

### `color.hex_to_hsv(hex)`
- **Type**: `function`
- **Arguments**: 
  - `hex`: `string` (R)
- **Returns**: `number`, `number`, `number`
- **Description**: Converts HEX(`RRGGBB`) to HSV(`h`,`s`,`v`)

### `color.hsv_to_rgb(h, s, v)`
- **Type**: `function`
- **Arguments**: 
  - `h`: `number` (R)
  - `s`: `number` (R)
  - `v`: `number` (R)
- **Returns**: `number`, `number`, `number`
- **Description**: Converts HSV(`h`,`s`,`v`) to RGB(`r`,`g`,`b`)

### `color.hsv_to_hex(h, s, v)`
- **Type**: `function`
- **Arguments**: 
  - `h`: `number` (R)
  - `s`: `number` (R)
  - `v`: `number` (R)
- **Returns**: `string`
- **Description**: Converts HSV(`h`,`s`,`v`) to HEX(`RRGGBB`)

## Remote Library Functions

### `remote.register(name, func)`
- **Type**: `function`
- **Arguments**: 
  - `name`: `string` (R)
  - `func`: `function` (R)
- **Returns**: `void`
- **Description**: Registers a function under the given `name`. When `remote.call()` is called with this `name`, the registered `func` will be executed

### `remote.unregister(name)`
- **Type**: `function`
- **Arguments**: 
  - `name`: `string` (R)
- **Returns**: `void`
- **Description**: Removes the function registered under the given `name`, making it unavailable for `remote.call()`

### `remote.call(name)`
- **Type**: `function`
- **Arguments**: 
  - `name`: `string` (R)
- **Returns**: `any?`
- **Description**: Calls the function registered under the given `name` and returns its result (if any)

## Global Functions

### `wait(x)`
- **Type**: `function`
- **Arguments**: 
  - `x`: `number` (R)
- **Returns**: `void`
- **Description**: Yields the code for `x` seconds. (Similar to python's wait function)

### `is_type(value, type_of_object)`
- **Type**: `function`
- **Arguments**: 
  - `value`: `any` (R)
  - `type_of_object`: `"nil"|"number"|"string"|"boolean"|"table"|"function"|"thread"|"userdata"` (R)
- **Returns**: `boolean`
- **Description**: Checks if `value` is a `type_of_object`

### `benchmark(func, iterations)`
- **Type**: `function`
- **Arguments**: 
  - `func`: `function` (R)
  - `iterations`: `number` (R)
- **Returns**: `number`, `number`, `any`
- **Description**: Runs `func` `iterations` times. Returns Total Execution Time, Average Execution Time Per Run, The Last Result (if return is added in the code)

### `execution_time(func)`
- **Type**: `function`
- **Arguments**: 
  - `func`: `function` (R)
- **Returns**: `number`, `any`
- **Description**: Runs `func` and returns the time it takes to run `func`

### `delay(t, func)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `number` (R)
  - `func`: `function` (R)
- **Returns**: `void`
- **Description**: Yields `t` seconds before running `func` without stopping other code

### `delay_stop(t, func)`
- **Type**: `function`
- **Arguments**: 
  - `t`: `number` (R)
  - `func`: `function` (R)
- **Returns**: `void`
- **Description**: Yields `t` seconds before running `func` while stopping other code

---

**Legend:**
- **R**: Required parameter
- **O**: Optional parameter
