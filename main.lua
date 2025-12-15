local a = 1
local b = 1
local c = 1
local ans = 0

local function main()
  local disc = b ^ 2 - 4 * a * c

  print(disc)
  if disc < 0 then
    print("No real roots")
    return nil, nil
  end

  return (-b + math.sqrt(disc)) / (2 * a), (-b - math.sqrt(disc)) / (2 * a)
end

io.write(ans .. " ")

for _ = 1, 100 do
  local v1, v2 = main()
  if v1 and v2 then
    ans = v1 + v2
  end
  a = a + 3
  b = b + 2
  c = c + 1
  io.write(ans .. " ")
end