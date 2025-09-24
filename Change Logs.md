# V1.0.0
- ## Date: May 14, 2025 
- ## Description: Release
  - New libary with 26 functions (cryptography)
  - New library with 6 functions (input)
  - 6 new global functions
  - 41 new math functions
  - 10 new string functions
  - 13 new table functions

# V1.1.0
- ## Date: Aug 20, 2025
- ## Description: 2 new libraries
  - New library with 5 variables (ult)
  - New library with 9 variables (system)

# V1.2.0
- ## Date: Aug 22, 2025
- ## Description: New library
  - New library with 6 functions (color)

# V1.2.1
- ## Date: Aug 27, 2025
- ## Description: Time to start documenting my changes (the previous logs are just rough estimations since I just now decided to add this)
  - Added Change Logs

# V1.2.2
- ## Date: Aug 29, 2025 - Sep 5, 2025
  - ## Aug 29, 2025
    - Made the code slightly shorter by combining similar code into singular functions
  - ## Sep 5, 2025
    - Reformatted `Current Functions and Variables.md`
    - 1 new library with 3 functions (remote)
      - Inspired by Roblox remote events in Roblox Studio

# V1.3.0
- ## Date: Sep 8, 2025 - Sep 10, 2025
  - ## Sep 8, 2025
    - Added 1 new library `random` with 1 function: `random.uuid(v)`
    - Removed `cryptography.uuid4()` in favor of `random`.
  - ## Sep 9, 2025
    - Moved `math.random_sign(x)` to `random.sign(x)`
    - Added 2 new `random` library functions: `random.number(min, max, decimals)` and `random.choice(t, amount)`
  - ## Sep 10, 2025
    - Added 3 new `random` library functions: `random.hex(len)`, `random.boolean()`, and `random.string(len, charset)`
    - Added new library `remote` library with 3 functions: `remote.exists()`, `remote.remove()`, and `remote.count()`
    - Added 1 new `table` library function: `table.index(t, value)`

# V1.4.0
- ## Date: Sep 18, 2025 - Sep 19, 2025
  - ## Sep 18, 2025
    - Added 3 new libraries
      - Stack: `stack.new(name)`, `stack.add(name, value)`, `stack.take(name)`, `stack.exists(name)`, `stack.size(name)`, `stack.empty(name)`, `stack.is_empty(name)`
      - Queue: `queue.new(name)`, `queue.add(name, value)`, `queue.take(name)`, `queue.exists(name)`, `queue.size(name)`, `queue.empty(name)`, `queue.is_empty(name)`
      - Datetime: `datetime.time(return_table)`
  - ## Sep 19, 2025
    - Added 4 new `datetime` library functions: `datetime.diff(t1, t2, return_table)`, `datetime.sum(t1, t2, return_table)`, `datetime.to_table(num)`, `datetime.to_number(t)`
    - Removed `is_type()` due to it being redundant and providing no benefit over lua's built-in `type()` function.
    - Moved the legend and summary in `Current Functions and Variables.md` to the top

# V1.4.1
- ## Date: Sep 22, 2025
  - Made the toolkit Lua 5.2 compatible by adding fallbacks for versions that do not support native bitwise operators.
  - Added an error message for Lua versions that don't meet the minimum Lua version to run the toolkit
  - Fixed math.fib(n) and enchanced performance.

# V1.5.0
- ## Date: Sep 23, 2025 - Sep 24, 2025
  - ## Sep 23, 2025
    - Added 3 new `table` library functions: `table.lock()`, `table.unlock()`, and `table.is_locked`
  - ## Sep 24, 2025
    - Updated some functions to accept multiple arguments. Effected functions include:
      - `table.contains(t, value)` --> `table.contains(value, ...)`
      - `table.intersection(t1, t2)` --> `table.intersection(...)`
      - `table.difference(t1, t2)` --> `table.difference(...)`
      - `math.sum(x, y)` --> `math.sum(...)`
      - `datetime.add(return_table, n1, n2)` --> `datetime.add(return_table, ...)`
      - `remote.register(name, func)` --> `remote.register(name, ...)`
      - `stack.add(name, value)` --> `stack.add(name, ...)`
      - `queue.add(name, value)` --> `queue.add(name, ...)`
    - Added 2 new `remote` library functions: `remote.list()` and `remote.clear()`
## NOTE TO SRG: update md file adding every argument change above. add the 3 new table functions