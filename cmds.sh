# Functions and variables counter
echo "Functions: $(grep '^function ' 'Useful Lua Tools.lua' | grep -v '^function local' | wc -l)" && echo "Variables: $(grep -E '^[a-z_]+\.[a-z_]+ = ' 'Useful Lua Tools.lua' | grep -v 'function' | wc -l)" && echo "Total: $(($(grep '^function ' 'Useful Lua Tools.lua' | grep -v '^function local' | wc -l) + $(grep -E '^[a-z_]+\.[a-z_]+ = ' 'Useful Lua Tools.lua' | grep -v 'function' | wc -l)))"

## Library counter with functions and variables
{ echo -e "\nLibraries found:\n"; grep '^function [a-z_]*\.' 'Useful Lua Tools.lua' | sed 's/^function \([a-z_]*\)\..*/\1/' | sort -u; echo -e "\n---Functions per library---\n"; grep '^function [a-z_]*\.' 'Useful Lua Tools.lua' | sed 's/^function \([a-z_]*\)\..*/\1/' | sort | uniq -c | sort -rn; echo -e "\n---Variables per library---\n"; grep -E '^[a-z_]+\.[a-z_]+ = ' 'Useful Lua Tools.lua' | grep -v 'function' | sed 's/^\([a-z_]*\)\..*/\1/' | sort | uniq -c | sort -rn; echo -e "\nGlobal functions: $(grep '^function [a-z_]*(' 'Useful Lua Tools.lua' | wc -l)\nTotal libraries: $(grep '^function [a-z_]*\.' 'Useful Lua Tools.lua' | sed 's/^function \([a-z_]*\)\..*/\1/' | sort -u | wc -l)"; }

# See file size
ls -lh 'Useful Lua Tools.lua'