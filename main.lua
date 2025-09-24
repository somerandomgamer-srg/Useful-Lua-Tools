local function p(...)
  local args = {}
  if type(...) ~= "table" then args = { ... } else args = ... end

  for i, v in ipairs(args) do
    print(i .. ": " .. tostring(v))
  end
end

p({1, 2, 3, 4, 5})