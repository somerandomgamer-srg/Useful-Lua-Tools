rockspec_format = "3.0"
package = "useful-lua-tools"
version = "2.1.0-1"

source = {
   url = "git+https://github.com/somerandomgamer-srg/Useful-Lua-Tools",
   tag = "v2.1.0"
}

description = {
   summary = "A collection of useful utility functions for Lua",
   detailed = [[
      Useful Lua Tools is a comprehensive toolkit providing various utility 
      functions for Lua development. Created by Some Random Gamer (SRG), 
      this library offers helpful tools to simplify common programming tasks 
      in Lua and Luau environments.
   ]],
   homepage = "https://github.com/somerandomgamer-srg/Useful-Lua-Tools",
   license = "MIT",
   maintainer = "Some Random Gamer (SRG)"
}

dependencies = {
   "lua >= 5.1, < 5.5"
}

build = {
   type = "builtin",
   modules = {
      ["useful-lua-tools"] = "Useful Lua Tools.lua"
   },
   copy_directories = {
      "doc"
   }
}
