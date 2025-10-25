package = "useful-lua-tools"
version = "2.2.0-1"

source = {
   url = "git+https://github.com/somerandomgamer-srg/Useful-Lua-Tools.git",
   tag = "v2.2.0"
}

description = {
   summary = "A comprehensive Lua utility library with 190+ functions across 15+ modules",
   detailed = [[
      
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
