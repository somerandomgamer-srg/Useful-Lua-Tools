---@diagnostic disable: unused-local

---------Initiation and Module Variables---------

---Error message formatter
local function errorMsg(expected, name, value, index)
  if index then
    error(("%s expected for '%s' at argument %d, given: %s (%s)"):format(expected, name, index, tostring(value),
      type(value)))
  else
    error(("%s expected for '%s', given: %s (%s)"):format(expected, name, tostring(value), type(value)))
  end
end

--Function for both uuid1 and uuid6
local function uuid1and6(v)
  local timestamp = (os.time() + 12219292800) * 10000000
  local clockSeq = math.random(0, 16383)

  local function randomMac()
    local mac = {}
    for i = 1, 6 do
      mac[i] = math.random(0, 255)
    end

    mac[1] = mac[1] % 254 + 2
    return mac
  end

  local function parseMacAddress(macStr)
    if not macStr or type(macStr) ~= "string" then
      return nil
    end

    local macParts = string.split(macStr, ":")
    if not macParts or #macParts ~= 6 then
      return nil
    end

    local mac = {}
    for i = 1, 6 do
      local num = tonumber(macParts[i], 16)
      if not num then return nil end
      mac[i] = num
    end
    return mac
  end

  local macAddr
  if v == 1 then
    macAddr = parseMacAddress(system.mac_address) or randomMac()
  else
    macAddr = randomMac()
  end

  local low = timestamp % 0x100000000
  local middle = math.floor(timestamp / 0x100000000) % 0x10000
  local high = math.floor(timestamp / 0x1000000000000) % 0x1000

  if v == 1 then
    high = high + 0x1000
  else
    high = high + 0x6000
  end

  local cHigh = math.floor(clockSeq / 256) % 64 + 128
  local cLow = clockSeq % 256

  return low, middle, high, cHigh, cLow, macAddr
end

--Function for random.uuid(4)
local function uuid4()
  local returnValue = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
  returnValue = returnValue:gsub("x", function()
    local idx = math.random(16)
    return ("0123456789abcdef"):sub(idx, idx)
  end)
  returnValue = returnValue:gsub("y", function()
    local idx = math.random(4)
    return ("89ab"):sub(idx, idx)
  end)
  return returnValue
end

--Function for random.uuid(1)
local function uuid1()
  local low, middle, high, cHigh, cLow, macAddr = uuid1and6(1)
  return string.format(
    "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
    low, middle, high, cHigh, cLow,
    macAddr[1], macAddr[2], macAddr[3], macAddr[4], macAddr[5], macAddr[6]
  )
end

--Function for random.uuid(6)
local function uuid6()
  local low, middle, high, cHigh, cLow, macAddr = uuid1and6(6)

  local time_high = math.floor((high % 0x1000) * 0x10000) + middle
  local time_mid = math.floor(low / 0x10000)
  local time_low_and_version = (low % 0x1000) + 0x6000

  return string.format(
    "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
    time_high, time_mid, time_low_and_version, cHigh, cLow,
    macAddr[1], macAddr[2], macAddr[3], macAddr[4], macAddr[5], macAddr[6]
  )
end

---Error handler for color.rgb functions
local function rgbProcess(rgb)
  if type(rgb) ~= "table" then errorMsg("Table", "rgb", rgb) end

  local r, g, b = tonumber(rgb[1]), tonumber(rgb[2]), tonumber(rgb[3])

  if not r or not math.is_whole(r) then
    error("R must be a whole number. Given: " .. tostring(r))
  elseif r < 0 or r > 255 then
    error("R cannot be greater than 255 or less than 0. Given: " .. tostring(r))
  elseif not g or not math.is_whole(g) then
    error("G must be a whole number. Given: " .. tostring(g))
  elseif g < 0 or g > 255 then
    error("G cannot be greater than 255 or less than 0. Given: " .. tostring(g))
  elseif not b or not math.is_whole(b) then
    error("B must be a whole number. Given: " .. tostring(b))
  elseif b < 0 or b > 255 then
    error("B cannot be greater than 255 or less than 0. Given: " .. tostring(b))
  end

  return r, g, b
end

---Error handler for color.hex functions
local function hexProcess(hex)
  if type(hex) ~= "string" then errorMsg("String", "hex", hex) end
  hex = (hex:gsub("%s", "")):gsub("#", ""):upper()

  if hex:find("%X") then
    error("Invalid hex code. Can only contain 1-9, a-f, and A-F. Given: " .. hex)
  end

  if #hex ~= 6 then
    error("Hex code must be exactly 6 characters. Given: " .. hex)
  end

  return hex
end

---Error handler for color.hsv functions
local function hsvProcess(hsv)
  if type(hsv) ~= "table" then errorMsg("Table", "hsv", hsv) end

  local h, s, v = tonumber(hsv[1]), tonumber(hsv[2]), tonumber(hsv[3])

  if not h or h < 0 or h > 360 then
    error("Hue must be between 0 and 360. Given: " .. tostring(h))
  elseif not s or s < 0 or s > 1 then
    error("Saturation must be between 0 and 1. Given: " .. tostring(s))
  elseif not v or v < 0 or v > 1 then
    error("Value must be between 0 and 1. Given: " .. tostring(v))
  end

  return h, s, v
end

---Main function for table.shuffle
local function shuffleTable(t)
  local shuffled = {}
  while #t > 0 do
    local rng = math.random(#t)

    table.insert(shuffled, t[rng])
    table.remove(t, rng)
  end

  return shuffled
end

---Main function for table.deep_count_keys
local function countRecursive(t, prefix, separator)
  prefix = prefix or ""
  local keyTable = {}
  local amount = 0

  for key, value in pairs(t) do
    local currentPath = prefix == "" and key or prefix .. separator .. key
    if type(value) == "table" then
      local subAmount, subKeys = countRecursive(value, currentPath, separator)
      amount = amount + subAmount
      for k, v in pairs(subKeys) do keyTable[k] = v end
    end
    keyTable[currentPath] = (keyTable[currentPath] or 0) + 1
    amount = amount + 1
  end
  return amount, keyTable
end

---Function for system.os
local function getOS()
  if package.config:sub(1, 1) == "\\" then
    return "Windows"
  elseif package.config:sub(1, 1) == "/" then
    local uname = io.popen("uname"):read()
    if uname == "Darwin" then
      return "MacOS"
    elseif uname == "Linux" then
      local chromeOSCheck = io.popen("test -d /opt/google/chrome && echo 'chromeos' || echo 'linux'"):read()
      if chromeOSCheck == "chromeos" then
        return "ChromeOS"
      else
        return "Linux"
      end
    end
  end
  return nil
end

---Function for system.uname
local function getUname()
  if system.is_windows then
    return nil
  else
    return io.popen("uname"):read()
  end
end

---Function for system.cores
local function getNumCores()
  if system.is_windows then
    return tonumber(io.popen('powershell -Command "$env:NUMBER_OF_PROCESSORS"'):read()) or nil
  elseif system.is_mac then
    return tonumber(io.popen("sysctl -n hw.logicalcpu"):read()) or nil
  elseif system.is_linux or system.is_chrome then
    return tonumber(io.popen("nproc"):read()) or nil
  end
end

---Function for system.architecture
local function getArchitecture()
  if system.is_windows then
    return io.popen('powershell -Command "$Env:PROCESSOR_ARCHITECTURE"'):read() or nil
  elseif system.is_mac or system.is_chrome or system.is_linux then
    return io.popen("uname -m"):read() or nil
  end
end

---Function for system.mac_address
local function getMac()
  if system.is_windows then
    return io.popen(
          "powershell -Command \"Get-NetAdapter | Where-Object {$_.Status -eq \'Up\'} | Select-Object -First 1 -ExpandProperty MacAddress\"")
        :read() or nil
  elseif system.is_mac then
    return io.popen(
      "route -n get default | awk '/interface:/{print $2}' | xargs ifconfig | awk '/ether/{print $2; exit}'"):read() or
    nil
  elseif system.is_linux then
    return io.popen("ip link | awk '/ether/ {print $2}' | head -n 1"):read() or nil
  elseif system.is_chrome then
    print(
      "Cannot get Mac Address on ChromeOS. ChromeOS doesn't have a command to get Mac Address due to security reasons")
    return nil
  end
end

local is53 = tonumber(_VERSION:sub(5)) >= 5.3

local morseCodeTable = {
  ["a"] = ".-",
  ["b"] = "-...",
  ["c"] = "-.-.",
  ["d"] = "-..",
  ["e"] = ".",
  ["f"] = "..-.",
  ["g"] = "--.",
  ["h"] = "....",
  ["i"] = "..",
  ["j"] = ".---",
  ["k"] = "-.-",
  ["l"] = ".-..",
  ["m"] = "--",
  ["n"] = "-.",
  ["o"] = "---",
  ["p"] = ".--.",
  ["q"] = "--.-",
  ["r"] = ".-.",
  ["s"] = "...",
  ["t"] = "-",
  ["u"] = "..-",
  ["v"] = "...-",
  ["w"] = ".--",
  ["x"] = "-..-",
  ["y"] = "-.--",
  ["z"] = "--..",
  ["1"] = ".----",
  ["2"] = "..---",
  ["3"] = "...--",
  ["4"] = "....-",
  ["5"] = ".....",
  ["6"] = "-....",
  ["7"] = "--...",
  ["8"] = "---..",
  ["9"] = "----.",
  ["0"] = "-----",
  [" "] = "/",
  ["!"] = "-.-.--",
  ["@"] = ".--.-.",
  ["&"] = ".-...",
  ["("] = "-.--.",
  [")"] = "-.--.-",
  ["-"] = "-....-",
  ["="] = "-...-",
  ["+"] = ".-.-.",
  [":"] = "---...",
  ["'"] = ".----.",
  ['"'] = ".-..-.",
  [","] = "--..--",
  ["."] = ".-.-.-",
  ["/"] = "-..-.",
  ["?"] = "..--.."
}

-- Base64 alphabet (RFC 4648)
local base64Alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

-- Base32 alphabet (RFC 4648)
local base32Alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"

-- Generate Base64 character mapping from binary patterns
local base64Chars = {}
for i = 0, 63 do
  local binaryPattern = string.format("%06d", tonumber(string.format("%b", i):gsub("1", "1"):gsub("0", "0")))
  base64Chars[binaryPattern] = base64Alphabet:sub(i + 1, i + 1)
end

-- Generate Base32 character mapping from binary patterns
local base32Chars = {}
for i = 0, 31 do
  local binaryPattern = string.format("%05d", tonumber(string.format("%b", i):gsub("1", "1"):gsub("0", "0")))
  base32Chars[binaryPattern] = base32Alphabet:sub(i + 1, i + 1)
end

local base58Chars = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"

local remotes = {}
local stacks = {}
local queues = {}

local function createKeypairReverse(t)
  local reversed = {}
  for k, v in pairs(t) do
    reversed[v] = k
  end
  return reversed
end

local morseReverse = createKeypairReverse(morseCodeTable)
local base64Reverse = createKeypairReverse(base64Chars)
local base32Reverse = createKeypairReverse(base32Chars)

---------Initiate Libraries---------

---@class cryptographylib
cryptography = {}

---@class inputlib
input = {}

---@class systemlib
system = {}

---@class ultlib
ult = {}

---@class colorlib
color = {}

---Inspired by Roblox `Remote Events` in Roblox Studio
---@class remotelib
remote = {}

---@class randomlib
random = {}

---@class stacklib
stack = {}

---@class queuelib
queue = {}

---@class datetimelib
datetime = {}

-----------ULT Main Library-----------

---***SRG Custom Variable***
---
---The version of Useful Lua Tools
---
---"Major Update"."Minor Update"."Patch/Very Minor Update"
---@nodiscard
ult.version = "1.5.0"

---***SRG Custom Variable***
---
---The people who contributed to Useful Lua Tools
---@nodiscard
ult.contributors = {
  "SRG (Some Random Gamer)"
}

---***SRG Custom Variable***
---
---The minimum version of Lua required to run Useful Lua Tools
---@nodiscard
ult.min_lua_ver = "5.2"

if _VERSION:sub(5) < ult.min_lua_ver then
  error("Useful Lua Tools requires Lua " .. ult.min_lua_ver .. " or higher. You are running Lua " .. _VERSION:sub(5))
end

---***SRG Custom Variable***
---
---The release date of the current ULT version
---@nodiscard
ult.release_date = "09/25/2025"

---***SRG Custom Variable***
---
---The current build of Useful Lua Tools
---
---"Project"-"version"-"date of release"-"minimum lua version"
---@nodiscard
ult.build = ("ult-%s-%s-%s"):format(ult.version, ult.release_date, ult.min_lua_ver)

------------Random Library------------

---Generates a uuid
---
---UUID V1:
---- Generates a time-based UUID (version 1) using MAC address and timestamp
---- Format: `time_low-time_mid-time_high_and_version-clock_seq_high_and_reserved+clock_seq_low-mac_address`
---- Based on timestamp and MAC address
---- Guarantees uniqueness across time and space
---
---UUID V4:
---- Generates a purely random UUID (version 4)
---- Format: `xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`
---- `x`: 0-9 or a-f, `4` indicates version 4, `y`: 8, 9, a, or b
---- Extremely low collision probability
---
---UUID V6:
---- Generates a time-based UUID (version 6) with reordered timestamp for chronological sorting
---- Format: `time_high-time_mid-time_low_and_version-clock_seq_and_variant-random_node`
---- Uses random node ID instead of MAC address for privacy
---- Maintains v1 uniqueness with better database performance
---@return string
function random.uuid(v)
  if type(v) ~= "number" then errorMsg("Number", "v", v) end

  local funcs = {
    [1] = uuid1,
    [4] = uuid4,
    [6] = uuid6
  }

  return funcs[v]()
end

---***SRG Custom Function***
---
---Randomly makes `x` positive or negative
---@param x number
---@return number
function random.sign(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  local r = math.random(2)
  if r == 2 then
    return -x
  else
    return x
  end
end

---***SRG Custom Function***
---
---Generates a random number between `min` and `max` with `decimals` places (whole number is `decimals` is not provided)
---@param min number
---@param max number
---@param decimals number?
---@return number
function random.number(min, max, decimals)
  if type(min) ~= "number" then errorMsg("Number", "min", min) end
  if type(max) ~= "number" then errorMsg("Number", "max", max) end
  if decimals and type(decimals) ~= "number" then errorMsg("Number", "decimals", decimals) end

  if not decimals or decimals < 1 then return math.random(min, max) end
  decimals = math.floor(decimals)

  local s = tostring(math.random(min, max)) .. "."

  for _ = 1, decimals do
    s = s .. tostring(math.random(0, 9))
  end
  return tonumber(s)
end

---***SRG Custom Function***
---
---Randomly selects element(s) from table `t`. Returns single element if `amount` < 2, otherwise returns table of `amount` elements
---@param t table
---@param amount number?
---@return any
function random.choice(t, amount)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end
  if amount and type(amount) ~= "number" then errorMsg("Number", "amount", amount) end
  if amount then amount = math.floor(amount) end

  t = table.copy(t)

  if not amount or amount < 2 then return t[math.random(#t)] end

  local choices = {}

  for _ = 1, amount do
    local rng = math.random(#t)
    table.insert(choices, t[rng])
    table.remove(t, rng)
  end

  return choices
end

---***SRG Custom Function***
---
---Generates a random hexadecimal string of specified length
---@param len number
---@return string
function random.hex(len)
  if type(len) ~= "number" then errorMsg("Number", "len", len) end
  len = len >= 1 and math.floor(len) or 1

  local s = "0123456789ABCDEF"
  local toReturn = ""

  for _ = 1, len do
    local idx = math.random(16)
    toReturn = toReturn .. s:sub(idx, idx)
  end

  return toReturn
end

---***SRG Custom Function***
---
---Generates a random boolean value (true or false)
---@return boolean
function random.boolean()
  if math.random(2) == 2 then
    return true
  else
    return false
  end
end

---***SRG Custom Function***
---
---Generates a random string of specified length using provided character set
---@param len number
---@param charset string?
---@return string
function random.string(len, charset)
  if type(len) ~= "number" then errorMsg("Number", "len", len) end
  len = len >= 1 and math.floor(len) or 1

  if not charset or type(charset) ~= "string" or #charset == 0 then
    charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
  end

  local s = ""
  for _ = 1, len do
    s = s .. charset:sub(math.random(#charset), math.random(#charset))
  end

  return s
end

------------System Library------------

---***SRG Custom Variable***
---
---The OS the system is running on, or nil if it cannot be determined
---@nodiscard
system.os = getOS()

---***SRG Custom Variable***
---
---true if the host system is running on Windows, false otherwise
---@nodiscard
system.is_windows = system.os == "Windows"

---***SRG Custom Variable***
---
---true if the host system is running on MacOS, false otherwise
---@nodiscard
system.is_mac = system.os == "MacOS"

---***SRG Custom Variable***
---
---true if the host system is running on Linux, false otherwise
---@nodiscard
system.is_linux = system.os == "Linux"

---***SRG Custom Variable***
---
---true if the host system is running on Chrome OS, false otherwise
---@nodiscard
system.is_chrome = system.os == "ChromeOS"

---***SRG Custom Variable***
---
---The system Unix Name, or nil if it cannot be determine
---@nodiscard
system.uname = getUname()

---***SRG Custom Variable***
---
---Amount of CPU Cores the host system has, or nil if it cannot be determined
---@nodiscard
system.cores = getNumCores()

---***SRG Custom Variable***
---
---The CPU architecture of the host system, or nil if it cannot be determined
---@nodiscard
system.architecture = getArchitecture()

---***SRG Custom Variable***
---
---true if the host system is built on Linux, false otherwise
---@nodiscard
system.is_linux_based = io.popen("uname"):read() ~= nil

---***SRG Custom Variable***
---
---Returns the Mac
system.mac_address = getMac()

-------------Color Library------------

---***SRG Custom Function***
---
---Converts RGB(`r`,`g`,`b`) to HEX(`RRGGBB`)
---@param rgb table
---@return string hex
---@nodiscard
function color.rgb_to_hex(rgb)
  local r, g, b = rgbProcess(rgb)

  local function process(n, nn, nnn)
    n, nn, nnn = n + 1, nn + 1, nnn + 1
    local str = "0123456789ABCDEF"
    return str:sub(n, n), str:sub(nn, nn), str:sub(nnn, nnn)
  end

  local n1, n3, n5 = process(math.floor(r / 16), math.floor(g / 16), math.floor(b / 16))

  local n2, n4, n6 = process(r % 16, g % 16, b % 16)

  return "#" .. n1 .. n2 .. n3 .. n4 .. n5 .. n6
end

---***SRG Custom Function***
---
---Converts RGB(`r`,`g`,`b`) to HSV(`h`,`s`,`v`)
---@param rgb table
---@return table hsv
---@nodiscard
function color.rgb_to_hsv(rgb)
  local r, g, b = rgbProcess(rgb)
  local h, s, v

  r, g, b = r / 255, g / 255, b / 255

  v = math.max(r, g, b)

  local c = v - math.min(r, g, b)

  if v == 0 then
    s = 0
  else
    s = c / v
  end

  if c == 0 then
    h = 0
  elseif v == r then
    h = 60 * ((g - b) / c)
  elseif v == g then
    h = 60 * ((b - r) / c + 2)
  elseif v == b then
    h = 60 * ((r - g) / c + 4)
  end

  h = (h + 360) % 360
  if h == 0 and c ~= 0 then h = 360 end

  return { h, s, v }
end

---***SRG Custom Function***
---
---Converts HEX(`RRGGBB`) to RGB(`r`,`g`,`b`)
---@param hex string
---@return table rgb
---@nodiscard
function color.hex_to_rgb(hex)
  hex = hexProcess(hex)

  local rgb = ""
  local rgbTable = {}
  local replace = { f = 15, e = 14, d = 13, c = 12, b = 11, a = 10 }

  for i = 1, #hex do
    local char = tonumber(hex:sub(i, i))
    rgb = rgb .. (char and char or replace[hex:sub(i, i):lower()]) .. " "
  end

  local t = string.split(rgb, " ")

  for i = 1, #t, 2 do
    table.insert(
      rgbTable,
      tonumber(t[i]) * 16 + tonumber(t[i + 1])
    )
  end

  return rgbTable
end

---***SRG Custom Function***
---
---Converts HEX(`RRGGBB`) to HSV(`h`,`s`,`v`)
---@param hex string
---@return table hsv
---@nodiscard
function color.hex_to_hsv(hex)
  hex = hexProcess(hex)

  return color.rgb_to_hsv(color.hex_to_rgb(hex))
end

---***SRG Custom Function***
---
---Converts HSV(`h`,`s`,`v`) to RGB(`r`,`g`,`b`)
---@param hsv table
---@return table rgb
---@nodiscard
function color.hsv_to_rgb(hsv)
  local h, s, v = hsvProcess(hsv)

  h = h / 60
  local c = v * s
  local x = c * (1 - math.abs(h % 2 - 1))
  local r, g, b

  if h < 1 then
    r, g, b = c, x, 0
  elseif h < 2 then
    r, g, b = x, c, 0
  elseif h < 3 then
    r, g, b = 0, c, x
  elseif h < 4 then
    r, g, b = 0, x, c
  elseif h < 5 then
    r, g, b = x, 0, c
  else
    r, g, b = c, 0, x
  end

  local m = v - c
  r = (r + m) * 255
  g = (g + m) * 255
  b = (b + m) * 255

  return { math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5) }
end

---***SRG Custom Function***
---
---Converts HSV(`h`,`s`,`v`) to HEX(`RRGGBB`)
---@param hsv table
---@return string hex
---@nodiscard
function color.hsv_to_hex(hsv)
  local _, _, _ = hsvProcess(hsv)

  return color.rgb_to_hex(color.hsv_to_rgb(hsv))
end

---------Cryptography Library---------

---***SRG Custom Function***
---
---Converts plaintext to ASCII code numbers.
---@param s string
---@return string
---@nodiscard
function cryptography.text_to_ascii(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local ascii = ""
  for i in s do ascii = ascii .. s[i]:byte() .. " " end
  return string.trim(ascii)
end

---***SRG Custom Function***
---
---Converts ASCII code numbers to plaintext.
---@param s string
---@return string
---@nodiscard
function cryptography.ascii_to_text(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if not s:match("^%d+%s*") then error("Input must be space-separated ASCII numbers.") end

  local text = ""
  for num in s:gmatch("%d+") do
    local n = string.clean_number(num)
    if n < 0 or n > 255 then error("ASCII values must be between 0 and 255.") end
    text = text .. n:char()
  end
  return text
end

---***SRG Custom Function***
---
---Converts plaintext to hexadecimal.
---@param s string
---@return string
---@nodiscard
function cryptography.text_to_hex(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local hex = ""
  for i = 1, #s do hex = hex .. ("%02X"):format(s[i]:byte()) .. " " end
  return hex
end

---***SRG Custom Function***
---
---Converts hexadecimal to plaintext.
---@param s string
---@return string
---@nodiscard
function cryptography.hex_to_text(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if not s:match("^%d+%s*") then error("Input must be space-seperated.") end

  local text = ""
  for hex in s:gmatch("..") do text = text .. tostring(tonumber(hex, 16)):char() end
  return text
end

---***SRG Custom Function***
---
---Converts plaintext to binary (`x` bits).
---
---`x` defaults to `8` if not given.
---@param s string
---@param x? number
---@return string
---@nodiscard
function cryptography.text_to_binary(s, x)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  if x then
    if type(x) ~= "number" then errorMsg("Number", "x", x) end
    if x <= 0 then error("'x' cannot be less than or equal to 0. Given: " .. tostring(x)) end
    if not math.is_whole(x) then error("'x' must be a whole number. Given: " .. tostring(x)) end
  else
    x = 8
  end

  local binary = ""
  for i = 1, #s do binary = binary .. ("%0*b"):format(x, s:byte(i)) end
  return string.trim(binary)
end

---***SRG Custom Function***
---
---Converts binary (`x` bits) to plaintext.
---
---`x` defaults to `8` if not given.
---@param s string
---@param x? number
---@return string
---@nodiscard
function cryptography.binary_to_text(s, x)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  if x then
    if type(x) ~= "number" then errorMsg("Number", "x", x) end
    if x <= 0 then error("'x' cannot be less than or equal to 0. Given: " .. tostring(x)) end
    if not math.is_whole(x) then error("'x' must be a whole number. Given: " .. tostring(x)) end
  else
    x = 8
  end

  local text = ""
  for i = 1, #s, x do text = text .. tostring(tonumber(s:sub(i, i + x - 1), 2)):char() end
  return text
end

---***SRG Custom Function***
---
---Converts plaintext to space-seperated octal.
---@param s string
---@return string
---@nodiscard
function cryptography.text_to_octal(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local octal = ""
  for i = 1, #s do octal = octal .. ("%o"):format(s[i]:byte()) .. " " end
  return string.trim(octal)
end

---***SRG Custom Function***
---
---Converts space-seperated octal to plaintext.
---@param s string
---@return string
---@nodiscard
function cryptography.octal_to_text(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if not s:match("^%d+%s*") then error("Input must be space-seperated.") end

  local text = ""
  for octal in s:gmatch("%d+") do text = text .. tostring(tonumber(octal, 8)):char() end
  return text
end

---***SRG Custom Function***
---
---Converts plaintext to morse code.
---@param s string
---@return string
---@nodiscard
function cryptography.text_to_morse(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local morse = ""
  for char in #s:lower() do
    local code = morseCodeTable[char]
    if code then morse = morse .. code .. " " end
  end
  return string.trim(morse)
end

---***SRG Custom Function***
---
---Converts morse code to plaintext.
---@param s string
---@return string
---@nodiscard
function cryptography.morse_to_text(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  s = s:gsub(" / ", "  ")

  local text = ""
  for symbol in s:gmatch("%S+") do
    local char = morseReverse[symbol]
    if char then text = text .. char end
  end
  return text
end

---***SRG Custom Function***
---
---Converts plaintext to base64.
---@param s string
---@return string
---@nodiscard
function cryptography.text_to_base64(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local bits = {}
  local encoded = ""
  local binary = cryptography.text_to_binary(s)

  for i = 1, #binary, 6 do
    local chunk = binary:sub(i, i + 5)
    while #chunk < 6 do chunk = chunk .. "0" end
    table.insert(bits, chunk)
  end

  for i = 1, #bits do encoded = encoded .. base64Chars[bits[i]] end

  if #s % 3 ~= 0 then encoded = encoded .. ("="):rep(3 - (#s % 3)) end
  return encoded
end

---***SRG Custom Function***
---
---Converts base64 to plaintext.
---@param s string
---@return string
---@nodiscard
function cryptography.base64_to_text(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  s = s:gsub("=", "")

  local binary = ""

  for i = 1, #s do binary = binary .. base64Reverse[s[i]] end

  if #binary % 8 ~= 0 then binary = binary:sub(1, #binary - (#binary % 8)) end

  return cryptography.binary_to_text(binary)
end

---***SRG Custom Function***
---
---Converts plaintext to base32.
---@param s string
---@return string
---@nodiscard
function cryptography.text_to_base32(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local bits = {}
  local encoded = ""
  local binary = cryptography.text_to_binary(s)

  for i = 1, #binary, 5 do
    local chunk = binary:sub(i, i + 4)
    while #chunk < 5 do chunk = chunk .. "0" end
    table.insert(bits, chunk)
  end

  for i = 1, #bits do encoded = encoded .. base32Chars[bits[i]] end

  if #s % 8 ~= 0 then encoded = encoded .. ("="):rep(8 - (#s % 8)) end
  return encoded
end

---***SRG Custom Function***
---
---Converts base32 to plaintext.
---@param s string
---@return string
---@nodiscard
function cryptography.base32_to_text(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  s = s:gsub("=", "")

  local binary = ""

  for i = 1, #s do binary = binary .. base32Reverse[s[i]] end

  if #binary % 8 ~= 0 then binary = binary:sub(1, #binary - (#binary % 8)) end

  return cryptography.binary_to_text(binary)
end

---***SRG Custom Function***
---
---Converts plaintext to base58.
---@param s string
---@return string
---@nodiscard
function cryptography.text_to_base58(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  s = s:gsub("=", "")

  local binary = ""

  for i = 1, #s do binary = binary .. base32Reverse[s[i]] end

  if #binary % 8 ~= 0 then binary = binary:sub(1, #binary - (#binary % 8)) end

  return cryptography.binary_to_text(binary)
end

---***SRG Custom Function***
---
---Performs bitwise SWAP operation on `x`.
---@param x number
---@return number
---@nodiscard
function cryptography.bswap(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  if is53 then
    local byte1 = (x & 0xFF) << 24
    local byte2 = ((x >> 8) & 0xFF) << 16
    local byte3 = ((x >> 16) & 0xFF) << 8
    local byte4 = (x >> 24) & 0xFF
    return (byte1 | byte2) | (byte3 | byte4)
  else
    return bit.bswap(x)
  end
end

---***SRG Custom Function***
---
---Performs a bitwise left rotation on `x` by `disp` positions.
---@param x number
---@param disp number
---@return number
function cryptography.rol(x, disp)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(disp) ~= "number" then errorMsg("Number", "disp", disp) end

  disp = disp % 32
  if is53 then
    return ((x << disp) | (x >> (32 - disp))) & 0xFFFFFFFF
  else
    return bit32.lrotate(x, disp)
  end
end

---***SRG Custom Function***
---
---Performs a bitwise right rotation on `x` by `disp` positions.
---@param x number
---@param disp number
---@return number
function cryptography.ror(x, disp)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(disp) ~= "number" then errorMsg("Number", "disp", disp) end

  disp = disp % 32
  if is53 then
    return ((x >> disp) | (x << (32 - disp))) & 0xFFFFFFFF
  else
    return bit32.rrotate(x, disp)
  end
end

---***SRG Custom Function***
---
---Converts `x` to its binary representation.
---@param x number
---@return string
function cryptography.number_to_bit(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  if is53 then
    local binary = ""
    for i = 31, 0, -1 do
      local bit = (x >> i) & 1
      binary = binary .. bit
    end
    return binary
  else
    return bit.tobit(x)
  end
end

---***SRG Custom Function***
---
---@Converts `x` to its hexadecimal representation.
---@param x number
---@return string
function cryptography.number_to_hex(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return ("%x"):format(x % 0x100000000)
end

---***SRG Custom Function***
---
---Returns a boolean signaling whether the bitwise *and* of its operands is different from zero.
---@param ... number
---@return boolean
function cryptography.btest(...)
  if type(...) ~= "number" then errorMsg("Number", "...", ...) end
  local args = { ... }
  if #args < 2 then error("At least two numbers are required") end
  for i, num in ipairs(args) do
    if type(num) ~= "number" then errorMsg("Number", "num", num, i) end
  end

  if is53 then
    local result = args[1]
    for i = 2, #args do result = result & args[i] end
    return result ~= 0
  else
    return bit32.btest(table.unpack(args))
  end
end

---***SRG Custom Function***
---
---Returns the unsigned number formed by the bits `field` to `field + width - 1` from `n`.
---@param n number
---@param field number
---@param width? number
---@return number
function cryptography.extract(n, field, width)
  if type(n) ~= "number" then errorMsg("Number", "n", n) end
  if type(field) ~= "number" then errorMsg("Number", "field", field) end
  if width and type(width) ~= "number" then errorMsg("Number", "width", width) end
  width = width or 1

  if is53 then
    local mask = (1 << width) - 1
    return (n >> field) & mask
  else
    return bit32.extract(n, field, width)
  end
end

---***SRG Custom Function***
---
---Returns a copy of `n` with the bits `field` to `field + width - 1` replaced by the value `v`.
---@param n number
---@param v number
---@param field number
---@param width? number
---@return number
function cryptography.replace(n, v, field, width)
  if type(n) ~= "number" then errorMsg("Number", "n", n) end
  if type(v) ~= "number" then errorMsg("Number", "v", v) end
  if type(field) ~= "number" then errorMsg("Number", "field", field) end
  if width and type(width) ~= "number" then errorMsg("Number", "width", width) end
  width = width or 1

  if is53 then
    local mask = (1 << width) - (1 << field)
    return (n & ~mask) | ((v & (1 << width) - 1) << field)
  else
    return bit32.replace(n, v, field, width)
  end
end

---***SRG Custom Function***
---
---Performs XOR encryption/decryption on a string (`s`) using a key (`key`)
---
---Note: XOR is symmetric - use the same key to decrypt
---@param s string
---@param key string
---@return string
---@nodiscard
function cryptography.xor(s, key)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if type(key) ~= "string" then errorMsg("String", "key", key) end

  local encrypted = ""

  for i = 1, #s do
    local charByte = s:sub(i, i):byte()
    local keyByte = key:sub((i - 1) % #key + 1, (i - 1) % #key + 1):byte()
    local encryptedByte
    if is53 then
      encryptedByte = charByte ~ keyByte
    else
      encryptedByte = bit32.bxor(charByte, keyByte)
    end
    encrypted = encrypted .. string.char(encryptedByte)
  end

  return encrypted
end

---***SRG Custom Function***
---
---Applies Caesar cipher encryption to a string (`s`) with specified shift (`shift`)
---@param s string
---@param shift number
---@return string
---@nodiscard
function cryptography.caesar_cipher(s, shift)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if type(shift) ~= "number" then errorMsg("Number", "shift", shift) end

  local encrypted = ""

  for i = 1, #s do
    local character = s:sub(i, i)
    if character:match("%a") then
      local base = character:match("%u") and 65 or 97
      local shifted = ((character:byte() - base + shift) % 26 + 26) % 26 + base
      encrypted = encrypted .. string.char(shifted)
    else
      encrypted = encrypted .. character
    end
  end

  return encrypted
end

---***SRG Custom Function***
---
---Applies ROT13 encryption on `s` (Caesar cipher with shift of 13).
---@param s string
---@return string
---@nodiscard
function cryptography.rot13(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  return cryptography.caesar_cipher(s, 13)
end

---------Input Library---------

---***SRG Custom Function***
---
---Gets string input with an optional print `message`.
---@param message? string
---@return string
---@nodiscard
function input.string(message)
  if message then
    if type(message) ~= "string" then errorMsg("String", "message", message) end
  else
    message = ""
  end

  io.write(message .. ": ")
  local inp = io.read()
  if not inp then
    print("Failed to read input")
    return ""
  end
  return inp
end

---***SRG Custom Function***
---
---Returns a table with `number_of_inputs` string inputs with an optional print `message`.
---@param number_of_inputs number
---@param message? string
---@return table inputs
---@nodiscard
function input.table(number_of_inputs, message)
  if message then
    if type(message) ~= "string" then errorMsg("String", "message", message) end
  else
    message = ""
  end

  if type(number_of_inputs) ~= "number" then
    error("Number of inputs must be a number")
    return {}
  end
  if number_of_inputs < 1 then
    error("Number of inputs must be greater than 0")
    return {}
  end

  io.write(message)
  local inputs = {}
  for i = 1, number_of_inputs do
    io.write("\ninput " .. i)
    local inp = io.read()
    if not inp then
      print("Failed to read input at input #" .. i)
      return {}
    end
    inputs[i] = inp
  end
  return inputs
end

---***SRG Custom Function***
---
---Gets numeric input with an optional print `message`.
---@param message? string
---@return number input
---@nodiscard
function input.number(message)
  if message then
    if type(message) ~= "string" then errorMsg("String", "message", message) end
  else
    message = ""
  end

  io.write(message .. ": ")
  local inp = io.read()
  if not inp then
    print("Failed to read input")
    return 0
  end

  local num = tonumber(string.clean_number(inp))
  if not num then
    print("Invalid number input")
    return 0
  end
  return num
end

---***SRG Custom Function***
---
---Returns a table with `number_of_inputs` numberic inputs with an optional print `message.
---@param message? string
---@param number_of_inputs number
---@return table
---@nodiscard
function input.number_table(message, number_of_inputs)
  if message then
    if type(message) ~= "string" then errorMsg("String", "message", message) end
  else
    message = ""
  end

  if type(number_of_inputs) ~= "number" then error("Number of inputs must be a number") end
  if number_of_inputs < 1 then error("Number of inputs must be greater than 0") end

  io.write(message)

  local inputs = {}
  for i = 1, number_of_inputs do
    io.write(("\ninput %d:"):format(i))
    local num = tonumber(string.clean_number(io.read()))
    if not num then print(("Invalid number at input %d:"):format(i)) end
    inputs[i] = num and tonumber(num) or 0
  end
  return inputs
end

---***SRG Custom Function***
---
---Returns a table of string inputs until empty submission with an optional print `message`.
---@param message? string
---@return table
---@nodiscard
function input.loop(message)
  if message then
    if type(message) ~= "string" then errorMsg("String", "message", message) end
  else
    message = ""
  end

  local inputs = {}
  local current = 1

  io.write("(press enter with nothing typed to submit) " .. message)
  while true do
    io.write(("\nInput %d:"):format(current))
    local inp = io.read()
    if inp == "" then break end
    inputs[current] = tostring(inp)
    current = current + 1
  end

  return inputs or {}
end

---***SRG Custom Function***
---
---Returns a table of numeric inputs until empty submission with an optional print `message`.
---@param message? string
---@return table
---@nodiscard
function input.number_loop(message)
  if message then
    if type(message) ~= "string" then errorMsg("String", "message", message) end
  else
    message = ""
  end

  local inputs = {}
  local current = 1

  io.write("(press enter with nothing typed to submit) " .. message)
  while true do
    io.write(("\nInput %d:"):format(current))
    local inp = io.read()
    if inp == "" then break end

    local num = tonumber(string.clean_number(inp))
    if not num then print("Invalid number at input " .. current) end
    inputs[current] = num and tonumber(num) or 0
    current = current + 1
  end

  return inputs or {}
end

--------------Stack Library-------------

---***SRG Custom Function***
---
---Creates a new stack with the specified `name`.
---@param name string
function stack.new(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if stacks[name] then error(string.format("Stack '%s' already exists.", name)) end

  stacks[name] = {}
end

---***SRG Custom Function
---
---Adds one or more values to the stack with the specified `name`.
---@param name string
---@param ... any
function stack.add(name, ...)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if not stacks[name] then error(string.format("Stack '%s' does not exist.", name)) end

  for _, value in ipairs({ ... }) do table.insert(stacks[name], value) end
end

---***SRG Custom Function***
---
---Takes the top value from the stack with the specified `name` and removes it if `remove` is true.
---@param name string
---@param remove? boolean
---@return value any
function stack.take(name, remove)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if not stacks[name] then error(string.format("Stack '%s' does not exist.", name)) end

  local toReturn = stacks[name][#stacks[name]]
  if remove then table.remove(stacks[name], #stacks[name]) end
  return toReturn
end

---***SRG Custom Function***
---
---Checks if the stack with the specified `name` exists.
---@param name string
---@return boolean
function stack.exists(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end

  if stacks[name] then return true end
  return false
end

---***SRG Custom Function***
---
---Returns the amount of values in the stack with the specified `name`.
---@param name string
---@return number
function stack.size(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if not stacks[name] then error(string.format("Stack '%s' does not exist.", name)) end

  return #stacks[name]
end

---***SRG Custom Function***
---
---Empties the stack with the specified `name`.
---@param name string
function stack.empty(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if not stacks[name] then error(string.format("Stack '%s' does not exist.", name)) end

  stacks[name] = {}
end

---***SRG Custom Function***
---
---Checks if the stack with the specified `name` is empty.
---@param name string
---@return boolean
function stack.is_empty(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if not stacks[name] then error(string.format("Stack '%s' does not exist.", name)) end

  return #stacks[name] == 0
end

--------------Queue Library-------------

---***SRG Custom Function***
---
---Creates a new queue with the specified `name`.
---@param name string
function queue.new(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if not queues[name] then error(string.format("Queue '%s' already exists.", name)) end

  queues[name] = {}
end

---***SRG Custom Function***
---
---Adds one or more values to the queue with the specified `name`.
---@param name string
---@param ... any
function queue.add(name, ...)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if not queues[name] then error(string.format("Queue '%s' does not exist.", name)) end

  for _, value in ipairs({ ... }) do table.insert(queues[name], value) end
end

---***SRG Custom Function***
---
---Takes the first value from the queue with the specified `name` and removes it if `remove` is true.
---@param name string
---@param remove? boolean
---@return value any
function queue.take(name, remove)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if not queues[name] then error(string.format("Queue '%s' does not exist.", name)) end

  local toReturn = queues[name][1]
  if remove then table.remove(queues[name], 1) end
  return toReturn
end

---***SRG Custom Function***
---
---Checks if the queue with the specified `name` exists.
---@param name string
---@return boolean
function queue.exists(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end

  if queues[name] then return true end
  return false
end

---***SRG Custom Function***
---
---Returns the amount of values in the queue with the specified `name`.
---@param name string
---@return number
function queue.size(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if not queues[name] then error(string.format("Queue '%s' does not exist.", name)) end

  return #queues[name]
end

---***SRG Custom Function***
---
---Empties the queue with the specified `name`.
---@param name string
function queue.empty(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if not queues[name] then error(string.format("Queue '%s' does not exist.", name)) end

  queues[name] = {}
end

---***SRG Custom Function***
---
---Checks if the queue with the specified `name` is empty.
---@param name string
---@return boolean
function queue.is_empty(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if not queues[name] then error(string.format("Queue '%s' does not exist.", name)) end

  return #queues[name] == 0
end

------------Datetime Library------------

---***SRG Custom Function***
---
--- Returns the current time.
---
---If `return_table` is false or not given, returns a number in the format `Year Month Day Hour Minute Second`. Otherwise, returns a table with the values `year`, `month`, `day`, `hour`, `minute`, and `second`.
---@param return_table? boolean
---@return table|number
---@nodiscard
function datetime.time(return_table)
  local t = os.date("*t")

  if return_table then
    return {
      year = t.year,
      month = t.month,
      day = t.day,
      hour = t.hour,
      minute = t.min,
      second = t.sec
    }
  end
  return tonumber(string.format("%04d%02d%02d%02d%02d%02d", t.year, t.month, t.day, t.hour, t.min, t.sec))
end

---***SRG Custom Function***
---
---Returns the difference between `n1` and `n2`.
---
---If `return_table` is false or not given, returns a number in the format `Year Month Day Hour Minute Second`. Otherwise, returns a table with the values `year`, `month`, `day`, `hour`, `minute`, and `second`.
---@param n1 number
---@param n2 number
---@param return_table? boolean
---@return number|table
---@nodiscard
function datetime.diff(n1, n2, return_table)
  if type(n1) ~= "number" then errorMsg("Number", "n1", n1) end
  if #tostring(n1) ~= 14 then error("n1 must be a 14 digit number") end

  if type(n2) ~= "number" then errorMsg("Number", "n2", n2) end
  if #tostring(n2) ~= 14 then error("n2 must be a 14 digit number") end

  local diff = tostring(n1 - n2):find("-") and tonumber(string.format("%014d", n2 - n1)) or
  tonumber(string.format("%014d", n1 - n2))

  if return_table then
    return {
      year = tonumber(string.sub(diff, 1, 4)),
      month = tonumber(string.sub(diff, 5, 6)),
      day = tonumber(string.sub(diff, 7, 8)),
      hour = tonumber(string.sub(diff, 9, 10)),
      minute = tonumber(string.sub(diff, 11, 12)),
      second = tonumber(string.sub(diff, 13, 14))
    }
  end
  return tonumber(string.format("%014d", diff))
end

---***SRG Custom Function***
---
---Returns the sum of each time given.
---
---If `return_table` is false or not given, returns a number in the format `Year Month Day Hour Minute Second`. Otherwise, returns a table with the values `year`, `month`, `day`, `hour`, `minute`, and `second`.
---@param return_table? boolean
---@param ... number
---@return number
---@nodiscard
function datetime.add(return_table, ...)
  if return_table and type(return_table) ~= "boolean" then errorMsg("Boolean", "return_table", return_table) end

  if type(...) ~= "number" then errorMsg("Number", "...", ...) end
  local args = { ... }
  if #args < 2 then error("At least two numbers are required") end
  for i, num in ipairs(args) do
    if type(num) ~= "number" then errorMsg("Number", "num", num, i + 1) end
    if #tostring(num) ~= 14 then error("num must be a 14 digit number") end
  end

  local sum = 0
  for _, n in pairs(...) do sum = sum + tonumber(string.format("%014d", n)) end

  if return_table then
    return {
      year = tonumber(string.sub(sum, 1, 4)),
      month = tonumber(string.sub(sum, 5, 6)),
      day = tonumber(string.sub(sum, 7, 8)),
      hour = tonumber(string.sub(sum, 9, 10)),
      minute = tonumber(string.sub(sum, 11, 12)),
      second = tonumber(string.sub(sum, 13, 14))
    }
  end
  return tonumber(string.format("%014d", sum))
end

---***SRG Custom Function***
---
---Returns the time number `num` as a table with the values `year`, `month`, `day`, `hour`, `minute`, and `second`
---@param num number
---@return table
---@nodiscard
function datetime.to_table(num)
  if type(num) ~= "number" then errorMsg("Number", "num", num) end
  if #tostring(num) ~= 14 then error("num must be a 14 digit number") end

  return {
    year = tonumber(string.sub(num, 1, 4)),
    month = tonumber(string.sub(num, 5, 6)),
    day = tonumber(string.sub(num, 7, 8)),
    hour = tonumber(string.sub(num, 9, 10)),
    minute = tonumber(string.sub(num, 11, 12)),
    second = tonumber(string.sub(num, 13, 14))
  }
end

---***SRG Custom Function***
---
---Returns the time table `t` as a number in the format `Year Month Day Hour Minute Second`
---@param t table
---@return number
---@nodiscard
function datetime.to_number(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local values = { "year", "month", "day", "hour", "minute", "second" }
  for _, value in pairs(values) do
    if not t[value] then
      error(string.format("Missing value '%s'", value))
    elseif type(t[value]) ~= "number" then
      error(string.format("'%s' is not a number", value))
    end
  end

  return tonumber(string.format("%04d%02d%02d%02d%02d%02d", t.year, t.month, t.day, t.hour, t.minute, t.second))
end

-------------Remote Library-------------

---***SRG Custom Function***
---
---Registers a function under the given `name`. When `remote.call()` is called with this `name`, the registered function(s) will be executed.
---@param name string
---@param ... function
function remote.register(name, ...)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if remotes[name] then error(string.format("Remote '%s' already exists.", name)) end

  remotes[name] = {}

  for i, func in ipairs({ ... }) do
    if type(func) ~= "function" then errorMsg("Function", "func", func, i + 1) end
    table.insert(remotes[name], func)
  end
end

---***SRG Custom Function***
---
---Removes the function registered under the given `name`, making it unavailable for `remote.call()`.
---@param name string
function remote.unregister(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if not remotes[name] then error(string.format("Remote '%s' does not exist.", name)) end

  remotes[name] = nil
end

---***SRG Custom Function***
---
---Calls all functions registered under the given remotes. Multiple functions can be registered under the same name.
---@param ... string
function remote.call(...)
  if type(...) ~= "string" then errorMsg("String", "...", ...) end
  local args = { ... }
  for i, name in ipairs(args) do
    if not remotes[name] then error(string.format("Remote '%s' does not exist.", name)) end
    for _, func in ipairs(remotes[name]) do func() end
  end
end

---***SRG Custom Function***
---
---Checks if a remote function with the given `name` is registered.
---@param name string
---@return boolean
function remote.exists(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  return remotes[name] ~= nil
end

---***SRG Custom Function***
---
---Removes one or more remotes from the remote registry.
---@param ... string
function remote.remove(...)
  if type(...) ~= "string" then errorMsg("String", "...", ...) end
  local args = { ... }
  for i, name in ipairs(args) do
    if not remotes[name] then error(string.format("Remote '%s' does not exist.", name)) end
    remotes[name] = nil
  end
end

---***SRG Custom Function***
---
---Returns the count of functions registered under the given `name`.
---@param name string
---@return number
---@nodiscard
function remote.count(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if not remotes[name] then error(string.format("Remote '%s' does not exist.", name)) end

  return #remotes[name]
end

---***SRG Custom Function***
---
---Returns the list of all registered remote names.
---@return table
---@nodiscard
function remote.list()
  local names = {}
  for name, _ in pairs(remotes) do table.insert(names, name) end
  return names
end

---***SRG Custom Function***
---
---Removes every registered remote.
function remote.clear() remotes = {} end

---------Math Library Extension---------

---***SRG Custom Function***
---
---Calculates the average from a list of numbers
---@param ... number
---@return number
---@nodiscard
function math.average(...)
  if type(...) ~= "number" then errorMsg("Number", "...", ...) end
  local t = { ... }
  if #t < 2 then error("At least two numbers are required") end
  for i, num in ipairs(t) do
    if type(num) ~= "number" then errorMsg("Number", "num", num, i) end
  end

  local total = 0
  for i = 1, #t do total = total + t[i] end
  return total / #t
end

---***SRG Custom Function***
---
---Calculates the median from a list of numbers
---@param ... number
---@return number
---@nodiscard
function math.median(...)
  if type(...) ~= "number" then errorMsg("Number", "...", ...) end
  local t = { ... }
  if #t < 2 then error("At least two numbers are required") end
  for i, num in ipairs(t) do
    if type(num) ~= "number" then errorMsg("Number", "num", num, i) end
  end

  table.sort(t)
  local middle = math.floor(#t / 2) + 1
  if #t % 2 == 1 then
    return t[middle]
  else
    return (t[middle] + t[middle - 1]) / 2
  end
end

---***SRG Custom Function***
---
---Calculates the range from two or more numbers
---@param ... number
---@return number
---@nodiscard
function math.range(...)
  if type(...) ~= "number" then errorMsg("Number", "...", ...) end
  local t = { ... }
  if #t < 2 then error("At least two numbers are required") end
  for i, num in ipairs(t) do
    if type(num) ~= "number" then errorMsg("Number", "num", num, i) end
  end

  local minimum = math.min(table.unpack(t))
  local maximum = math.max(table.unpack(t))

  return maximum - minimum
end

---***SRG Custom Function***
---
---Calculates the mode from two or more numbers
---@param ... number
---@return number
---@nodiscard
function math.mode(...)
  if type(...) ~= "number" then errorMsg("Number", "...", ...) end
  local t = { ... }
  if #t < 2 then error("At least two numbers are required") end
  for i, num in ipairs(t) do
    if type(num) ~= "number" then errorMsg("Number", "num", num, i) end
  end

  local freq = {}
  for i = 1, #t do
    if freq[t[i]] then
      freq[t[i]] = freq[t[i]] + 1
    else
      freq[t[i]] = 1
    end
  end

  local toReturn
  local maxCount = 0
  for i, v in pairs(freq) do
    if v > maxCount then maxCount, toReturn = v, i end
  end

  return toReturn
end

---***SRG Custom Function***
---
---Calculates the standard deviation from two or more numbers
---@param ... number
---@return number
---@nodiscard
function math.standard_deviation(...)
  if type(...) ~= "number" then errorMsg("Number", "...", ...) end
  local t = { ... }
  if #t < 2 then error("At least two numbers are required") end
  for i, num in ipairs(t) do
    if type(num) ~= "number" then errorMsg("Number", "num", num, i) end
  end

  local deviation = 0
  local avg = math.average(t)
  for i = 1, #t do deviation = deviation + (t[i] - avg) ^ 2 end
  return math.sqrt(deviation / #t)
end

---***SRG Custom Function***
---
---Calculates the sum of two or more numbers
---@param ... number
---@return number
---@nodiscard
function math.sum(...)
  if type(...) ~= "number" then errorMsg("Number", "...", ...) end
  local t = { ... }
  if #t < 2 then error("At least two numbers are required") end
  for i, num in ipairs(t) do
    if type(num) ~= "number" then errorMsg("Number", "num", num, i) end
  end

  local sum = 0
  for _, v in pairs(t) do
    sum = sum + v
  end
  return sum
end

---***SRG Custom Function***
---
---Finds the greatest common divisor between two or more numbers
---@param ... number
---@return number
---@nodiscard
function math.gcd(...)
  if type(...) ~= "number" then errorMsg("Number", "...", ...) end
  local t = { ... }
  if #t < 2 then error("At least two numbers are required") end
  for i, num in ipairs(t) do
    if type(num) ~= "number" then errorMsg("Number", "num", num, i) end
  end

  local gcd = t[1]
  for i = 2, #t do
    local a, b = gcd, t[i]
    while b ~= 0 do a, b = b, a % b end
    gcd = a
  end
  return gcd
end

---***SRG Custom Function***
---
---Checks if `x` is a prime number
---@param x number
---@return boolean
---@nodiscard
function math.is_prime(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  if x < 2 then
    return false
  else
    local prime = true
    for i = 2, x - 1 do
      if x % i == 0 then
        prime = false
        break
      end
    end
    return prime
  end
end

---***SRG Custom Function***
---
---Finds the least common multiple between two or more numbers
---@param ... number
---@return number
---@nodiscard
function math.lcm(...)
  if type(...) ~= "number" then errorMsg("Number", "...", ...) end
  local t = { ... }
  if #t < 2 then error("At least two numbers are required") end
  for i, num in ipairs(t) do
    if type(num) ~= "number" then errorMsg("Number", "num", num, i) end
  end

  local lcm = t[1]
  for i = 2, #t do
    lcm = math.floor(lcm / math.gcd(lcm, t[i])) * t[i]
  end
  return lcm
end

---***SRG Custom Function***
---
---Solves a quadratic equation in the form ax² + bx + c using the quadratic formula
---@param a number
---@param b number
---@param c number
---@return number?
---@return number?
---@nodiscard
function math.quadratic(a, b, c)
  if type(a) ~= "number" then errorMsg("Number", "a", a) end
  if type(b) ~= "number" then errorMsg("Number", "b", b) end
  if type(c) ~= "number" then errorMsg("Number", "c", c) end

  local disc = b ^ 2 - 4 * a * c

  if disc < 0 then
    print("No real roots")
    return nil, nil
  end

  return (-b + math.sqrt(disc)) / (2 * a), (-b - math.sqrt(disc)) / (2 * a)
end

---***SRG Custom Function***
---
---Calculates the axis of symmetry for a quadratic function using `a` and `b` coefficients
---@param a number
---@param b number
---@return number
---@nodiscard
function math.aos(a, b)
  if type(a) ~= "number" then errorMsg("Number", "a", a) end
  if type(b) ~= "number" then errorMsg("Number", "b", b) end

  return -b / (2 * a)
end

---***SRG Custom Function***
---
---Calculates the vertex point of a quadratic function using `a`, `b`, and `c` coefficients
---@param a number
---@param b number
---@param c number
---@return number x
---@return number y
---@nodiscard
function math.vertex(a, b, c)
  if type(a) ~= "number" then errorMsg("Number", "a", a) end
  if type(b) ~= "number" then errorMsg("Number", "b", b) end
  if type(c) ~= "number" then errorMsg("Number", "c", c) end

  local aos = math.aos(a, b)

  return aos, a * aos ^ 2 + b * aos + c
end

---***SRG Custom Function***
---
---Calculates the hyperbolic sine of `x`
---@param x number
---@return number
---@nodiscard
math.sinh = function(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return (math.exp(x) - math.exp(-x)) / 2
end

---***SRG Custom Function***
---
---Calculates the hyperbolic cosine of `x`
---@param x number
---@return number
---@nodiscard
math.cosh = function(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return (math.exp(x) + math.exp(-x)) / 2
end

---***SRG Custom Function***
---
---Calculates the hyperbolic tangent of `x`
---@param x number
---@return number
---@nodiscard
math.tanh = function(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.sinh(x) / math.cosh(x)
end

---***SRG Custom Function***
---
---Calculates the inverse hyperbolic cosine of `x`
---@param x number
---@return number
---@nodiscard
function math.acosh(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.log(x + math.sqrt(x ^ 2 - 1))
end

---***SRG Custom Function***
---
---Calculates the inverse hyperbolic tangent of `x`
---@param x number
---@return number
---@nodiscard
function math.atanh(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.log((1 + x) / (1 - x)) / 2
end

---***SRG Custom Function***
---
---Calculates the inverse hyperbolic sine of `x`
---@param x number
---@return number
---@nodiscard
function math.asinh(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.log(x + math.sqrt(x ^ 2 + 1))
end

---***SRG Custom Function***
---
---Rounds `x` to `precision` decimal places (whole number if no precision given)
---@param x number
---@param precision? number
---@return number
function math.round(x, precision)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if precision and type(precision) ~= "number" then errorMsg("Number", "precision", precision) end

  local mult = 10 ^ (precision or 0)
  return math.floor(x * mult + 0.5) / mult
end

---***SRG Custom Function***
---
---Calculates the `n`th term of the Fibonacci Sequence
---@param n number
---@return number
function math.fib(n)
  if type(n) ~= "number" then errorMsg("Number", "n", n) end

  if n <= 0 then
    return 0
  elseif n == 1 then
    return 0
  elseif n == 2 then
    return 1
  else
    local a, b = 0, 1
    for i = 3, n do a, b = b, a + b end
    return b
  end
end

---***SRG Custom Function***
---
---Checks if `x` is a whole number
---@param x number
---@return boolean
---@nodiscard
function math.is_whole(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return x == math.floor(x)
end

---***SRG Custom Function***
---
---Checks if `x` is an odd number
---
---NOTE: Floats are neither odd nor even
---@param x number
---@return number
function math.is_odd(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return x % 2 == 1
end

---***SRG Custom Function***
---
---Checks if `x` is an even number
---
---NOTE: Floats are neither odd nor even
---@param x number
---@return number
function math.is_even(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return x % 2 == 0
end

---***SRG Custom Function***
---
---Checks if the square root of `x` is a whole number or not
---
---NOTE: Floats are neither odd nor even
---@param x number
---@return number
function math.is_perfect_square(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.sqrt(x) == math.floor(math.sqrt(x))
end

---***SRG Custom Function***
---
---Calculates the factorial of `x`
---@param x number
---@return number
function math.factorial(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if x == 0 then return 1 end
  if x < 0 then error("`x` cannot be a negative number, given: " .. tostring(x)) end

  local fact = x
  for i = x - 1, 1, -1 do fact = fact * i end

  return fact
end

---***SRG Custom Function***
---
---Calculates the number of ways to arrange r items from x items
---@param x number
---@param r number
---@return number
---@nodiscard
function math.permutation(x, r)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(r) ~= "number" then errorMsg("Number", "r", r) end
  if x < r then error("`r` cannot be greater than `x`") end

  return math.factorial(x) / math.factorial(x - r)
end

---***SRG Custom Function***
---
---Calculates the number of ways to choose r items from x items
---@param x number
---@param r number
---@return number
---@nodiscard
function math.combination(x, r)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(r) ~= "number" then errorMsg("Number", "r", r) end
  if x < r then error("`r` cannot be greater than `x`") end

  return math.factorial(x) / (math.factorial(r) * math.factorial(x - r))
end

---***SRG Custom Function***
---
---Returns all factors of a number
---@param x number
---@return table
---@nodiscard
function math.factors(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if x < 0 then error("`x` cannot be a negative number, given: " .. tostring(x)) end
  if math.floor(x) ~= x then error("`x` must be a whole number") end


  local factors = { 1, x }
  for i = 2, x - 1 do
    if x % i == 0 then table.insert(factors, i) end
  end

  return factors
end

---***SRG Custom Function***
---
---Checks if a number is perfect (sum of factors equals the number)
---@param x number
---@return boolean
---@nodiscard
function math.is_perfect(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.sum(math.factors(x)) - x == x
end

---***SRG Custom Function***
---
---Checks if a number is deficient (sum of factors less than number)
---@param x number
---@return boolean
---@nodiscard
function math.is_deficient(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.sum(math.factors(x)) - x < x
end

---***SRG Custom Function***
---
---Checks if a number is abundant (sum of factors greater than number)
---@param x number
---@return boolean
---@nodiscard
function math.is_abundant(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.sum(math.factors(x)) - x > x
end

---***SRG Custom Function***
---
---Classifies a number as Perfect, Deficient, or Abundant
---@param x number
---@return string
---@nodiscard
function math.classify_number(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  if math.is_perfect(x) then
    return "Perfect"
  elseif math.is_deficient(x) then
    return "Deficient"
  elseif math.is_abundant(x) then
    return "Abundant"
  else
    return "Unknown"
  end
end

---***SRG Custom Function***
---
---Calculates the z-score of `x` from two or more numbers
---- Z = 0 → Exactly average (equal to the mean)
---- Z > 0 → Above the mean
---- Z < 0 → Below the mean
---- Z > 2 or Z < -2 → Unusual (more than 2 standard deviations away)
---- Z > 3 or Z < -3 → Extremely rare (more than 3 standard deviations away)
---@param x number
---@param ... number
---@return number
---@nodiscard
function math.z_score(x, ...)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(...) ~= "number" then errorMsg("Number", "...", ...) end
  local t = { ... }
  if #t < 2 then error("At least two numbers are required") end
  for i, num in ipairs(t) do
    if type(num) ~= "number" then errorMsg("Number", "num", num, i + 1) end
  end

  local avg = math.average(t)
  local dev = math.standard_deviation(t)

  return (x - avg) / dev
end

---***SRG Custom Function***
---
---Calculates the secant of x (1/cos(x))
---@param x number
---@return number
---@nodiscard
function math.secant(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  x = math.cos(x)

  if x == 0 then error("Secant is undefined for this input") end
  return 1 / x
end

---***SRG Custom Function***
---
---Calculates the cosecant of x (1/sin(x))
---@param x number
---@return number
---@nodiscard
function math.cosecant(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  x = math.sin(x)

  if x == 0 then error("Cosecant is undefined for this input") end
  return 1 / x
end

---***SRG Custom Function***
---
---Calculates the cotangent of x (1/tan(x))
---@param x number
---@return number
---@nodiscard
function math.cotangent(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  x = math.tan(x)

  if x == 0 then error("Cotangent is undefined for this input") end
  return 1 / x
end

---***SRG Custom Function***
---
---Calculates the inverse secant of x (acos(1/x))
---@param x number
---@return number
---@nodiscard
function math.asecant(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.acos(1 / x)
end

---***SRG Custom Function***
---
---Calculates the inverse cosecant of x (asin(1/x))
---@param x number
---@return number
---@nodiscard
function math.acosecant(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.asin(1 / x)
end

---***SRG Custom Function***
---
---Calculates the inverse cotangent of x (atan(1/x))
---@param x number
---@return number
---@nodiscard
function math.acotangent(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return math.atan(1 / x)
end

---------String Library Extension---------

---***SRG Custom Function***
---
---Cleans a `s` to ensure it's a valid number format
---@param s string
---@return string
---@nodiscard
function string.clean_number(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local cleaned = s:gsub("[^0-9%.%-]", "")

  local firstDecimal = cleaned:find("%.")
  if firstDecimal then cleaned = cleaned:sub(1, firstDecimal) .. cleaned:sub(firstDecimal + 1):gsub("%.", "") end

  local hasHyphen = cleaned:find("%-")
  if hasHyphen then
    cleaned = cleaned:gsub("%-", "")
    if hasHyphen == 1 then cleaned = "-" .. cleaned end
  end

  return cleaned
end

---***SRG Custom Function***
---
---Removes whitespace from both ends of `s`
---@param s string
---@return string
---@nodiscard
function string.trim(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  return s:match("^%s*(.-)%s*$")
end

---***SRG Custom Function***
---
---Splits `s` into a table based on the patterns given
---@param s string
---@param ... string
---@return table
---@nodiscard
function string.split(s, ...)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if type(...) ~= "string" then errorMsg("String", "...", ...) end

  local toReturn = {}
  local start = 1

  for i = 1, #s do
    local isPattern = false
    for _, pattern in ipairs({ ... }) do
      if s:sub(i, i) == pattern then isPattern = true end
      break
    end
    if isPattern then
      table.insert(toReturn, s:sub(start, i - 1))
      start = i + 1
    end
  end

  table.insert(toReturn, s:sub(start))

  return toReturn
end

---***SRG Custom Function***
---
---Checks if `s` starts with any pattern given
---@param s string
---@param ... string
---@return boolean
---@nodiscard
function string.starts_with(s, ...)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if type(...) ~= "string" then errorMsg("String", "...", ...) end
  local args = { ... }

  local startsWith = false
  for i, name in ipairs(args) do
    if s:sub(1, #name) == name then startsWith = true end
  end
  return startsWith
end

---***SRG Custom Function***
---
---Checks if `s` ends with any pattern given
---@param s string
---@param ... string
---@return boolean
---@nodiscard
function string.ends_with(s, ...)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if type(...) ~= "string" then errorMsg("String", "...", ...) end
  local args = { ... }

  local startsWith = false
  for i, name in ipairs(args) do
    if s:sub(- #name) == name then startsWith = true end
  end
  return startsWith
end

---***SRG Custom Function***
---
---Adds `string_char` to `s`'s start if `include_start` is true and to its end if `include_end` is true, repeating it `length` times.
---@param s string
---@param str_char string
---@param length number
---@param include_start? boolean
---@param include_end? boolean
---@return string
---@nodiscard
function string.pad(s, str_char, length, include_start, include_end)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if type(str_char) ~= "string" then errorMsg("String", "strChar", str_char) end
  if type(length) ~= "number" then errorMsg("Number", "length", length) end
  if include_start and type(include_start) ~= "boolean" then errorMsg("Boolean", "include_start", include_start) end
  if include_end and type(include_end) ~= "boolean" then errorMsg("Boolean", "include_end", include_end) end

  if not include_start and not include_end then include_start, include_end = true, true end

  if include_start then s = str_char:rep(length) .. s end
  if include_end then s = s .. str_char:rep(length) end

  return s
end

---***SRG Custom Function***
---
---Capitalizes the first character of a string
---@param s string
---@return string
---@nodiscard
function string.capitalize(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if #s == 0 then return s end

  return s:sub(1, 1):upper() .. s:sub(2)
end

---***SRG Custom Function***
---
---Capitalizes the first letter of each word in `s`, seperating each word by the specified separator `sep` (default is space)
---@param s string
---@param sep? string
---@return string
---@nodiscard
function string.title_case(s, sep)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if sep then
    if type(sep) ~= "string" then errorMsg("String", "sep", sep) end
  else
    sep = " "
  end
  if #s == 0 then return s end

  local capitalized = ""
  local t = string.split(s, sep)

  for _, word in ipairs(t) do capitalized = capitalized .. string.capitalize(word) end
  return capitalized
end

---***SRG Custom Function***
---
---Returns the amount of occurrences each pattern given occurs in `s`
---@param s string
---@param ... string
---@return number
---@nodiscard
function string.count(s, ...)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if type(...) ~= "string" then errorMsg("String", "...", ...) end

  local amount = 0
  for _, pattern in ipairs({ ... }) do
    for _ in s:gmatch(pattern) do amount = amount + 1 end
  end
  return amount
end

---***SRG Custom Function***
---
---Checks if `s` is a palindrome (the reversed string is the same as the original string)
---@param s string
---@return boolean
---@nodiscard
function string.is_palindrome(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  return s:reverse() == s
end

---------Table Library Extension---------

---***SRG Custom Function***
---
---Recursively checks if any given table contains `value`
---
---Returns (`true`, `number of instances`) or (`false`, `0`)
---@param value any
---@param ... table
---@return boolean
---@return number instances
---@nodiscard
function table.contains(value, ...)
  if type(...) ~= "table" then errorMsg("Table", "...", ...) end
  local args = { ... }

  local amount = 0
  for _, t in pairs(args) do
    for _, v in pairs(t) do
      if v == value then
        amount = amount + 1
      elseif type(v) == "table" then
        local contains, instances = table.contains(value, v)
        if contains then amount = amount + instances end
      end
    end
  end
  return amount > 0, amount
end

---***SRG Custom Function***
---
---Converts a CSV string (`s`) into a table
---@param s string
---@return table
---@nodiscard
function table.csv_to_table(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  local toReturn = {}
  local currentRow = {}
  local field = ""
  local inQuotes = false
  local i = 1
  local row = 1

  while i <= #s do
    local char = s:sub(i, i)

    if char == '"' or char == "'" then
      if inQuotes and s:sub(i + 1, i + 1) == '"' then
        field = field .. '"'
        i = i + 2
      elseif inQuotes and s:sub(i + 1, i + 1) == "'" then
        field = field .. "'"
        i = i + 2
      else
        inQuotes = not inQuotes
        i = i + 1
      end
    elseif char == ',' and not inQuotes then
      table.insert(currentRow, field)
      field = ""
      i = i + 1
    elseif (char == '\n' or i == #s) and not inQuotes then
      if i == #s and char ~= '\n' then field = field .. char end
      table.insert(currentRow, field)
      toReturn[row] = currentRow
      currentRow = {}
      field = ""
      row = row + 1
      i = i + 1
    else
      field = field .. char
      i = i + 1
    end
  end

  return toReturn
end

---***SRG Custom Function***
---
---Converts a table (`t`) to a CSV string
---@param t table
---@return string
---@nodiscard
function table.to_csv(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local csv = ""
  for i = 1, #t do
    local row = t[i]
    if type(row) == "table" then
      for ii = 1, #row do
        local value = tostring(row[ii])
        if value:find('[,"\n]') then value = '"' .. value:gsub('"', '""') .. '"' end
        csv = csv .. value
        if ii < #row then csv = csv .. "," end
      end
      if i < #t then csv = csv .. "\n" end
      if i < #row then csv = csv .. "," end
    end
    if i < #t then csv = csv .. "\n" end
  end
  return csv
end

---***SRG Custom Function***
---
---Reverses the order of elements in `t`
---@param t table
---@return table
---@nodiscard
function table.reverse(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local reversed = {}
  for i = #t, 1, -1 do table.insert(reversed, i) end
  return reversed
end

---***SRG Custom Function***
---
---Shuffles the order of elements in `t` `n` times
---
---NOTE: If `n` is not given, `t` will only shuffle once
---@param t table
---@param n? number
---@return table
---@nodiscard
function table.shuffle(t, n)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end
  if n then
    if type(n) ~= "number" then errorMsg("Number", "n", n) end
  else
    n = 1
  end

  while n > 0 do
    t = shuffleTable(t)
    n = n - 1
  end

  return t
end

---***SRG Custom Function***
---
---Counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences
---@param t table
---@return number
---@return table Key_Table
---@nodiscard
function table.count_keys(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local keyTable = {}
  local amount = 0
  for key, _ in pairs(t) do
    keyTable[key] = keyTable[key] + 1 or 1
    amount = amount + 1
  end
  return amount, keyTable
end

---***SRG Custom Function***
---
---Recursively counts the amount of keys in `t` and returns a table containing each key and the amount of occurrences.
---
---The keys in nested tables are joined using `separator` (defaults to ".")
---@param t table
---@param separator? string
---@return number Total_Number_of_Keys
---@return table Key_Table_With_Key_Paths_and_Their_Counts
---@nodiscard
function table.deep_count_keys(t, separator)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end
  separator = separator or "."

  return countRecursive(t, separator)
end

---***SRG Custom Function***
---
---Returns a table containing the similarities between all tables given.
---
---NOTE: This function ONLY works on lists/arrays
---@param ... table
---@return table
function table.intersection(...)
  if type(...) ~= "table" then errorMsg("Table", "...", ...) end
  local args = { ... }
  if #args < 2 then error("At least two tables are required") end

  local intersectionTable = {}
  for _, v in pairs(args) do
    if table.contains(v, args) then table.insert(intersectionTable, v) end
  end
  return intersectionTable
end

---***SRG Custom Function***
---
---Returns a table containing the differences between all tables given.
---
---NOTE: This function ONLY works on lists/arrays
---@param ... table
---@return table
function table.difference(...)
  if type(...) ~= "table" then errorMsg("Table", "...", ...) end
  local args = { ... }
  if #args < 2 then error("At least two tables are required") end

  local differenceTable = {}
  for _, v in pairs(args) do
    if not table.contains(v, args) then table.insert(differenceTable, v) end
  end
  return differenceTable
end

---***SRG Custom Function***
---
---Shuffles the order of elements in `t` `n` times using the randomseed (`seed`)
---
---NOTE: If `n` is not given, `t` will only shuffle once
---@param t table
---@param seed number
---@param n? number
---@return table
---@nodiscard
function table.shuffle_randomseed(t, seed, n)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end
  if type(seed) ~= "number" then errorMsg("Number", "seed", seed) end

  math.randomseed(seed)
  local shuffled = table.shuffle(t, n)
  math.randomseed(os.time())
  return shuffled
end

---***SRG Custom Function***
---
---Returns a reversed key-pair table of `t` in which each `key = value` turns into `value = key`.
---@param t table
---@return table
---@nodiscard
function table.keypair_reverse(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local reverse = {}
  for k, v in pairs(t) do reverse[v] = k end

  return reverse
end

---***SRG Custom Function***
---
---Returns the last element in `t`
---@param t table
---@return any
---@nodiscard
function table.last(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end
  return table[#t]
end

---***SRG Custom Function***
---
---Returns the first element in `t`
---@param t table
---@return any
---@nodiscard
function table.first(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end
  return table[1]
end

---***SRG Custom Function***
---
---Returns a copy of the table `t`
---@param t table
---@return table
---@nodiscard
function table.copy(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local copy = {}
  for i, v in ipairs(t) do copy[i] = v end
  return copy
end

---***SRG Custom Function***
---
---Returns the index (position) of `value` in table `t`, or nil if not found.
---@param t table
---@param value any
---@return number|nil
---@nodiscard
function table.index(t, value)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local pos = nil

  for i = 1, #t do
    if t[i] == value then
      pos = i
      break
    end
  end

  return pos
end

---***SRG Custom Function***
---
---Concatenates multiple tables into 1
---@param ... table
---@return table
---@nodiscard
function table.combine(...)
  if type(...) ~= "table" then errorMsg("Table", "...", ...) end
  local args = { ... }
  if #args < 2 then error("At least two tables are required") end

  for i, t in ipairs(args) do
    if type(t) ~= "table" then errorMsg("Table", "t", t, i) end
  end

  local combined = {}

  for _, t in ipairs(args) do
    for _, v in ipairs(t) do table.insert(combined, v) end
  end
  return combined
end

---***SRG Custom Function***
---
---Locks the table `t` so it cannot be modified.
---@param t table
function table.lock(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local mt = getmetatable(t) or {}
  mt.__newindex = function() error("Attempted to modify a locked table.") end

  setmetatable(t, mt)
end

---***SRG Custom Function***
---
---Unlocks the table `t` so it can be modified.
---@param t table
function table.unlock(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  setmetatable(t, nil)
end

---***SRG Custom Function***
---
---Checks if the table `t` is locked.
---@param t table
---@return boolean
function table.is_locked(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  return getmetatable(t) and getmetatable(t).__newindex ~= nil
end

------------Global Library------------

---***SRG Custom Function***
---
---Yields the code for `x` seconds. (Similar to python's wait function).
---@param x? number
function wait(x)
  if x then
    if type(x) ~= "number" then errorMsg("Number", "x", x) end
  else
    x = 1
  end

  if system.is_windows then
    os.execute("timeout /t " .. x .. " /nobreak >nul")
  else
    os.execute("sleep " .. x)
  end
end

---***SRG Custom Function***
---
---Runs `func` `iterations` times
---
---NOTE: If `iterations` is not given, the code will run 10 times
---
---Returns:
---- `Total Execution Time`
---- `Average Execution Time Per Run`
---- `The Last Result (if return is added in the code)`
---@param func function
---@param iterations? number
---@return number Total_Timer
---@return number Average_Time_Per_Run
---@return string Last_Result
function benchmark(func, iterations)
  if type(func) ~= "function" then errorMsg("Function", "func", func) end
  if iterations then
    if type(iterations) ~= "number" then errorMsg("Number", "iterations", iterations) end
  else
    iterations = 10
  end

  local startTime = os.clock()
  local lastResult

  for i = 1, iterations do
    local success, result = pcall(func)
    if not success then error("Error in iteration " .. i .. ": " .. result) end
    lastResult = result
  end

  local totalTime = os.clock() - startTime
  return totalTime, totalTime / iterations, lastResult
end

---***SRG Custom Function***
---
---Runs `func` and returns the time it takes to run `func`
---@param func function
---@return number Time
---@return string Result
function execution_time(func)
  if type(func) ~= "function" then errorMsg("Function", "func", func) end

  local start = os.clock()
  local success, result = pcall(func)
  if not success then error("Error executing function: " .. result) end

  return os.clock() - start, result
end

---***SRG Custom Function***
---
---Yields `t` seconds before running `func` without stopping other code.
---@param t number
---@param func function
---@return any
function delay(t, func)
  if type(t) ~= "number" then errorMsg("Number", "t", t) end
  if type(func) ~= "function" then errorMsg("Function", "func", func) end

  return coroutine.wrap(function()
    wait(t)
    return func()
  end)()
end

---***SRG Custom Function***
---
---Yields `t` seconds before running `func` while stopping other code.
---@param t number
---@param func function
---@return any
function delay_stop(t, func)
  if type(t) ~= "number" then errorMsg("Number", "t", t) end
  if type(func) ~= "function" then errorMsg("Function", "func", func) end

  wait(t)
  return func()
end
