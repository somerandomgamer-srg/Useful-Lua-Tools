rockspec_format = "3.0"
package = "useful-lua-tools"
version = "2.0.0-1"

source = {
   url = ""
}

description = {
   summary = "172 ready-to-use Lua utilities for common programming tasks",
   detailed = [[
      Useful Lua Tools (ULT) is a comprehensive Lua utility library providing 
      172 functions across 14 categories including:
      
      - Cryptography (30 functions): XOR, Caesar cipher, Base64, Base32, Base58, 
        Hexadecimal, Octal, ASCII conversion, Luhn validation, IP/email validation
      - Math (41 functions): Statistics, number theory, trigonometry, combinatorics
      - String (11 functions): Cleaning, trimming, splitting, case conversion, 
        Levenshtein distance
      - Table (24 functions): Manipulation, serialization, functional operations
      - File Operations (8 functions): Create, read, write, append, delete files
      - HTTP (5 functions): GET, POST, PUT, DELETE, PATCH requests
      - JSON (2 functions): Encode and decode
      - Data Structures: Stack and Queue implementations
      - Random utilities: UUID generation, random strings, numbers
      - Color conversion: RGB, HSV, HEX
      - DateTime operations
      - Input handling
      - System information detection
      
      Designed to streamline Lua development with pre-built, well-documented solutions.
   ]],
   license = "MIT",
   homepage = "https://replit.com/@Yesitssrg/Useful-Lua-Tools?v=1",
   maintainer = "Some Random Gamer (SRG)"
}

dependencies = {
   "lua >= 5.2"
}

build = {
   type = "builtin",
   modules = {
      ["useful-lua-tools"] = "Useful Lua Tools.lua"
   }
}
