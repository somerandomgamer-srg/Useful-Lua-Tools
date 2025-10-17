# Functions and variables counter
echo "Functions: $(($(grep -c '^function [a-z_]*\.' 'Useful Lua Tools.lua') + $(grep '= function(' 'Useful Lua Tools.lua' | grep -v '^mt\.' | grep -v '__' | wc -l)))"
echo "Variables: $(grep -E '^[a-z_]+\.[a-z_]+ = ' 'Useful Lua Tools.lua' | grep -v 'function' | wc -l)"