# Useful Lua Tools (Version 2.3.0)
## (A message from the creator)
### About Me
Hello, I am SRG (short for `Some Random Gamer`).
- I have been into coding for about a year.
- I know how to:
  - Code with Lua
  - Code with Luau, a sub-version of Lua that was specifically made for Roblox
  - Make datastores with SQL
- I originally got into coding because of my online friend Michialok.
- I started coding in Roblox and self-taught myself most of the things I know.
- I have completed 5 Computer Science classes.
- I have completed 4 different Engineering classes.
- I can partially code with Python. (Willing to learn more).
- I am planning to learn Javascript.
- I am currently learning Java.
- I am currently learning Java.

## Usage
Nothing much to say here.

1. Require the main file:
```lua
  require("Useful Lua Tools")
```
2. Start using the various functions in your application

## Statistics

### Overall
- **Total Functions**: 213
- **Total Variables**: 17
- **Total Functions/Variables**: 230
- **Total Lines of Code**: 5,594
- **File Size**: 149 KB
- **Language**: Lua 5.3+
- **External Dependencies**: None (pure interpreted Lua)
- **Total Libraries**: 20
- **Global Functions**: 6

### Libraries Included
`bignum`, `binary`, `color`, `cryptography`, `datetime`, `file`, `http`, `input`, `json`, `math`, `queue`, `random`, `remote`, `stack`, `string`, `system`, `table`, `terminal`, `ult`, `validate`

### Functions per Library
|      Library      | Function Count |
|:-----------------:|:--------------:|
|       math        |       44       |
|   cryptography    |       31       |
|       table       |       31       |
|      bignum       |       13       |
|      string       |       12       |
|      binary       |       8        |
|       file        |       8        |
|      remote       |       8        |
|       http        |       7        |
|       queue       |       7        |
|      random       |       7        |
|       stack       |       7        |
|       color       |       6        |
|       input       |       6        |
|     datetime      |       5        |
|     validate      |       3        |
|       json        |       2        |
|     terminal      |       2        |

### Variables per Library
|    Library    | Variable Count |
|:-------------:|:--------------:|
|    system     |       10       |
|      ult      |       5        |
|     math      |       2        |

## Contact
For questions, suggestions, or contributions related to this template:

- **Creator**: Some Random Gamer (SRG)
- **Discord**: [Join my Discord Server!](https://discord.gg/w9aE98gKDs)
- **Issues**: Please report any bugs to the [bugs-suggestions-and-feedback](https://discord.com/channels/1296889247176982528/1298419569135980564) channel
- **Contributions**: DM me on Discord!

# MIT License and Stuff

## License
```
Copyright 2025 Some Random Gamer (SRG)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
## Disclaimers
1. **No Support Obligation**: SRG is under no obligation to provide support, updates, or maintenance for this toolkit.

2. **No Liability for Data Loss**: SRG is not responsible for any data loss or corruption that may occur from using this toolkit.

3. **Performance Considerations**: The functions provided may not be optimized for all use cases or performance requirements.

4. **Security Disclaimer**: While efforts have been made to implement secure functions, this toolkit should not be used for critical security applications without thorough review and testing.

5. **Compatibility**: The toolkit may not be compatible with all Lua versions or implementations. Users should verify compatibility with their specific environment.

6. **Resource Usage**: Some functions may consume significant computational resources depending on input size and complexity. Users should test performance with their specific use cases.

7. **Documentation Accuracy**: While efforts are made to maintain accurate documentation, there may be discrepancies between documentation and actual functionality.

8. **Third-Party Dependencies**: Any issues arising from the use of third-party dependencies or libraries are not the responsibility of SRG.

9. **Breaking Changes**: Future updates may include breaking changes that could affect existing implementations.

10. **User Responsibility**: Users are responsible for testing and validating the functions for their specific use cases before implementing them in production environments.

Test Data Sizes:
  Short:  13 bytes
  Medium: 450 bytes
  Long:   10000 bytes

=== Short String (13 bytes) ===
  Iterations:     5000
  Total time:     0.0969 seconds
  Avg per call:   0.000019 seconds (19.38 µs)
  Ops/second:     51597.99

=== Medium String (450 bytes) ===
  Iterations:     2000
  Total time:     0.2421 seconds
  Avg per call:   0.000121 seconds (121.07 µs)
  Ops/second:     8259.96

=== Long String (10KB) ===
  Iterations:     500
  Total time:     1.2129 seconds
  Avg per call:   0.002426 seconds (2425.71 µs)
  Ops/second:     412.25

=== Empty String ===
  Iterations:     5000
  Total time:     0.0901 seconds
  Avg per call:   0.000018 seconds (18.02 µs)
  Ops/second:     55485.89