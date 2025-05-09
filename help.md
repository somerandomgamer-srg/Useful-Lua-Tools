
# SRG Library Documentation

## Math Library Extensions

### Statistical Functions

- `math.average(t)`
  - Calculates arithmetic mean from a list of numbers.
  - ```lua
      local numbers = {1, 2, 3, 4, 5}
      print(math.average(numbers)) --> 3
    ```

- `math.median(t)`
  - Finds middle value in sorted list. For even-length lists, averages two middle values.
  - ```lua
      local numbers = {1, 3, 5, 7}
      print(math.median(numbers)) --> 4 (average of 3 and 5)
      
      local oddNumbers = {1, 3, 5}
      print(math.median(oddNumbers)) --> 3
    ```

- `math.range(t)`
  - Calculates the range from a list of numbers.
  - ```lua
      local numbers = {10, 20, 30, 40, 50}
      print(math.range(numbers)) --> 40 (50 - 10)
    ```

- `math.mode(t)`
  - Calculates the mode from a list of numbers.
  - ```lua
      local numbers = {1, 2, 2, 3, 3, 3, 4}
      print(math.mode(numbers)) --> 3
    ```

- `math.standard_deviation(t)`
  - Calculates the standard deviation from a list of numbers.
  - ```lua
      local numbers = {2, 4, 4, 4, 5, 5, 7, 9}
      print(math.standard_deviation(numbers)) --> 2.0
    ```

- `math.sum(t)`
  - Calculates the sum from a list of numbers.
  - ```lua
      local numbers = {1, 2, 3, 4, 5}
      print(math.sum(numbers)) --> 15
    ```

### Number Theory Functions

- `math.gcd(x, y)`
  - Finds the greatest common factor between 2 numbers (`x` and `y`).
  - ```lua
      print(math.gcd(48, 18)) --> 6
      print(math.gcd(35, 10)) --> 5
    ```

- `math.lcm(x, y)`
  - Finds the least common multiple between 2 numbers (`x` and `y`).
  - ```lua
      print(math.lcm(4, 6)) --> 12
      print(math.lcm(21, 6)) --> 42
    ```

- `math.is_prime(x)`
  - Checks if a number (`x`) is a prime number.
  - ```lua
      print(math.is_prime(7)) --> true
      print(math.is_prime(12)) --> false
    ```

### Quadratic Functions

- `math.quadratic(a, b, c)`
  - Solves a quadratic equation in the form ax² + bx + c using the quadratic formula.
  - ```lua
      local x1, x2 = math.quadratic(1, -5, 6)
      print(x1, x2) --> 3, 2 (roots of x² - 5x + 6)
    ```

- `math.aos(a, b)`
  - Calculates the axis of symmetry for a quadratic function using `a` and `b` coefficients.
  - ```lua
      print(math.aos(1, -6)) --> 3 (axis of symmetry for x² - 6x + 5)
    ```

- `math.vertex(a, b, c)`
  - Calculates the vertex point of a quadratic function using `a`, `b`, and `c` coefficients.
  - ```lua
      local x, y = math.vertex(1, -4, 3)
      print(x, y) --> 2, -1 (vertex of x² - 4x + 3)
    ```

### Hyperbolic Functions

- `math.sinh(x)`
  - Calculates the hyperbolic sine of x.
  - ```lua
      print(math.sinh(1)) --> 1.1752011936438
    ```

- `math.cosh(x)`
  - Calculates the hyperbolic cosine of x.
  - ```lua
      print(math.cosh(1)) --> 1.5430806348152
    ```

- `math.tanh(x)`
  - Calculates the hyperbolic tangent of x.
  - ```lua
      print(math.tanh(1)) --> 0.76159415595576
    ```

- `math.asinh(x)`
  - Calculates the inverse hyperbolic sine of x.
  - ```lua
      print(math.asinh(1)) --> 0.88137358701954
    ```

- `math.acosh(x)`
  - Calculates the inverse hyperbolic cosine of x.
  - ```lua
      print(math.acosh(2)) --> 1.3169578969248
    ```

- `math.atanh(x)`
  - Calculates the inverse hyperbolic tangent of x.
  - ```lua
      print(math.atanh(0.5)) --> 0.54930614433405
    ```

### Number Utilities

- `math.round(x, precision)`
  - Rounds `x` to `precision` decimal places (whole number if no precision given).
  - ```lua
      print(math.round(3.14159, 2)) --> 3.14
      print(math.round(3.14159)) --> 3
    ```

- `math.fib(n)`
  - Calculates the `n`th term of the Fibonacci Sequence.
  - ```lua
      print(math.fibonacci(7)) --> 13
      print(math.fibonacci(10)) --> 55
    ```

- `math.is_odd(x)`
  - Checks if `x` is an odd number.
  - NOTE: Floats are neither odd nor even.
  - ```lua
      print(math.is_odd(7)) --> true
    ```

- `math.is_even(x)`
  - Checks if `x` is an even number.
  - NOTE: Floats are neither odd nor even.
  - ```lua
      print(math.is_even(4)) --> true
    ```

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
  - ```lua
      print(string.clean_number("abc-123.45.6")) --> "-123.456"
      print(string.clean_number("$52.99")) --> "52.99"
    ```

- `string.trim(s)`
  - Removes whitespace from both ends of a string.
  - ```lua
      print(string.trim("  hello  ")) --> "hello"
    ```

- `string.split(s, pattern)`
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

- `string.starts_with(s, letter)`
  - Checks if `s` starts with `letter`.
  - ```lua
      print(string.starts_with("Hello", "H")) --> true
    ```

- `string.ends_with(s, letter)`
  - Checks if `s` ends with `letter`.
  - ```lua
      print(string.ends_with("World", "d")) --> true
    ```

- `string.pad(s, string_char, length, include_start, include_end)`
  - Adds `string_char` to `s`'s start if `include_start` is true and to its end if `include_end` is true, repeating it `length` times.
  - ```lua
      print(string.pad("hello", "*", 2)) --> "**hello**"
      print(string.pad("hello", "-", 1, true, false)) --> "-hello"
    ```

- `string.capitalize(s)`
  - Capitalizes the first character of a string.
  - ```lua
      print(string.capitalize("hello")) --> "Hello"
    ```

- `string.title_case(s, sep)`
  - Capitalizes the first letter of each word in `s` using the specified separator `sep` (default is space).
  - ```lua
      print(string.title_case("hello world")) --> "Hello World"
      print(string.title_case("hello-world", "-")) --> "Hello-World"
    ```

- `string.count(s, pattern)`
  - Returns the amount of occurrences `pattern` occurs in `s`.
  - ```lua
      print(string.count("hello world", "l")) --> 3
      print(string.count("hello hello", "hello")) --> 2
    ```

## Table Library Extensions

### Table Operations

- `table.contains(t, value)`
  - Recursively checks if `t` contains `value`.
  - Returns (`true`, `number of instances`) or (`false`, `0`).
  - ```lua
      local t = {1, 2, {3, 4, {5}}}
      local found, count = table.contains(t, 4)
      print(found, count) --> true, 1
    ```

- `table.csv_to_table(s)`
  - Converts a CSV string (`s`) into a table.
  - ```lua
      local csv = "1,2,3\n4,5,6"
      local t = table.csv_to_table(csv)
      -- t = {{1,2,3}, {4,5,6}}
    ```

- `table.to_csv(t)`
  - Converts a table (`t`) to a CSV string.
  - ```lua
      local csv_string = table.to_csv(t)
      -- csv_string = "1,2,3\n4,5,6"
    ```

- `table.reverse(t)`
  - Reverses the order of elements in `t`.
  - ```lua
      local t = {1, 2, 3}
      local reversed = table.reverse(t)
      -- reversed = {3, 2, 1}
    ```

- `table.shuffle(t, n)`
  - Shuffles the order of elements in `t` `n` times.
  - ```lua
      local t = {1, 2, 3, 4, 5}
      local shuffled = table.shuffle(t)
      -- shuffled = {3, 1, 5, 2, 4} (random order)
    ```

- `table.count_keys(t)`
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

- `table.deep_count_keys(t, separator)`
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

## Input Library

### Input Functions

- `input.string(message)`
  - Gets string input.
  - ```lua
      local name = input.string("Enter your name")
      -- Enter your name: John
      -- name = "John"
    ```

- `input.table(message, number_of_inputs)`
  - Collects multiple strings.
  - ```lua
      local names = input.table("Enter 3 names", 3)
      -- Enter 3 names
      -- input 1: John
      -- input 2: Jane
      -- input 3: Bob
      -- names = {"John", "Jane", "Bob"}
    ```

- `input.number(message)`
  - Gets validated numeric input.
  - ```lua
      local age = input.number("Enter your age")
      -- Enter your age: 25
      -- age = 25
    ```

- `input.number_table(message, number_of_inputs)`
  - Collects multiple numbers.
  - ```lua
      local scores = input.number_table("Enter 3 scores", 3)
      -- Enter 3 scores
      -- input 1: 95
      -- input 2: 87
      -- input 3: 92
      -- scores = {95, 87, 92}
    ```

- `input.loop(message)` / `input.number_loop(message)`
  - Collects inputs until empty submission.
  - ```lua
      local names = input.loop("Enter names")
      -- Enter names (press enter to finish)
      -- Input 1: John
      -- Input 2: Jane
      -- Input 3: 
      -- names = {"John", "Jane"}
    ```

## Cryptography Library

### Text Conversion

- `cryptography.text_to_ascii(s)`
  - Converts a string from plaintext to ASCII code numbers.
  - ```lua
      print(cryptography.text_to_ascii("Hello"))
      --> "72 101 108 108 111"
    ```

- `cryptography.ascii_to_text(s)`
  - Converts ASCII code numbers back to text.
  - ```lua
      print(cryptography.ascii_to_text("72 101 108 108 111"))
      --> "Hello"
    ```

- `cryptography.text_to_hex(s)`
  - Converts a string from plaintext to hexadecimal.
  - ```lua
      print(cryptography.text_to_hex("Hello"))
      --> "48656C6C6F"
    ```

- `cryptography.hex_to_text(s)`
  - Converts hexadecimal back to text.
  - ```lua
      print(cryptography.hex_to_text("48656C6C6F"))
      --> "Hello"
    ```

- `cryptography.text_to_binary(s)`
  - Converts a string from plaintext to binary.
  - ```lua
      print(cryptography.text_to_binary("Hello"))
      --> "01001000 01100101 01101100 01101100 01101111"
    ```

- `cryptography.binary_to_text(s)`
  - Converts binary back to text.
  - ```lua
      print(cryptography.binary_to_text("01001000 01100101"))
      --> "He"
    ```

- `cryptography.text_to_morse(s)`
  - Converts plaintext to morse code.
  - ```lua
      print(cryptography.text_to_morse("SOS"))
      --> "... --- ..."
    ```

- `cryptography.morse_to_text(s)`
  - Converts morse code back to plaintext.
  - ```lua
      print(cryptography.morse_to_text("... --- ..."))
      --> "sos"
    ```

### Encryption

- `cryptography.xor(s, key)`
  - Performs XOR encryption/decryption on a string using a key.
  - Note: XOR is symmetric - use the same key to decrypt.
  - ```lua
      local message = "Hello"
      local key = "Key"
      local encrypted = cryptography.xor(message, key)
      local decrypted = cryptography.xor(encrypted, key)
      print(decrypted) --> "Hello"
    ```

- `cryptography.caesar_cipher(s, shift)`
  - Applies Caesar cipher encryption to a string with specified shift.
  - ```lua
      print(cryptography.caesar_cipher("Hello", 3))
      --> "Khoor"
    ```

- `cryptography.rot13(s)`
  - Applies ROT13 encryption (Caesar cipher with shift of 13).
  - ```lua
      print(cryptography.rot13("Hello"))
      --> "Uryyb"
    ```

### Bitwise Operations

- `cryptography.bswap(x)`
  - Performs bitwise SWAP operation.
  - ```lua
      print(cryptography.bswap(0x12345678))
      --> 0x78563412
    ```

- `cryptography.rol(x, disp)`
  - Performs a bitwise left rotation by specified positions.
  - ```lua
      print(cryptography.rol(0x12345678, 4))
    ```

- `cryptography.ror(x, disp)`
  - Performs a bitwise right rotation by specified positions.
  - ```lua
      print(cryptography.ror(0x12345678, 4))
    ```

- `cryptography.number_to_bit(x)`
  - Converts a number to a 32-bit integer.
  - ```lua
      print(cryptography.number_to_bit(12345))
    ```

- `cryptography.number_to_hex(x)`
  - Converts a number to its hexadecimal representation.
  - ```lua
      print(cryptography.number_to_hex(255))
      --> "ff"
    ```

- `cryptography.btest(a, b)`
  - Tests if bitwise AND of operands is non-zero.
  - ```lua
      print(cryptography.btest(3, 2)) --> true
    ```

- `cryptography.extract(n, field, width)`
  - Extracts bits from a number.
  - ```lua
      print(cryptography.extract(0xFF, 4, 4)) --> 0xF
    ```

- `cryptography.rrotate(x, disp)`
  - Rotates bits right (negative for left).
  - ```lua
      print(cryptography.rrotate(0x12345678, 4))
    ```

- `cryptography.lrotate(x, disp)`
  - Rotates bits left (negative for right).
  - ```lua
      print(cryptography.lrotate(0x12345678, 4))
    ```

- `cryptography.replace(n, v, field, width)`
  - Replaces bits in a number with another value.
  - ```lua
      print(cryptography.replace(0x1234, 0xF, 4, 4)) --> 0x12F4
    ```

## Global Functions

- `wait(x)`
  - Yields the code for `x` seconds. (Similar to python's wait function)
  - ```lua
      print("Start")
      wait(2) -- Waits 2 seconds
      print("End")
    ```

- `isType(value, type_of_object)`
  - Checks if `value` is a `type_of_object`
  - Available types:
    - |`nil`|`number`|`string`|`boolean`|`table`|`function`|`thread`|`userdata`|
      |-----|--------|--------|---------|-------|----------|--------|----------|
  - ```lua
      print(isType(42, "number")) --> true
      print(isType("hello", "string")) --> true
    ```

- `benchmark(func, iterations)`
  - Performance testing.
  - ```lua
      local function test()
        for i = 1, 1000000 do
          local x = i * i
        end
      end
      
      local total, avg, _ = benchmark(test, 5)
      print(string.format("Total: %.3fs, Average: %.3fs", total, avg))
    ```

- `execution_time(func)`
  - Single execution timing.
  - ```lua
      local time, _ = execution_time(function()
        for i = 1, 1000000 do
          local x = i * i
        end
      end)
      print(string.format("Time: %.3fs", time))
    ```
