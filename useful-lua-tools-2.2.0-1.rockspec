package = "useful-lua-tools"
version = "2.2.0-1"

source = {
   url = "git+https://github.com/somerandomgamer-srg/Useful-Lua-Tools.git",
   tag = "v2.2.0"
}

description = {
   summary = "A comprehensive Lua utility library with 190+ functions across 15+ modules",
   detailed = [[
      Useful Lua Tools (ULT) is a production-ready, zero-dependency Lua toolkit 
      providing 190+ functions organized into modular libraries including:
      - Math (41 functions): Statistical operations, trigonometry, number theory
      - Cryptography (31 functions): Encoding, hashing (SHA256), validation
      - Table (27 functions): Advanced table manipulation and serialization
      - String (12 functions): Enhanced string operations
      - File (8 functions): File I/O operations
      - HTTP (7 functions): HTTP client operations
      - And many more: Remote, Stack, Queue, DateTime, Binary, JSON, Color, Input, Validate
      
      Features:
      - Zero dependencies - everything is pure Lua
      - Single-file architecture - just require() and use
      - Global injection - functions available as math.func(), string.func(), etc.
      - Cross-platform support (Windows, macOS, Linux, ChromeOS)
      - Complete LuaDoc annotations
      - Built-in benchmarking tools
      - Lua 5.2+ compatible
   ]],
   homepage = "https://github.com/somerandomgamer-srg/Useful-Lua-Tools",
   license = "MIT",
   maintainer = "Some Random Gamer (SRG)"
}

dependencies = {
   "lua >= 5.2"
}

build = {
   type = "builtin",
   modules = {
      ["Useful Lua Tools"] = "Useful Lua Tools.lua"
   }
}
