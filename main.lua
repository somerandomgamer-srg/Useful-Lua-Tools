local a = 1
local b = 150
local c = 1
local ans = 0

local function main()
  local disc = b ^ 2 - 4 * a * c

  if disc < 0 then
    return 1, 1
  end

  return (-b + math.sqrt(disc)) / (2 * a), (-b - math.sqrt(disc)) / (2 * a)
end

io.write(ans .. " ")

for _ = 1, 100 do
  local v1, v2 = main()
  ans = v1 + v2
  a = a + 3
  b = b + 3
  c = c + 14
  io.write(ans .. " ")
end