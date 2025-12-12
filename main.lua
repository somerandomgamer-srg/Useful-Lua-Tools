local v = 5
local prev = 100

io.write(100)

for _ = 1, 100 do
  prev = prev + v
  io.write(prev .. " ")
  v = v + 5
end