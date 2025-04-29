
-- Store the original print function
local original_print = print

-- Override print with custom behavior
print = function(...)
    original_print("Custom print:", ...)
end

-- Test the new print function
print("Hello World")
