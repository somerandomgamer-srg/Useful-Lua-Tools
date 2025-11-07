---@diagnostic disable: unused-local
---@diagnostic disable: param-type-mismatch
---@diagnostic disable: return-type-mismatch
---@diagnostic disable: duplicate-set-field
---@diagnostic disable: lowercase-global

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

---Helper function for binary library
local function binToDec(bin)
  local dec = 0
  for i = 1, #bin do dec = dec * 2 + tonumber(bin:sub(i, i)) end
  return dec
end

---Helper function for binary library
local function decToBin(dec)
  if dec == 0 then return "0" end
  local bin = ""
  while dec > 0 do
    bin = tostring(dec % 2) .. bin
    dec = dec // 2
  end
  return bin
end

---Helper function to convert decimal to binary with fixed width
local function decToBinPadded(dec, width)
  local bin = decToBin(dec)
  return string.rep("0", width - #bin) .. bin
end

---Function for json.encode
local function jsonEncode(val)
  local valType = type(val)

  if valType == "string" then
    return '"' .. val:gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('\n', '\\n'):gsub('\r', '\\r'):gsub('\t', '\\t') .. '"'
  elseif valType == "number" then
    if val ~= val then
      return "null"
    elseif val == math.huge then
      return "null"
    elseif val == -math.huge then
      return "null"
    else
      return tostring(val)
    end
  elseif valType == "boolean" then
    return tostring(val)
  elseif valType == "nil" then
    return "null"
  elseif valType == "table" then
    local isTable = true
    local count = 0

    for k, _ in pairs(val) do
      count = count + 1
      if type(k) ~= "number" or k ~= count then
        isTable = false
        break
      end
    end

    if isTable and count > 0 then
      local result = {}
      for i = 1, count do result[i] = jsonEncode(val[i]) end
      return "[" .. table.concat(result, ",") .. "]"
    else
      local result = {}
      for k, v in pairs(val) do
        if type(k) == "string" then
          table.insert(result, '"' .. k .. '":' .. jsonEncode(v))
        elseif type(k) == "number" then
          table.insert(result, '"' .. tostring(k) .. '":' .. jsonEncode(v))
        end
      end
      return "{" .. table.concat(result, ",") .. "}"
    end
  else
    error("Cannot encode value of type: " .. valType)
  end
end

---Function for json.decode
local function jsonDecode(str)
  local pos = 1

  local function decodeValue()
    local function skipWhitespace()
      while pos <= #str and str:sub(pos, pos):match("%s") do pos = pos + 1 end
    end
    skipWhitespace()

    local char = str:sub(pos, pos)

    if char == '"' then
      pos = pos + 1
      local result = ""
      while pos <= #str do
        char = str:sub(pos, pos)
        if char == '"' then
          pos = pos + 1
          return result
        elseif char == "\\" then
          pos = pos + 1
          char = str:sub(pos, pos)
          if char == "n" then
            result = result .. "\n"
          elseif char == "r" then
            result = result .. "\r"
          elseif char == "t" then
            result = result .. "\t"
          elseif char == "\\" then
            result = result .. "\\"
          elseif char == '"' then
            result = result .. '"'
          else
            result = result .. char
          end
          pos = pos + 1
        else
          result = result .. char
          pos = pos + 1
        end
      end
      error("Unterminated string at position " .. pos)
    elseif char == "{" then
      pos = pos + 1
      local result = {}
      skipWhitespace()

      if str:sub(pos, pos) == "}" then
        pos = pos + 1
        return result
      end

      while true do
        skipWhitespace()
        local key = decodeValue() or ""
        skipWhitespace()

        if str:sub(pos, pos) ~= ":" then error("Expected ':' at position " .. pos) end
        pos = pos + 1

        local value = decodeValue()
        result[key] = value

        skipWhitespace()
        char = str:sub(pos, pos)

        if char == "}" then
          pos = pos + 1
          return result
        elseif char == "," then
          pos = pos + 1
        else
          error("Expected ',' or '}' at position " .. pos)
        end
      end
    elseif char == "[" then
      pos = pos + 1
      local result = {}
      skipWhitespace()

      if str:sub(pos, pos) == "]" then
        pos = pos + 1
        return result
      end

      while true do
        table.insert(result, decodeValue())
        skipWhitespace()
        char = str:sub(pos, pos)

        if char == "]" then
          pos = pos + 1
          return result
        elseif char == "," then
          pos = pos + 1
        else
          error("Expected ',' or ']' at position " .. pos)
        end
      end
    elseif char == "t" then
      if str:sub(pos, pos + 3) == "true" then
        pos = pos + 4
        return true
      else
        error("Invalid value at position " .. pos)
      end
    elseif char == "f" then
      if str:sub(pos, pos + 4) == "false" then
        pos = pos + 5
        return false
      else
        error("Invalid value at position " .. pos)
      end
    elseif char == "n" then
      if str:sub(pos, pos + 3) == "null" then
        pos = pos + 4
        return nil
      else
        error("Invalid value at position " .. pos)
      end
    elseif char == "-" or char:match("%d") then
      local numStr = ""
      while pos <= #str and str:sub(pos, pos):match("[%d%.eE+%-]") do
        numStr = numStr .. str:sub(pos, pos)
        pos = pos + 1
      end
      return tonumber(numStr)
    else
      error("Unexpected character '" .. char .. "' at position " .. pos)
    end
  end
  return decodeValue()
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
  local middle = (timestamp // 0x100000000) % 0x10000
  local high = (timestamp // 0x1000000000000) % 0x1000

  if v == 1 then
    high = high + 0x1000
  else
    high = high + 0x6000
  end

  local cHigh = (clockSeq // 256) % 64 + 128
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
  local time_mid = low // 0x10000
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

local function levenshteinMain(s1, s2, len1, len2)
  if len1 == 0 then return len2 end
  if len2 == 0 then return len1 end
  if s1:sub(len1, len1) == s2:sub(len2, len2) then return levenshteinMain(s1, s2, len1 - 1, len2 - 1) end

  return 1 + math.min(
    levenshteinMain(s1, s2, len1, len2 - 1),
    math.min(
      levenshteinMain(s1, s2, len1 - 1, len2),
      levenshteinMain(s1, s2, len1 - 1, len2 - 1)
    )
  )
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

local cache256 = {}

---@alias terminal_styles
---| "b" --Bold
---| "i" --Italic
---| "u" --Underline
---| "s" --Strikethrough
---| "tbk" --Text Black
---| "tr" --Text Red
---| "tg" --Text Green
---| "ty" --Text Yellow
---| "tbl" --Text Blue
---| "tm" --Text Magenta
---| "tc" --Text Cyan
---| "tw" --Text White
---| "bbk" --Background Black
---| "br" --Background Red
---| "bg" --Background Green
---| "by" --Background Yellow
---| "bbl" --Background Blue
---| "bm" --Background Magenta
---| "bc" --Background Cyan
---| "bw" --Background White
---| "o" --Overline

local terminalStyles = {
  ["b"] = 1,    --Bold
  ["i"] = 3,    --Italic
  ["u"] = 4,    --Underline
  ["s"] = 9,    --Strikethrough
  ["tbk"] = 30, --Text Black
  ["tr"] = 31,  --Text Red
  ["tg"] = 32,  --Text Green
  ["ty"] = 33,  --Text Yellow
  ["tbl"] = 34, --Text Blue
  ["tm"] = 35,  --Text Magenta
  ["tc"] = 36,  --Text Cyan
  ["tw"] = 37,  --Text White
  ["bbk"] = 40, --Background Black
  ["br"] = 41,  --Background Red
  ["bg"] = 42,  --Background Green
  ["by"] = 43,  --Background Yellow
  ["bbl"] = 44, --Background Blue
  ["bm"] = 45,  --Background Magenta
  ["bc"] = 46,  --Background Cyan
  ["bw"] = 47,  --Background White
  ["o"] = 53,   --Overline
}

local sha256Values = {}
local sha256Constants = {}

local function values256()
  for i, prime in ipairs({ 2, 3, 5, 7, 11, 13, 17, 19 }) do
    local rt = math.sqrt(prime)
    local constant = math.floor((rt - math.floor(rt)) * 2 ^ 32)
    sha256Values[i] = constant
  end
end

local function constants256()
  for i, prime in ipairs({ 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311 }) do
    local rt = prime ^ (1 / 3)
    local constant = math.floor((rt - math.floor(rt)) * 2 ^ 32)
    sha256Constants[i] = constant
  end
end

values256()
constants256()

local function toBase64Table(alphabet)
  local base64Chars = {}
  for i = 1, #alphabet do
    base64Chars[decToBinPadded(i - 1, 6)] = alphabet:sub(i, i)
  end
  return base64Chars
end

local function toBase58Table(alphabet)
  local base58Chars = {}
  for i = 1, #alphabet do base58Chars[i - 1] = alphabet:sub(i, i) end
  return base58Chars
end

local function toBase32Table(alphabet)
  local base32Chars = {}
  for i = 1, #alphabet do
    base32Chars[decToBinPadded(i - 1, 5)] = alphabet:sub(i, i)
  end
  return base32Chars
end

local remotes = {}
local stacks = {}
local queues = {}

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

---@class filelib
file = {}

---@class httplib
http = {}

---@class jsonlib
json = {}

---@class binarylib
binary = {}

---@class bignumlib
bignum = {}

---@class validatelib
validate = {}

---@class terminallib
terminal = {}

-----------ULT Main Library-----------

---***SRG Custom Variable***
---
---The version of Useful Lua Tools
---
---"Major Update"."Minor Update"."Patch/Very Minor Update"
---@nodiscard
ult.version = "2.2.0"

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
ult.min_lua_ver = "5.3"

if _VERSION:sub(5) < ult.min_lua_ver then
  error("Useful Lua Tools requires Lua " .. ult.min_lua_ver .. " or higher. You are running Lua " .. _VERSION:sub(5))
end

---***SRG Custom Variable***
---
---The release date of the current ULT version
---@nodiscard
ult.release_date = "10/23/2025"

---***SRG Custom Variable***
---
---The current build of Useful Lua Tools
---
---"Project"-"version"-"date of release"-"minimum lua version"
---@nodiscard
ult.build = ("ult-%s-%s-%s"):format(ult.version, ult.release_date, ult.min_lua_ver)

-----------Validate Library-----------

---***SRG Custom Function***
---
---Validates whether or not `ip` is a valid ip address.
---
---If `v6` is true, validates for IPv6, otherwise validates for IPv4.
---@param ip string
---@param v6? boolean
---@return boolean
---@nodiscard
function validate.ip(ip, v6)
  if type(ip) ~= "string" then errorMsg("String", "ip", ip) end
  if v6 and type(v6) ~= "boolean" then errorMsg("Boolean", "v6", v6) end

  if v6 then
    return ip:match("^%x%x%x%x:%x%x%x%x:%x%x%x%x:%x%x%x%x:%x%x%x%x:%x%x%x%x:%x%x%x%x:%x%x%x%x$") ~= nil
  else
    local t = string.split(ip, ".")
    if #t ~= 4 then return false end
    for _, v in ipairs(t) do
      local num = tonumber(v)
      if not num or num < 0 or num > 255 then return false end
    end
    return true
  end
end

---***SRG Custom Function***
---
---Validates whether or not `email` is a valid email address.
---@param email string
---@return boolean
---@nodiscard
function validate.email(email)
  if type(email) ~= "string" then errorMsg("String", "email", email) end

  return email:match("^[%w%.%-]+@[%w%.%-]+%.[%w%.%-]+$") ~= nil
end

---***SRG Custom Function***
---
---Validates whether or not `url` is a valid URL.
---@param url string
---@return boolean
---@nodiscard
function validate.url(url)
  if type(url) ~= "string" then errorMsg("String", "url", url) end

  return url:match("^https?://[%w%-%.]+%.%w+[%w%.%-_/#?&=]*$") ~= nil or
      url:match("^[%w%-%.]+%.%w+[%w%.%-_/#?&=]*$") ~= nil
end

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
---Returns the Mac Address of the host system, or nil if it cannot be determined
system.mac_address = getMac()

------------Binary Library------------

---***SRG Custom Function***
---
---Adds two or more binary numbers together.
---@param ... string
---@return string
---@nodiscard
function binary.add(...)
  local args = { ... }
  if #args < 2 then error("At least two binary numbers are required") end

  for i, num in ipairs(args) do
    if type(num) ~= "string" then errorMsg("String", "num", num, i) end
    if not num:match("^[01]+$") then error(string.format("Invalid binary number at argument %d: %s", i, num)) end
  end

  local result = ""
  local carry = 0
  local length = math.max(table.unpack(table.map(args, function(x) return #x end)))

  for i = 1, #args do
    while #args[i] < length do args[i] = "0" .. args[i] end
  end

  for i = length, 1, -1 do
    local sum = carry
    for _, num in ipairs(args) do sum = sum + tonumber(num:sub(i, i)) end

    result = tostring(sum % 2) .. result
    carry = sum // 2
  end

  while carry > 0 do
    result = tostring(carry % 2) .. result
    carry = carry // 2
  end

  return result
end

---***SRG Custom Function***
---
---Subtracts two or more binary numbers (first - second - third - ...).
---Returns negative results with "-" prefix.
---@param ... string
---@return string
---@nodiscard
function binary.subtract(...)
  local args = { ... }
  if #args < 2 then error("At least two binary numbers are required") end

  for i, num in ipairs(args) do
    if type(num) ~= "string" then errorMsg("String", "num", num, i) end
    if not num:match("^[01]+$") then error(string.format("Invalid binary number at argument %d: %s", i, num)) end
  end

  local result = binToDec(args[1])
  for i = 2, #args do result = result - binToDec(args[i]) end

  if result < 0 then
    return "-" .. decToBin(-result)
  elseif result == 0 then
    return "0"
  else
    return decToBin(result)
  end
end

---***SRG Custom Function***
---
---Multiplies two or more binary numbers together.
---@param ... string
---@return string
---@nodiscard
function binary.multiply(...)
  local args = { ... }
  if #args < 2 then error("At least two binary numbers are required") end

  for i, num in ipairs(args) do
    if type(num) ~= "string" then errorMsg("String", "num", num, i) end
    if not num:match("^[01]+$") then error(string.format("Invalid binary number at argument %d: %s", i, num)) end
  end

  local result = binToDec(args[1])
  for i = 2, #args do result = result * binToDec(args[i]) end

  return decToBin(result)
end

---***SRG Custom Function***
---
---Divides two or more binary numbers (first / second / third / ...).
---@param ... string
---@return string
---@nodiscard
function binary.divide(...)
  local args = { ... }
  if #args < 2 then error("At least two binary numbers are required") end

  for i, num in ipairs(args) do
    if type(num) ~= "string" then errorMsg("String", "num", num, i) end
    if not num:match("^[01]+$") then error(string.format("Invalid binary number at argument %d: %s", i, num)) end
  end

  local result = binToDec(args[1])
  for i = 2, #args do
    local d = binToDec(args[i])
    if d == 0 then error("Division by zero") end
    result = result / d
  end
  result = math.floor(result)

  return decToBin(result)
end

---***SRG Custom Function***
---
---Performs bitwise AND operation on two or more binary numbers.
---@param ... string
---@return string
---@nodiscard
function binary.band(...)
  local args = { ... }
  if #args < 2 then error("At least two binary numbers are required") end

  for i, num in ipairs(args) do
    if type(num) ~= "string" then errorMsg("String", "num", num, i) end
    if not num:match("^[01]+$") then error(string.format("Invalid binary number at argument %d: %s", i, num)) end
  end

  local length = math.max(table.unpack(table.map(args, function(x) return #x end)))

  for i = 1, #args do
    while #args[i] < length do args[i] = "0" .. args[i] end
  end

  local result = args[1]
  for i = 2, #args do
    for j = 1, #result do
      if result:sub(j, j) == "1" and args[i]:sub(j, j) == "1" then
        result = result:sub(1, j - 1) .. "1" .. result:sub(j + 1)
      else
        result = result:sub(1, j - 1) .. "0" .. result:sub(j + 1)
      end
    end
  end

  return result
end

---***SRG Custom Function***
---
---Performs bitwise OR operation on two or more binary numbers.
---@param ... string
---@return string
---@nodiscard
function binary.bor(...)
  local args = { ... }
  if #args < 2 then error("At least two binary numbers are required") end

  for i, num in ipairs(args) do
    if type(num) ~= "string" then errorMsg("String", "num", num, i) end
    if not num:match("^[01]+$") then error(string.format("Invalid binary number at argument %d: %s", i, num)) end
  end

  local length = math.max(table.unpack(table.map(args, function(x) return #x end)))

  for i = 1, #args do
    while #args[i] < length do args[i] = "0" .. args[i] end
  end

  local result = args[1]
  for i = 2, #args do
    for j = 1, #result do
      if result:sub(j, j) == "1" or args[i]:sub(j, j) == "1" then
        result = result:sub(1, j - 1) .. "1" .. result:sub(j + 1)
      else
        result = result:sub(1, j - 1) .. "0" .. result:sub(j + 1)
      end
    end
  end

  return result
end

---***SRG Custom Function***
---
---Performs bitwise XOR operation on two or more binary numbers.
---@param ... string
---@return string
---@nodiscard
function binary.bxor(...)
  local args = { ... }
  if #args < 2 then error("At least two binary numbers are required") end

  for i, num in ipairs(args) do
    if type(num) ~= "string" then errorMsg("String", "num", num, i) end
    if not num:match("^[01]+$") then error(string.format("Invalid binary number at argument %d: %s", i, num)) end
  end

  local length = math.max(table.unpack(table.map(args, function(x) return #x end)))

  for i = 1, #args do
    while #args[i] < length do args[i] = "0" .. args[i] end
  end

  local result = args[1]
  for i = 2, #args do
    for j = 1, #result do
      if result:sub(j, j) == args[i]:sub(j, j) then
        result = result:sub(1, j - 1) .. "0" .. result:sub(j + 1)
      else
        result = result:sub(1, j - 1) .. "1" .. result:sub(j + 1)
      end
    end
  end

  return result
end

---***SRG Custom Function***
---
---Performs bitwise NOT operation on a binary number.
---@param bin string
---@return string
---@nodiscard
function binary.bnot(bin)
  if type(bin) ~= "string" then errorMsg("String", "bin", bin) end
  if not bin:match("^[01]+$") then error("Invalid binary number: " .. bin) end

  local result = ""
  for i = 1, #bin do
    if bin:sub(i, i) == "1" then
      result = result .. "0"
    else
      result = result .. "1"
    end
  end

  return result
end

------------BigNum Library------------

---***SRG Custom Function***
---
---Creates a new big number from a string or number.
---@param value string|number
---@return table
---@nodiscard
function bignum.new(value)
  if type(value) ~= "string" and type(value) ~= "number" then errorMsg("String or Number", "value", value) end

  local str = tostring(value)
  local negative = false
  local decimal = ""

  if str:sub(1, 1) == "-" then
    negative = true
    str = str:sub(2)
  end

  if str:find("%.") then
    local parts = {}
    for part in str:gmatch("[^.]+") do table.insert(parts, part) end

    if #parts ~= 2 then error("Invalid big number format: " .. tostring(value)) end
    str = parts[1]
    decimal = parts[2]
  end

  if not str:match("^%d+$") then error("Invalid big number format: " .. tostring(value)) end

  if decimal ~= "" and not decimal:match("^%d+$") then error("Invalid big number format: " .. tostring(value)) end

  str = str:gsub("^0+", "")
  if str == "" then str = "0" end

  decimal = decimal:gsub("0+$", "")

  return { digits = str, decimal = decimal, negative = negative }
end

---***SRG Custom Function***
---
---Converts a big number to a string.
---@param num table
---@return string
---@nodiscard
function bignum.to_string(num)
  if type(num) ~= "table" or type(num.digits) ~= "string" then errorMsg("BigNum", "num", num) end

  local result = num.digits
  if num.decimal and num.decimal ~= "" then result = result .. "." .. num.decimal end

  if result == "0" or result == "0." then return "0" end
  return (num.negative and "-" or "") .. result
end

---***SRG Custom Function***
---
---Compares two big numbers. Returns -1 if a < b, 0 if a == b, 1 if a > b.
---@param a table
---@param b table
---@return number
---@nodiscard
function bignum.compare(a, b)
  if type(a) ~= "table" or type(a.digits) ~= "string" then errorMsg("BigNum", "a", a) end
  if type(b) ~= "table" or type(b.digits) ~= "string" then errorMsg("BigNum", "b", b) end

  if a.negative and not b.negative then return -1 end
  if not a.negative and b.negative then return 1 end

  local mult = a.negative and -1 or 1

  if #a.digits < #b.digits then return -mult end
  if #a.digits > #b.digits then return mult end

  if a.digits < b.digits then return -mult end
  if a.digits > b.digits then return mult end

  return 0
end

---***SRG Custom Function***
---
---a + b
---@param a table
---@param b table
---@return table
---@nodiscard
function bignum.add(a, b)
  if type(a) ~= "table" or type(a.digits) ~= "string" then errorMsg("BigNum", "a", a) end
  if type(b) ~= "table" or type(b.digits) ~= "string" then errorMsg("BigNum", "b", b) end

  if a.negative and not b.negative then
    local temp = { digits = a.digits, negative = false }
    return bignum.subtract(b, temp)
  end

  if not a.negative and b.negative then
    local temp = { digits = b.digits, negative = false }
    return bignum.subtract(a, temp)
  end

  local d1, d2 = a.digits, b.digits
  local len = math.max(#d1, #d2)
  local result = ""
  local carry = 0

  for i = 1, len do
    local digit1 = tonumber(d1:sub(-i, -i)) or 0
    local digit2 = tonumber(d2:sub(-i, -i)) or 0
    local sum = digit1 + digit2 + carry
    result = tostring(sum % 10) .. result
    carry = sum // 10
  end

  if carry > 0 then result = tostring(carry) .. result end

  return { digits = result, negative = a.negative }
end

---***SRG Custom Function***
---
---a - b
---@param a table
---@param b table
---@return table
---@nodiscard
function bignum.subtract(a, b)
  if type(a) ~= "table" or type(a.digits) ~= "string" then errorMsg("BigNum", "a", a) end
  if type(b) ~= "table" or type(b.digits) ~= "string" then errorMsg("BigNum", "b", b) end

  if a.negative and not b.negative then
    local temp = { digits = a.digits, negative = false }
    local result = bignum.add(temp, b)
    result.negative = true
    return result
  end

  if not a.negative and b.negative then
    local temp = { digits = b.digits, negative = false }
    return bignum.add(a, temp)
  end

  local swap = false
  local d1, d2 = a.digits, b.digits

  if #d1 < #d2 or (#d1 == #d2 and d1 < d2) then
    d1, d2 = d2, d1
    swap = true
  end

  local result = ""
  local borrow = 0

  for i = 1, #d1 do
    local digit1 = tonumber(d1:sub(-i, -i)) or 0
    local digit2 = tonumber(d2:sub(-i, -i)) or 0
    local diff = digit1 - digit2 - borrow

    if diff < 0 then
      diff = diff + 10
      borrow = 1
    else
      borrow = 0
    end

    result = tostring(diff) .. result
  end

  result = result:gsub("^0+", "")
  if result == "" then result = "0" end

  local negative = a.negative
  if swap then negative = not negative end

  if result == "0" then negative = false end

  return { digits = result, negative = negative }
end

---***SRG Custom Function***
---
---a * b
---@param a table
---@param b table
---@return table
---@nodiscard
function bignum.multiply(a, b, precision)
  if type(a) ~= "table" or type(a.digits) ~= "string" then errorMsg("BigNum", "a", a) end
  if type(b) ~= "table" or type(b.digits) ~= "string" then errorMsg("BigNum", "b", b) end
  if precision and type(precision) ~= "number" then errorMsg("Number", "precision", precision) end

  precision = precision or 10

  local aHasDec = (a.decimal and a.decimal ~= "")
  local bHasDec = (b.decimal and b.decimal ~= "")

  if aHasDec or bHasDec then
    local aDecLen = (a.decimal and #a.decimal) or 0
    local bDecLen = (b.decimal and #b.decimal) or 0
    local totalDecLen = aDecLen + bDecLen

    local aFull = a.digits .. (a.decimal or "")
    local bFull = b.digits .. (b.decimal or "")

    local aNum = bignum.new(aFull)
    local bNum = bignum.new(bFull)

    local result = bignum.multiply(aNum, bNum)

    local resultStr = result.digits
    if #resultStr <= totalDecLen then resultStr = string.rep("0", totalDecLen - #resultStr + 1) .. resultStr end

    local intPart = resultStr:sub(1, #resultStr - totalDecLen)
    local decPart = resultStr:sub(#resultStr - totalDecLen + 1)

    if intPart == "" then intPart = "0" end

    if #decPart > precision then decPart = decPart:sub(1, precision) end

    decPart = decPart:gsub("0+$", "")

    local negative = (a.negative ~= b.negative)
    if intPart == "0" and decPart == "" then negative = false end

    return { digits = intPart, decimal = decPart, negative = negative }
  end

  if a.digits == "0" or b.digits == "0" then return { digits = "0", decimal = "", negative = false } end

  local d1, d2 = a.digits, b.digits
  local result = {}

  for i = 1, #d1 + #d2 do result[i] = 0 end

  for i = #d1, 1, -1 do
    for j = #d2, 1, -1 do
      local digit1 = tonumber(d1:sub(i, i))
      local digit2 = tonumber(d2:sub(j, j))
      local pos = #d1 - i + #d2 - j + 1

      result[pos] = result[pos] + digit1 * digit2

      if result[pos] >= 10 then
        result[pos + 1] = result[pos + 1] + result[pos] // 10
        result[pos] = result[pos] % 10
      end
    end
  end

  local resultStr = ""
  for i = #result, 1, -1 do resultStr = resultStr .. tostring(result[i]) end

  resultStr = resultStr:gsub("^0+", "")
  if resultStr == "" then resultStr = "0" end

  local negative = (a.negative ~= b.negative)
  if resultStr == "0" then negative = false end

  return { digits = resultStr, decimal = "", negative = negative }
end

---***SRG Custom Function***
---
---Divides a by b (a / b). Supports decimals.
---@param a table
---@param b table
---@param precision? number
---@return table
---@nodiscard
function bignum.divide(a, b, precision)
  if type(a) ~= "table" or type(a.digits) ~= "string" then errorMsg("BigNum", "a", a) end
  if type(b) ~= "table" or type(b.digits) ~= "string" then errorMsg("BigNum", "b", b) end
  if precision and type(precision) ~= "number" then errorMsg("Number", "precision", precision) end

  local forceDecimal = (precision ~= nil)
  precision = precision or 10

  local aHasDec = (a.decimal and a.decimal ~= "")
  local bHasDec = (b.decimal and b.decimal ~= "")

  if aHasDec or bHasDec or forceDecimal then
    if b.digits == "0" and (not b.decimal or b.decimal == "") then error("Division by zero") end

    local aStr = a.digits .. (a.decimal or "")
    local bStr = b.digits .. (b.decimal or "")

    local aDecLen = (a.decimal and #a.decimal) or 0
    local bDecLen = (b.decimal and #b.decimal) or 0

    local extraZeros = precision + bDecLen - aDecLen
    if extraZeros > 0 then aStr = aStr .. string.rep("0", extraZeros) end

    local aBig = bignum.new(aStr)
    local bBig = bignum.new(bStr)

    local quotient = bignum.divide(aBig, bBig)

    local resultStr = quotient.digits
    if #resultStr <= precision then resultStr = string.rep("0", precision - #resultStr + 1) .. resultStr end

    local intPart = resultStr:sub(1, #resultStr - precision)
    local decPart = resultStr:sub(#resultStr - precision + 1)

    if intPart == "" then intPart = "0" end

    decPart = decPart:gsub("0+$", "")

    local negative = (a.negative ~= b.negative)
    if intPart == "0" and decPart == "" then negative = false end

    return { digits = intPart, decimal = decPart, negative = negative }
  end

  if b.digits == "0" then error("Division by zero") end

  if a.digits == "0" then return { digits = "0", decimal = "", negative = false } end

  local absA = { digits = a.digits, decimal = "", negative = false }
  local absB = { digits = b.digits, decimal = "", negative = false }

  if bignum.compare(absA, absB) < 0 then return { digits = "0", decimal = "", negative = false } end

  local quotient = ""
  local current = bignum.new("0")

  for i = 1, #a.digits do
    current = bignum.new(current.digits .. a.digits:sub(i, i))

    local count = 0
    while bignum.compare(current, absB) >= 0 do
      current = bignum.subtract(current, absB)
      count = count + 1
    end

    quotient = quotient .. tostring(count)
  end

  quotient = quotient:gsub("^0+", "")
  if quotient == "" then quotient = "0" end

  local negative = (a.negative ~= b.negative)
  if quotient == "0" then negative = false end

  return { digits = quotient, decimal = "", negative = negative }
end

---***SRG Custom Function***
---
---a % b
---@param a table
---@param b table
---@return table
---@nodiscard
function bignum.mod(a, b)
  if type(a) ~= "table" or type(a.digits) ~= "string" then errorMsg("BigNum", "a", a) end
  if type(b) ~= "table" or type(b.digits) ~= "string" then errorMsg("BigNum", "b", b) end

  local quotient = bignum.divide(a, b)
  local product = bignum.multiply(quotient, b)
  return bignum.subtract(a, product)
end

---***SRG Custom Function***
---
---a ^ b
---@param a table
---@param b number
---@param precision? number
---@return table
---@nodiscard
function bignum.pow(a, b, precision)
  if type(a) ~= "table" or type(a.digits) ~= "string" then errorMsg("BigNum", "a", a) end
  if type(b) ~= "number" then errorMsg("Number", "b", b) end
  if precision and type(precision) ~= "number" then errorMsg("Number", "precision", precision) end

  precision = precision or 10

  if b == 0 then return { digits = "1", decimal = "", negative = false } end

  if b < 0 then
    local posResult = bignum.pow(a, -b, precision)
    local one = bignum.new("1")
    return bignum.divide(one, posResult, precision)
  end

  if math.is_whole(b) then
    local result = bignum.new("1")
    local hasDecimal = (a.decimal and a.decimal ~= "")

    if hasDecimal then
      for i = 1, b do result = bignum.multiply(result, a, precision) end
    else
      for i = 1, b do result = bignum.multiply(result, a) end
    end
    return result
  else
    local intPart = math.floor(b)
    local fracPart = b - intPart

    local intResult = bignum.pow(a, intPart, precision)

    if fracPart == 0 then return intResult end

    local base = tonumber(bignum.to_string(a))
    if not base then error("Number too large for fractional exponent. Please use whole number base for large numbers") end

    local fracResult = base ^ fracPart
    local fracResultStr = string.format("%." .. precision .. "f", fracResult)
    local fracBigNum = bignum.new(fracResultStr)

    return bignum.multiply(intResult, fracBigNum, precision)
  end
end

---***SRG Custom Function***
---
---math.abs(a)
---@param a table
---@return table
---@nodiscard
function bignum.abs(a)
  if type(a) ~= "table" or type(a.digits) ~= "string" then errorMsg("BigNum", "a", a) end

  return { digits = a.digits, decimal = a.decimal or "", negative = false }
end

---***SRG Custom Function***
---
---a == b
---@param a table
---@param b table
---@return boolean
---@nodiscard
function bignum.equals(a, b) return bignum.compare(a, b) == 0 end

---***SRG Custom Function***
---
---a < b
---@param a table
---@param b table
---@return boolean
---@nodiscard
function bignum.less_than(a, b) return bignum.compare(a, b) < 0 end

---***SRG Custom Function***
---
---a > b
---@param a table
---@param b table
---@return boolean
---@nodiscard
function bignum.greater_than(a, b) return bignum.compare(a, b) > 0 end

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

  local n1, n3, n5 = process(r // 16, g // 16, b // 16)

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
  for i = 1, #s do ascii = ascii .. s:sub(i, i):byte() .. " " end
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
  for i = 1, #s do hex = hex .. ("%02X"):format(s:sub(i, i):byte()) .. " " end
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

  local bin = ""
  for i = 1, #s do bin = bin .. decToBinPadded(s:byte(i), x) end
  return string.trim(bin)
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
  for i = 1, #s do octal = octal .. ("%o"):format(s:sub(i, i):byte()) .. " " end
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

  local morseReverse = table.keypair_reverse(morseCodeTable)

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
---@param alphabet? string
---@return string
---@nodiscard
function cryptography.text_to_base64(s, alphabet)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if alphabet then
    if type(alphabet) ~= "string" then errorMsg("String", "alphabet", alphabet) end
    if #alphabet ~= 64 then error("Alphabet must be exactly 64 characters long.") end
    local seen = {}
    for i = 1, #alphabet do
      local char = alphabet:sub(i, i)
      if seen[char] then error("Alphabet contains duplicate character: " .. char) end
      seen[char] = true
    end
  else
    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  end

  local encoded = ""
  local i = 1

  while i <= #s do
    local b1 = s:byte(i)
    local b2 = i + 1 <= #s and s:byte(i + 1) or 0
    local b3 = i + 2 <= #s and s:byte(i + 2) or 0

    local n = (b1 << 16) | (b2 << 8) | b3

    encoded = encoded .. alphabet:sub(((n >> 18) & 0x3F) + 1, ((n >> 18) & 0x3F) + 1)
    encoded = encoded .. alphabet:sub(((n >> 12) & 0x3F) + 1, ((n >> 12) & 0x3F) + 1)
    encoded = encoded .. (i + 1 <= #s and alphabet:sub(((n >> 6) & 0x3F) + 1, ((n >> 6) & 0x3F) + 1) or "=")
    encoded = encoded .. (i + 2 <= #s and alphabet:sub((n & 0x3F) + 1, (n & 0x3F) + 1) or "=")

    i = i + 3
  end

  return encoded
end

---***SRG Custom Function***
---
---Converts base64 to plaintext.
---@param s string
---@param alphabet? string
---@return string
---@nodiscard
function cryptography.base64_to_text(s, alphabet)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if alphabet then
    if type(alphabet) ~= "string" then errorMsg("String", "alphabet", alphabet) end
    if #alphabet ~= 64 then error("Alphabet must be exactly 64 characters long.") end
    local seen = {}
    for i = 1, #alphabet do
      local char = alphabet:sub(i, i)
      if seen[char] then error("Alphabet contains duplicate character: " .. char) end
      seen[char] = true
    end
  else
    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  end

  local lookup = {}
  for i = 1, #alphabet do
    lookup[alphabet:sub(i, i)] = i - 1
  end

  local paddingCount = 0
  for i = #s, 1, -1 do
    if s:sub(i, i) == "=" then
      paddingCount = paddingCount + 1
    else
      break
    end
  end

  if paddingCount > 2 then
    error("Invalid base64 padding: too many padding characters")
  end

  for i = 1, #s - paddingCount do
    if s:sub(i, i) == "=" then
      error("Invalid base64 padding: padding character in non-terminal position")
    end
  end

  local payloadLength = #s - paddingCount
  if paddingCount == 1 and (payloadLength % 4 ~= 3 or payloadLength == 0) then
    error("Invalid base64 padding: 1 padding character requires 3 payload characters mod 4")
  elseif paddingCount == 2 and (payloadLength % 4 ~= 2 or payloadLength == 0) then
    error("Invalid base64 padding: 2 padding characters require 2 payload characters mod 4")
  end

  s = s:gsub("=", "")

  if #s % 4 == 1 then
    error("Invalid base64 length: incomplete group")
  end

  local decoded = {}
  local i = 1

  while i <= #s do
    local ch1 = s:sub(i, i)
    local ch2 = i + 1 <= #s and s:sub(i + 1, i + 1) or nil
    local ch3 = i + 2 <= #s and s:sub(i + 2, i + 2) or nil
    local ch4 = i + 3 <= #s and s:sub(i + 3, i + 3) or nil

    local c1 = lookup[ch1]
    if not c1 then error("Invalid base64 character: " .. ch1) end
    local c2 = ch2 and lookup[ch2] or 0
    if ch2 and not lookup[ch2] then error("Invalid base64 character: " .. ch2) end
    local c3 = ch3 and lookup[ch3] or 0
    if ch3 and not lookup[ch3] then error("Invalid base64 character: " .. ch3) end
    local c4 = ch4 and lookup[ch4] or 0
    if ch4 and not lookup[ch4] then error("Invalid base64 character: " .. ch4) end

    local n = (c1 << 18) | (c2 << 12) | (c3 << 6) | c4

    table.insert(decoded, string.char((n >> 16) & 0xFF))
    if i + 2 <= #s then
      table.insert(decoded, string.char((n >> 8) & 0xFF))
    end
    if i + 3 <= #s then
      table.insert(decoded, string.char(n & 0xFF))
    end

    i = i + 4
  end

  return table.concat(decoded)
end

---***SRG Custom Function***
---
---Converts plaintext to base32.
---@param s string
---@param alphabet? string
---@return string
---@nodiscard
function cryptography.text_to_base32(s, alphabet)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if alphabet then
    if type(alphabet) ~= "string" then errorMsg("String", "alphabet", alphabet) end
    if #alphabet ~= 32 then error("Alphabet must be exactly 32 characters long.") end
    local seen = {}
    for i = 1, #alphabet do
      local char = alphabet:sub(i, i)
      if seen[char] then error("Alphabet contains duplicate character: " .. char) end
      seen[char] = true
    end
  else
    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
  end

  local encoded = ""
  local i = 1

  while i <= #s do
    local b1 = s:byte(i)
    local b2 = i + 1 <= #s and s:byte(i + 1) or 0
    local b3 = i + 2 <= #s and s:byte(i + 2) or 0
    local b4 = i + 3 <= #s and s:byte(i + 3) or 0
    local b5 = i + 4 <= #s and s:byte(i + 4) or 0

    local chunkBytes = math.min(5, #s - i + 1)

    encoded = encoded .. alphabet:sub((b1 >> 3) + 1, (b1 >> 3) + 1)
    encoded = encoded .. alphabet:sub((((b1 & 0x07) << 2) | (b2 >> 6)) + 1, (((b1 & 0x07) << 2) | (b2 >> 6)) + 1)

    if chunkBytes > 1 then
      encoded = encoded .. alphabet:sub(((b2 >> 1) & 0x1F) + 1, ((b2 >> 1) & 0x1F) + 1)
      encoded = encoded .. alphabet:sub((((b2 & 0x01) << 4) | (b3 >> 4)) + 1, (((b2 & 0x01) << 4) | (b3 >> 4)) + 1)
    else
      encoded = encoded .. ("======")
      break
    end

    if chunkBytes > 2 then
      encoded = encoded .. alphabet:sub((((b3 & 0x0F) << 1) | (b4 >> 7)) + 1, (((b3 & 0x0F) << 1) | (b4 >> 7)) + 1)
    else
      encoded = encoded .. ("====")
      break
    end

    if chunkBytes > 3 then
      encoded = encoded .. alphabet:sub(((b4 >> 2) & 0x1F) + 1, ((b4 >> 2) & 0x1F) + 1)
      encoded = encoded .. alphabet:sub((((b4 & 0x03) << 3) | (b5 >> 5)) + 1, (((b4 & 0x03) << 3) | (b5 >> 5)) + 1)
    else
      encoded = encoded .. ("===")
      break
    end

    if chunkBytes > 4 then
      encoded = encoded .. alphabet:sub((b5 & 0x1F) + 1, (b5 & 0x1F) + 1)
    else
      encoded = encoded .. ("=")
      break
    end

    i = i + 5
  end

  return encoded
end

---***SRG Custom Function***
---
---Converts base32 to plaintext.
---@param s string
---@param alphabet? string
---@return string
---@nodiscard
function cryptography.base32_to_text(s, alphabet)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if alphabet then
    if type(alphabet) ~= "string" then errorMsg("String", "alphabet", alphabet) end
    if #alphabet ~= 32 then error("Alphabet must be exactly 32 characters long.") end
    local seen = {}
    for i = 1, #alphabet do
      local char = alphabet:sub(i, i)
      if seen[char] then error("Alphabet contains duplicate character: " .. char) end
      seen[char] = true
    end
  else
    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
  end

  local lookup = {}
  for i = 1, #alphabet do
    lookup[alphabet:sub(i, i)] = i - 1
  end

  local paddingCount = 0
  for i = #s, 1, -1 do
    if s:sub(i, i) == "=" then
      paddingCount = paddingCount + 1
    else
      break
    end
  end

  if paddingCount > 6 then
    error("Invalid base32 padding: too many padding characters")
  end

  for i = 1, #s - paddingCount do
    if s:sub(i, i) == "=" then
      error("Invalid base32 padding: padding character in non-terminal position")
    end
  end

  local payloadLength = #s - paddingCount
  if paddingCount > 0 then
    local remainder = payloadLength % 8
    if payloadLength == 0 then
      error("Invalid base32 padding: padding without payload")
    elseif paddingCount == 1 and remainder ~= 7 then
      error("Invalid base32 padding: 1 padding character requires 7 payload characters mod 8")
    elseif paddingCount == 3 and remainder ~= 5 then
      error("Invalid base32 padding: 3 padding characters require 5 payload characters mod 8")
    elseif paddingCount == 4 and remainder ~= 4 then
      error("Invalid base32 padding: 4 padding characters require 4 payload characters mod 8")
    elseif paddingCount == 6 and remainder ~= 2 then
      error("Invalid base32 padding: 6 padding characters require 2 payload characters mod 8")
    elseif paddingCount ~= 1 and paddingCount ~= 3 and paddingCount ~= 4 and paddingCount ~= 6 then
      error("Invalid base32 padding: " .. paddingCount .. " padding characters not allowed")
    end
  end

  s = s:gsub("=", "")

  local remainder = #s % 8
  if remainder == 1 or remainder == 3 or remainder == 6 then
    error("Invalid base32 length: incomplete group")
  end

  local decoded = {}
  local i = 1

  while i <= #s do
    local ch1 = s:sub(i, i)
    local ch2 = i + 1 <= #s and s:sub(i + 1, i + 1) or nil
    local ch3 = i + 2 <= #s and s:sub(i + 2, i + 2) or nil
    local ch4 = i + 3 <= #s and s:sub(i + 3, i + 3) or nil
    local ch5 = i + 4 <= #s and s:sub(i + 4, i + 4) or nil
    local ch6 = i + 5 <= #s and s:sub(i + 5, i + 5) or nil
    local ch7 = i + 6 <= #s and s:sub(i + 6, i + 6) or nil
    local ch8 = i + 7 <= #s and s:sub(i + 7, i + 7) or nil

    local c1 = lookup[ch1]
    if not c1 then error("Invalid base32 character: " .. ch1) end
    local c2 = ch2 and lookup[ch2] or 0
    if ch2 and not lookup[ch2] then error("Invalid base32 character: " .. ch2) end
    local c3 = ch3 and lookup[ch3] or 0
    if ch3 and not lookup[ch3] then error("Invalid base32 character: " .. ch3) end
    local c4 = ch4 and lookup[ch4] or 0
    if ch4 and not lookup[ch4] then error("Invalid base32 character: " .. ch4) end
    local c5 = ch5 and lookup[ch5] or 0
    if ch5 and not lookup[ch5] then error("Invalid base32 character: " .. ch5) end
    local c6 = ch6 and lookup[ch6] or 0
    if ch6 and not lookup[ch6] then error("Invalid base32 character: " .. ch6) end
    local c7 = ch7 and lookup[ch7] or 0
    if ch7 and not lookup[ch7] then error("Invalid base32 character: " .. ch7) end
    local c8 = ch8 and lookup[ch8] or 0
    if ch8 and not lookup[ch8] then error("Invalid base32 character: " .. ch8) end

    table.insert(decoded, string.char(((c1 << 3) | (c2 >> 2)) & 0xFF))
    
    if i + 3 <= #s then
      table.insert(decoded, string.char((((c2 & 0x03) << 6) | (c3 << 1) | (c4 >> 4)) & 0xFF))
    end
    
    if i + 4 <= #s then
      table.insert(decoded, string.char((((c4 & 0x0F) << 4) | (c5 >> 1)) & 0xFF))
    end
    
    if i + 5 <= #s then
      table.insert(decoded, string.char((((c5 & 0x01) << 7) | (c6 << 2) | (c7 >> 3)) & 0xFF))
    end
    
    if i + 7 <= #s then
      table.insert(decoded, string.char((((c7 & 0x07) << 5) | c8) & 0xFF))
    end

    i = i + 8
  end

  return table.concat(decoded)
end

---***SRG Custom Function***
---
---Converts plaintext to base58.
---@param s string
---@param alphabet? string
---@return string
---@nodiscard
function cryptography.text_to_base58(s, alphabet)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if alphabet then
    if type(alphabet) ~= "string" then errorMsg("String", "alphabet", alphabet) end
    if #alphabet ~= 58 then error("Alphabet must be exactly 58 characters long.") end
    local seen = {}
    for i = 1, #alphabet do
      local char = alphabet:sub(i, i)
      if seen[char] then error("Alphabet contains duplicate character: " .. char) end
      seen[char] = true
    end
  else
    alphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
  end

  local base58Chars = toBase58Table(alphabet)

  local function isZero(bignum)
    for i = 1, #bignum do
      if bignum[i] ~= 0 then return false end
    end
    return true
  end

  local function multiplyBySmall(bignum, n)
    local carry = 0
    for i = 1, #bignum do
      local prod = bignum[i] * n + carry
      bignum[i] = prod % 256
      carry = prod // 256
    end
    while carry > 0 do
      table.insert(bignum, carry % 256)
      carry = carry // 256
    end
  end

  local function addSmall(bignum, n)
    local carry = n
    for i = 1, #bignum do
      local sum = bignum[i] + carry
      bignum[i] = sum % 256
      carry = sum // 256
      if carry == 0 then break end
    end
    if carry > 0 then
      table.insert(bignum, carry)
    end
  end

  local function divModBySmall(bignum, n)
    local remainder = 0
    for i = #bignum, 1, -1 do
      local current = remainder * 256 + bignum[i]
      bignum[i] = current // n
      remainder = current % n
    end
    while #bignum > 0 and bignum[#bignum] == 0 do
      table.remove(bignum)
    end
    return remainder
  end

  local leadingZeros = 0
  for i = 1, #s do
    if s:byte(i) ~= 0 then break end
    leadingZeros = leadingZeros + 1
  end

  local bignum = {}
  for i = 1, #s do
    multiplyBySmall(bignum, 256)
    addSmall(bignum, s:byte(i))
  end

  local encoded = {}
  while not isZero(bignum) do
    local rem = divModBySmall(bignum, 58)
    table.insert(encoded, 1, base58Chars[rem])
  end

  for i = 1, leadingZeros do
    table.insert(encoded, 1, base58Chars[0])
  end

  if #encoded == 0 and #s > 0 then
    return base58Chars[0]
  end

  return table.concat(encoded)
end

---***SRG Custom Function***
---
---Converts base58 to plaintext.
---@param s string
---@param alphabet? string
---@return string
---@nodiscard
function cryptography.base58_to_text(s, alphabet)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if alphabet then
    if type(alphabet) ~= "string" then errorMsg("String", "alphabet", alphabet) end
    if #alphabet ~= 58 then error("Alphabet must be exactly 58 characters long.") end
    local seen = {}
    for i = 1, #alphabet do
      local char = alphabet:sub(i, i)
      if seen[char] then error("Alphabet contains duplicate character: " .. char) end
      seen[char] = true
    end
  else
    alphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
  end

  local base58Reverse = table.keypair_reverse(toBase58Table(alphabet))

  local function isZero(bignum)
    for i = 1, #bignum do
      if bignum[i] ~= 0 then return false end
    end
    return true
  end

  local function multiplyBySmall(bignum, n)
    local carry = 0
    for i = 1, #bignum do
      local prod = bignum[i] * n + carry
      bignum[i] = prod % 256
      carry = prod // 256
    end
    while carry > 0 do
      table.insert(bignum, carry % 256)
      carry = carry // 256
    end
  end

  local function addSmall(bignum, n)
    local carry = n
    for i = 1, #bignum do
      local sum = bignum[i] + carry
      bignum[i] = sum % 256
      carry = sum // 256
      if carry == 0 then break end
    end
    if carry > 0 then
      table.insert(bignum, carry)
    end
  end

  local function divModBySmall(bignum, n)
    local remainder = 0
    for i = #bignum, 1, -1 do
      local current = remainder * 256 + bignum[i]
      bignum[i] = current // n
      remainder = current % n
    end
    while #bignum > 0 and bignum[#bignum] == 0 do
      table.remove(bignum)
    end
    return remainder
  end

  local leadingZeros = 0
  local firstChar = alphabet:sub(1, 1)
  for i = 1, #s do
    if s:sub(i, i) ~= firstChar then break end
    leadingZeros = leadingZeros + 1
  end

  local bignum = {}
  for i = 1, #s do
    local char = s:sub(i, i)
    if not base58Reverse[char] then error("Invalid base58 character: " .. char) end
    multiplyBySmall(bignum, 58)
    addSmall(bignum, base58Reverse[char])
  end

  local decoded = {}
  while not isZero(bignum) do
    local rem = divModBySmall(bignum, 256)
    table.insert(decoded, 1, string.char(rem))
  end

  for i = 1, leadingZeros do
    table.insert(decoded, 1, string.char(0))
  end

  if #decoded == 0 and #s > 0 then
    return string.char(0)
  end

  return table.concat(decoded)
end

---***SRG Custom Function***
---
---Performs bitwise SWAP operation on `x`.
---@param x number
---@return number
---@nodiscard
function cryptography.bswap(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  local byte1 = (x & 0xFF) << 24
  local byte2 = ((x >> 8) & 0xFF) << 16
  local byte3 = ((x >> 16) & 0xFF) << 8
  local byte4 = (x >> 24) & 0xFF
  return (byte1 | byte2) | (byte3 | byte4)
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

  x = x & 0xFFFFFFFF
  disp = disp % 32
  local left = (x << disp) & 0xFFFFFFFF
  local right = (x >> (32 - disp)) & 0xFFFFFFFF
  return (left | right) & 0xFFFFFFFF
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

  x = x & 0xFFFFFFFF
  disp = disp % 32
  local right = (x >> disp) & 0xFFFFFFFF
  local left = (x << (32 - disp)) & 0xFFFFFFFF
  return (right | left) & 0xFFFFFFFF
end

---***SRG Custom Function***
---
---Converts `x` to its binary representation.
---@param x number
---@return string
function cryptography.number_to_bit(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  local binary = ""
  for i = 31, 0, -1 do
    local bit = (x >> i) & 1
    binary = binary .. bit
  end
  return binary
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
  local args = { ... }
  if #args < 2 then error("At least two numbers are required") end
  for i, num in ipairs(args) do
    if type(num) ~= "number" then errorMsg("Number", "num", num, i) end
  end

  local result = args[1]
  for i = 2, #args do result = result & args[i] end
  return result ~= 0
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

  local mask = (1 << width) - 1
  return (n >> field) & mask
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

  local mask = (1 << width) - (1 << field)
  return (n & ~mask) | ((v & (1 << width) - 1) << field)
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
    local encryptedByte = charByte ~ keyByte
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

---***SRG Custom Function***
---
---Performs the Luhn algorithm on `x`, an algorithm commonly used for validation of various identification numbers, such as credit card numbers, IMEI numbers, National Provider Identifier numbers in the US, etc.
---
---Returns true if `x` is valid, false otherwise
---@param x number
---@return boolean
---@nodiscard
function cryptography.luhn(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end

  local s = tostring(x)

  local sum = 0

  for i = #s, 1, -1 do
    local digit = tonumber(s:sub(i, i))
    if (#s - i) % 2 == 0 then
      sum = sum + digit
    else
      digit = digit * 2

      if #tostring(digit) > 1 then digit = tonumber(string.sub(digit, 1, 1)) + tonumber(string.sub(digit, 2, 2)) end
      sum = sum + digit
    end
  end

  return sum % 10 == 0
end

---***SRG Custom Function***
---
---Validates whether or not `ip` is a valid ip address.
---
---If `v6` is true, validates for IPv6, otherwise validates for IPv4.
---
---Deprecated in favor of `validate.email()`
---@param ip string
---@param v6? boolean
---@return boolean
---@deprecated
---@nodiscard
function cryptography.is_ip(ip, v6)
  return validate.ip(ip, v6)
end

---***SRG Custom Function***
---
---Validates whether or not `email` is a valid email address.
---
---Deprecated in favor of `validate.email(email)`
---@param email string
---@return boolean
---@deprecated
---@nodiscard
function cryptography.is_email(email)
  return validate.email(email)
end

---Performs sha256 hashing on `s`.
---
---The code below is to understand how the sha256 function works.
---
---(P.S. Please don't try and read the actual code, it's a mess.)
--[[
```lua
if type(s) ~= "string" then
  error_msg("String", "s", s)
end

if cache_256[s] then
  return cache_256[s]
end

if #cache_256 > 1000 then
  cache_256 = {}
end

local function choose(x, y, z)
  return ((x & y) ~ (((~x) & 0xFFFFFFFF) & z)) & 0xFFFFFFFF
end

local function maj(x, y, z)
  return ((x & y) ~ (x & z) ~ (y & z)) & 0xFFFFFFFF
end

local function bsig0(x)
  return (cryptography.ror(x, 2) ~ cryptography.ror(x, 13) ~ cryptography.ror(x, 22)) & 0xFFFFFFFF
end

local function bsig1(x)
  return (cryptography.ror(x, 6) ~ cryptography.ror(x, 11) ~ cryptography.ror(x, 25)) & 0xFFFFFFFF
end

local function ssig0(x)
  return (cryptography.ror(x, 7) ~ cryptography.ror(x, 18) ~ (x >> 3)) & 0xFFFFFFFF
end

local function ssig1(x)
  return (cryptography.ror(x, 17) ~ cryptography.ror(x, 19) ~ (x >> 10)) & 0xFFFFFFFF
end

local function add32(a, b)
  return (a + b) & 0xFFFFFFFF
end

local msg_len = #s
local bit_len = msg_len * 8

local pad_len = 64 - ((msg_len + 1 + 8) % 64)
local padded = s .. string.char(0x80) .. (pad_len < 64 and string.rep(string.char(0), pad_len) or "") .. string.char(
  (bit_len >> 56) & 0xFF,
  (bit_len >> 48) & 0xFF,
  (bit_len >> 40) & 0xFF,
  (bit_len >> 32) & 0xFF,
  (bit_len >> 24) & 0xFF,
  (bit_len >> 16) & 0xFF,
  (bit_len >> 8) & 0xFF,
  bit_len & 0xFF
)

local h = {}
for i = 1, 8 do
  h[i] = sha256_values[i]
end

for chunk = 1, #padded, 64 do
  local w = {}

  for i = 0, 15 do
    local offset = chunk + i * 4
    w[i + 1] = padded:byte(offset) * 0x1000000 + padded:byte(offset + 1) * 0x10000 + padded:byte(offset + 2) * 0x100 + padded:byte(offset + 3)
  end

  for i = 17, 64 do
    w[i] = add32(add32(add32(ssig1(w[i - 2]), w[i - 7]), ssig0(w[i - 15])), w[i - 16])
  end

  local a, b, c, d, e, f, g, h_ = h[1], h[2], h[3], h[4], h[5], h[6], h[7], h[8]

  for i = 1, 64 do
    local t1 = add32(add32(add32(add32(h_, bsig1(e)), choose(e, f, g)), sha256Constants[i]), w[i])
    local t2 = add32(bsig0(a), maj(a, b, c))
    h_ = g
    g = f
    f = e
    e = add32(d, t1)
    d = c
    c = b
    b = a
    a = add32(t1, t2)
  end

  h[1] = add32(h[1], a)
  h[2] = add32(h[2], b)
  h[3] = add32(h[3], c)
  h[4] = add32(h[4], d)
  h[5] = add32(h[5], e)
  h[6] = add32(h[6], f)
  h[7] = add32(h[7], g)
  h[8] = add32(h[8], h_)
end

local hashStr = string.format("%08x%08x%08x%08x%08x%08x%08x%08x", h[1], h[2], h[3], h[4], h[5], h[6], h[7], h[8])
cache256[s] = hashStr
return hashStr
```
]]
---@param s string
---@return string
---@nodiscard
function cryptography.sha256(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  if cache256[s] then return cache256[s] end
  if #cache256 > 1000 then cache256 = {} end

  local bitLen = #s * 8

  local padLen = 64 - ((#s + 1 + 8) % 64)
  local padded = s .. string.char(0x80) .. (padLen < 64 and string.rep(string.char(0), padLen) or "") .. string.char((bitLen >> 56) & 0xFF, (bitLen >> 48) & 0xFF, (bitLen >> 40) & 0xFF, (bitLen >> 32) & 0xFF, (bitLen >> 24) & 0xFF, (bitLen >> 16) & 0xFF, (bitLen >> 8) & 0xFF, bitLen & 0xFF)

  local h = {}
  for i = 1, 8 do h[i] = sha256Values[i] end

  for chunk = 1, #padded, 64 do
    local w = {}

    for i = 0, 15 do
      local offset = chunk + i * 4
      w[i + 1] = padded:byte(offset) * 0x1000000 + padded:byte(offset + 1) * 0x10000 + padded:byte(offset + 2) * 0x100 + padded:byte(offset + 3)
    end

    for i = 17, 64 do
      local w2 = w[i - 2]
      local w15 = w[i - 15]

      w[i] = (((((cryptography.ror(w2, 17) ~ cryptography.ror(w2, 19) ~ (w2 >> 10)) & 0xFFFFFFFF) + w[i - 7]) & 0xFFFFFFFF + ((cryptography.ror(w15, 7) ~ cryptography.ror(w15, 18) ~ (w15 >> 3)) & 0xFFFFFFFF)) & 0xFFFFFFFF + w[i - 16]) & 0xFFFFFFFF
    end

    local a, b, c, d, e, f, g, h_ = h[1], h[2], h[3], h[4], h[5], h[6], h[7], h[8]

    for i = 1, 64 do
      local t1 = ((((h_ + ((cryptography.ror(e, 6) ~ cryptography.ror(e, 11) ~ cryptography.ror(e, 25)) & 0xFFFFFFFF)) & 0xFFFFFFFF + ((e & f) ~ (((~e) & 0xFFFFFFFF) & g)) & 0xFFFFFFFF) & 0xFFFFFFFF + sha256Constants[i]) & 0xFFFFFFFF + w[i]) & 0xFFFFFFFF

      h_ = g
      g = f
      f = e
      e = (d + t1) & 0xFFFFFFFF
      d = c
      c = b
      b = a
      a = (t1 + (((cryptography.ror(a, 2) ~ cryptography.ror(a, 13) ~ cryptography.ror(a, 22)) & 0xFFFFFFFF) + ((a & b) ~ (a & c) ~ (b & c)) & 0xFFFFFFFF)) & 0xFFFFFFFF
    end

    h[1] = (h[1] + a) & 0xFFFFFFFF
    h[2] = (h[2] + b) & 0xFFFFFFFF
    h[3] = (h[3] + c) & 0xFFFFFFFF
    h[4] = (h[4] + d) & 0xFFFFFFFF
    h[5] = (h[5] + e) & 0xFFFFFFFF
    h[6] = (h[6] + f) & 0xFFFFFFFF
    h[7] = (h[7] + g) & 0xFFFFFFFF
    h[8] = (h[8] + h_) & 0xFFFFFFFF
  end

  local hashStr = string.format("%08x%08x%08x%08x%08x%08x%08x%08x", h[1], h[2], h[3], h[4], h[5], h[6], h[7], h[8])
  cache256[s] = hashStr
  return hashStr
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
---@return any
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
---@return any
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
---@return number|table
---@nodiscard
function datetime.add(return_table, ...)
  if return_table and type(return_table) ~= "boolean" then errorMsg("Boolean", "return_table", return_table) end

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
  local args = { ... }
  for i, name in ipairs(args) do
    if type(name) ~= "string" then errorMsg("String", "name", name, i) end
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
  local args = { ... }
  for i, name in ipairs(args) do
    if type(name) ~= "string" then errorMsg("String", "name", name, i) end
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
  local t = { ... }
  if #t < 2 then error("At least two numbers are required") end
  for i, num in ipairs(t) do
    if type(num) ~= "number" then errorMsg("Number", "num", num, i) end
  end

  table.sort(t)
  local middle = #t // 2 + 1
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
  local t = { ... }
  if #t < 2 then error("At least two numbers are required") end
  for i, num in ipairs(t) do
    if type(num) ~= "number" then errorMsg("Number", "num", num, i) end
  end

  local lcm = t[1]
  for i = 2, #t do
    lcm = lcm // math.gcd(lcm, t[i]) * t[i]
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
function math.sinh(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return (math.exp(x) - math.exp(-x)) / 2
end

---***SRG Custom Function***
---
---Calculates the hyperbolic cosine of `x`
---@param x number
---@return number
---@nodiscard
function math.cosh(x)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  return (math.exp(x) + math.exp(-x)) / 2
end

---***SRG Custom Function***
---
---Calculates the hyperbolic tangent of `x`
---@param x number
---@return number
---@nodiscard
function math.tanh(x)
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

---***SRG Custom Function***
---
---Calculates the `n`th root of `x`.
---@param x number
---@param n number
---@return number
---@nodiscard
function math.nroot(x, n)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(n) ~= "number" then errorMsg("Number", "n", n) end

  return x ^ (1 / n)
end

---***SRG Custom Function***
---
---Clamps `x` between `min` and `max`, ensuring it stays within the proper range.
---@param x number
---@param min number
---@param max number
---@return number
---@nodiscard
function math.clamp(x, min, max)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(min) ~= "number" then errorMsg("Number", "min", min) end
  if type(max) ~= "number" then errorMsg("Number", "max", max) end

  if x < min then
    return min
  elseif x > max then
    return max
  else
    return x
  end
end

---***SRG Custom Function***
---
---Converts a value from one range to another.
---@param x number
---@param min1 number
---@param max1 number
---@param min2 number
---@param max2 number
---@return number
---@nodiscard
function math.map(x, min1, max1, min2, max2)
  if type(x) ~= "number" then errorMsg("Number", "x", x) end
  if type(min1) ~= "number" then errorMsg("Number", "min1", min1) end
  if type(max1) ~= "number" then errorMsg("Number", "max1", max1) end
  if type(min2) ~= "number" then errorMsg("Number", "min2", min2) end
  if type(max2) ~= "number" then errorMsg("Number", "max2", max2) end

  return (x - min1) * (max2 - min2) / (max1 - min1) + min2
end

---***SRG Custom Function***
---
---Calculates the distance between two points on a 2d plane.
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@return number
---@nodiscard
function math.distance2d(x1, y1, x2, y2)
  if type(x1) ~= "number" then errorMsg("Number", "x1", x1) end
  if type(y1) ~= "number" then errorMsg("Number", "y1", y1) end
  if type(x2) ~= "number" then errorMsg("Number", "x2", x2) end
  if type(y2) ~= "number" then errorMsg("Number", "y2", y2) end

  return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

---***SRG Custom Function***
---
---Calculates the distance between two points on a 3d plane.
---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@return number
---@nodiscard
function math.distance3d(x1, y1, z1, x2, y2, z2)
  if type(x1) ~= "number" then errorMsg("Number", "x1", x1) end
  if type(y1) ~= "number" then errorMsg("Number", "y1", y1) end
  if type(z1) ~= "number" then errorMsg("Number", "z1", z1) end
  if type(x2) ~= "number" then errorMsg("Number", "x2", x2) end
  if type(y2) ~= "number" then errorMsg("Number", "y2", y2) end
  if type(z2) ~= "number" then errorMsg("Number", "z2", z2) end

  return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2 + (z2 - z1) ^ 2)
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

  local toReturn = {}
  local start = 1

  for i = 1, #s do
    local isPattern = false
    for _, pattern in ipairs({ ... }) do
      if type(pattern) ~= "string" then errorMsg("String", "pattern", pattern, i + 1) end
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
  local args = { ... }

  local startsWith = false
  for i, pattern in ipairs(args) do
    if type(pattern) ~= "string" then errorMsg("String", "pattern", pattern, i + 1) end
    if s:sub(1, #pattern) == pattern then startsWith = true end
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
  local args = { ... }

  local startsWith = false
  for i, pattern in ipairs(args) do
    if type(pattern) ~= "string" then errorMsg("String", "pattern", pattern, i + 1) end
    if s:sub(- #pattern) == pattern then startsWith = true end
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

  local amount = 0
  for i, pattern in ipairs({ ... }) do
    if type(pattern) ~= "string" then errorMsg("String", "pattern", pattern, i + 1) end
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

---***SRG Custom Function***
---
---Calculates the Levenshtein distance between two strings `s1` and `s2`
---@param s1 string
---@param s2 string
---@return number
---@nodiscard
function string.levenshtein(s1, s2)
  if type(s1) ~= "string" then errorMsg("String", "s1", s1) end
  if type(s2) ~= "string" then errorMsg("String", "s2", s2) end
  return levenshteinMain(s1, s2, #s1, #s2)
end

---***SRG Custom Function***
---
---Wraps `s` to `length` characters per line
---@param s string
---@param length number
---@return string
---@nodiscard
function string.wrap(s, length)
  if type(s) ~= "string" then errorMsg("String", "s", s) end
  if type(length) ~= "number" then errorMsg("Number", "length", length) end

  local wrapped = ""
  local line = ""
  for word in s:gmatch("%S+") do
    if #line > 0 then
      if #line + #word + 1 > length then
        wrapped = wrapped .. line .. "\n"
        line = word
      else
        line = line .. " " .. word
      end
    else
      line = word
    end
  end
  wrapped = wrapped .. line
  return wrapped
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
  local args = { ... }
  if #args < 1 then error("At least one table is required") end
  for i, tabl in ipairs(args) do
    if type(tabl) ~= "table" then errorMsg("Table", "tabl", tabl, i + 1) end
  end

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
  local args = { ... }
  if #args < 1 then error("At least two or more table are required") end
  for i, tabl in ipairs(args) do
    if type(tabl) ~= "table" then errorMsg("Table", "tabl", tabl, i) end
  end

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
  local args = { ... }
  if #args < 1 then error("At least one table is required") end
  for i, tabl in ipairs(args) do
    if type(tabl) ~= "table" then errorMsg("Table", "tabl", tabl, i) end
  end

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
  local args = { ... }
  if #args < 1 then error("At least two or more tables are required") end
  for i, tabl in ipairs(args) do
    if type(tabl) ~= "table" then errorMsg("Table", "tabl", tabl, i) end
  end

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

---***SRG Custom Function***
---
---Serializes `t` to a string representation with customizable `sep`.
---@param t table
---@param sep? string
function table.to_string(t, sep)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  if sep then
    if type(sep) ~= "string" then errorMsg("String", "sep", sep) end
  else
    sep = "."
  end

  local str = "{"

  for key, value in pairs(t) do
    if type(key) == "number" then
      if type(value) == "table" then
        str = str .. table.to_string(value, sep) .. sep
      else
        str = str .. tostring(value) .. ", "
      end
    else
      if type(value) == "table" then
        str = str .. key .. sep .. table.to_string(value, sep) .. sep
      else
        str = str .. key .. sep .. tostring(value) .. ", "
      end
    end
  end
  if str:sub(-2) == ", " then str = str:sub(1, -3) end
  if str:sub(-1) == sep then str = str:sub(1, -2) end

  return str .. "}"
end

---***SRG Custom Function***
---
---Deserializes the stringified table `str` back to a table structure based on customizable `sep`.
---@param str string
---@param sep? string
function table.from_string(str, sep)
  if type(str) ~= "string" then errorMsg("String", "str", str) end

  if sep then
    if type(sep) ~= "string" then errorMsg("String", "sep", sep) end
  else
    sep = "."
  end

  str = str:gsub("^%s*{%s*", ""):gsub("%s*}%s*$", "")

  local t = {}
  local i = 1

  while i <= #str do
    local char = str:sub(i, i)

    if char:match("%s") then
      i = i + 1
    elseif char == "{" then
      local depth = 1
      local start = i
      i = i + 1

      while i <= #str and depth > 0 do
        local c = str:sub(i, i)
        if c == "{" then
          depth = depth + 1
        elseif c == "}" then
          depth = depth - 1
        end
        i = i + 1
      end

      local nestString = str:sub(start, i - 1)
      local nestTable = table.from_string(nestString, sep)
      table.insert(t, nestTable)
    elseif char == "," then
      i = i + 1
    else
      local start = i
      local foundSep = false

      while i <= #str do
        local c = str:sub(i, i)
        if c == "," then break end
        if c == "{" then break end
        i = i + 1
      end

      local element = str:sub(start, i - 1):match("^%s*(.-)%s*$")

      local key, value = element:match("^(.-)%" .. sep .. "(.+)$")

      if key and value then
        local num = tonumber(value)
        t[key] = num or value
      else
        local num = tonumber(element)
        table.insert(t, num or element)
      end
    end
  end

  return t
end

---***SRG Custom Function***
---
---Applies `func` to each element in `t` and returns a new table with the results.
---@param t table
---@param func function
---@return table
---@nodiscard
function table.map(t, func)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end
  if type(func) ~= "function" then errorMsg("Function", "func", func) end
  if #t == 0 then error("'t' is empty") end

  local result = {}
  for i, v in ipairs(t) do
    local success, res = pcall(func, v)
    if not success then error("'func' is not a valid function: " .. res) end
    result[i] = res
  end
  return result
end

---***SRG Custom Function***
---
---Filters `t` using `func` and returns a new table with the results.
---@param t table
---@param func function
---@return table
---@nodiscard
function table.filter(t, func)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end
  if type(func) ~= "function" then errorMsg("Function", "func", func) end
  if #t == 0 then error("'t' is empty") end

  local result = {}
  for i, v in ipairs(t) do
    local success, res = pcall(func, v)
    if not success or type(res) ~= "boolean" then error("'func' is not a valid function: " .. res) end
    if res then table.insert(result, v) end
  end
  return result
end

---***SRG Custom Function***
---
---Returns a table of each element in `t` with no duplicates.
---@param t table
---@return table
---@nodiscard
function table.unique(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end
  if #t == 0 then error("'t' is empty") end

  local result = {}
  for _, v in ipairs(t) do
    if not table.contains(v, result) then table.insert(result, v) end
  end
  return result
end

---***SRG Custom Function***
---
---Returns a table that contains each element in the given tables.
---@param ... table
---@return table
---@nodiscard
function table.zip(...)
  local args = { ... }
  if #args < 1 then error("At least two or more tables are required") end
  for i, tabl in ipairs(args) do
    if type(tabl) ~= "table" then errorMsg("Table", "tabl", tabl, i) end
  end

  local result = {}
  local maxLen = 0
  for _, t in ipairs(args) do maxLen = math.max(maxLen, #t) end
  for i = 1, maxLen do
    local tuple = {}
    for _, t in ipairs(args) do table.insert(tuple, t[i]) end
    table.insert(result, tuple)
  end
  return result
end

---***SRG Custom Function***
---
---Returns a table containing each key in `t`.
---@param t table
---@return table
---@nodiscard
function table.keys(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local result = {}
  for k, _ in ipairs(t) do table.insert(result, k) end
  return result
end

---***SRG Custom Function***
---
---Returns a table containing each value in `t`.
---@param t table
---@return table
---@nodiscard
function table.values(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  local result = {}
  for _, v in ipairs(t) do table.insert(result, v) end
  return result
end

-------------File Library-------------

---***SRG Custom Function***
---
---Creates a file with the specified `name` and `content`.
---@param name string
---@param content string
function file.new(name, content)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if type(content) ~= "string" then errorMsg("String", "content", content) end

  local f = io.open(name, "w")
  if not f then error("Failed to create file: " .. name) end
  f:write(content)
  f:close()
end

---***SRG Custom Function***
---
---Reads the content of the file with the specified `name`.
---@param name string
---@return string
---@nodiscard
function file.read(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end

  local f = io.open(name, "r")
  if not f then error("Failed to read file: " .. name) end
  return f:read("*a")
end

---***SRG Custom Function***
---
---Rewrites the content of the file with the specified `name` with `content`.
---@param name string
---@param content string
function file.rewrite(name, content)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if type(content) ~= "string" then errorMsg("String", "content", content) end

  local f, err = io.open(name, "w+")
  if not f then error("Failed to rewrite file: " .. err) end
  f:write(content)
  f:close()
end

---***SRG Custom Function***
---
---Appends `content` to the file with the specified `name`.
---@param name string
---@param content string
function file.append(name, content)
  if type(name) ~= "string" then errorMsg("String", "name", name) end
  if type(content) ~= "string" then errorMsg("String", "content", content) end

  local f, err = io.open(name, "a")
  if not f then error("Failed to append to file: " .. err) end
  f:write(content)
  f:close()
end

---***SRG Custom Function***
---
---Checks if the file with the specified `name` exists.
---@param name string
---@return boolean
function file.exists(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end

  local f = io.open(name, "r")
  if f then
    f:close()
    return true
  else
    return false
  end
end

---***SRG Custom Function***
---
---Returns the size of the file with the specified `name` in bytes.
---@param name string
---@return number
function file.size(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end

  local f, err = io.open(name, "r")
  if not f then error("Failed to get file size: " .. err) end
  local size = f:seek("end")
  f:close()
  return size
end

---***SRG Custom Function***
---
---Returns the amount of lines in the file with the specified `name`.
---@param name string
---@return number
function file.lines(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end

  local f, err = io.open(name, "r")
  if not f then error("Failed to get file lines: " .. err) end

  local lines = 0
  for _ in f:lines() do lines = lines + 1 end
  f:close()
  return lines
end

---***SRG Custom Function***
---
---Deletes the file with the specified `name`.
---@param name string
function file.delete(name)
  if type(name) ~= "string" then errorMsg("String", "name", name) end

  local success, err = os.remove(name)
  if not success then error("Failed to delete file: " .. err) end
end

--------------Http Library-------------

---***SRG Custom Function***
---
---Send a POST request to the specified `url` with the specified json `data`.
---@param url string
---@param data string
---@return string
---@nodiscard
function http.post(url, data)
  if type(url) ~= "string" then errorMsg("String", "url", url) end
  if type(data) ~= "string" then errorMsg("String", "data", data) end

  local result = ""
  if system.is_windows then
    local success, res = io.popen(string.format(
      "powershell -Command \"Invoke-WebRequest -Uri '%s' -Method POST -Body %s\"",
      url, data
    )):read()
    if not success then error("Failed to send POST request: " .. res) else result = res end
  elseif system.is_mac or system.is_linux then
    local success, res = io.popen(string.format(
      "curl -X POST -H 'Content-Type: application/json' -d '%s' %s",
      data, url
    )):read()
    if not success then error("Failed to send POST request: " .. res) else result = res end
  elseif system.is_chrome then
    warn("Chrome OS is not supported for HTTP requests.")
  end
  return result
end

---***SRG Custom Function***
---
---Send a GET request to the specified `url`.
---@param url string
---@return string
---@nodiscard
function http.get(url)
  if type(url) ~= "string" then errorMsg("String", "url", url) end

  local result = ""
  if system.is_windows then
    local success, res = io.popen(string.format(
      "powershell -Command \"Invoke-WebRequest -Uri '%s' -Method GET\"",
      url
    )):read()
    if not success then error("Failed to send GET request: " .. res) else result = res end
  elseif system.is_mac or system.is_linux then
    local success, res = io.popen(string.format(
      "curl -X GET %s",
      url
    )):read()
    if not success then error("Failed to send GET request: " .. res) else result = res end
  elseif system.is_chrome then
    warn("Chrome OS is not supported for HTTP requests.")
  end
  return result
end

---***SRG Custom Function***
---
---Send a DELETE request to the specified `url`.
---@param url string
---@return string
---@nodiscard
function http.delete(url)
  if type(url) ~= "string" then errorMsg("String", "url", url) end

  local result = ""
  if system.is_windows then
    local success, res = io.popen(string.format(
      "powershell -Command \"Invoke-WebRequest -Uri '%s' -Method DELETE\"",
      url
    )):read()
    if not success then error("Failed to send DELETE request: " .. res) else result = res end
  elseif system.is_mac or system.is_linux then
    local success, res = io.popen(string.format(
      "curl -X DELETE %s",
      url
    )):read()
    if not success then error("Failed to send DELETE request: " .. res) else result = res end
  elseif system.is_chrome then
    warn("Chrome OS is not supported for HTTP requests.")
  end
  return result
end

---***SRG Custom Function***
---
---Send a PUT request to the specified `url` with the specified json `data`.
---@param url string
---@param data string
---@return string
---@nodiscard
function http.put(url, data)
  if type(url) ~= "string" then errorMsg("String", "url", url) end
  if type(data) ~= "string" then errorMsg("String", "data", data) end

  local result = ""
  if system.is_windows then
    local success, res = io.popen(string.format(
      "powershell -Command \"Invoke-WebRequest -Uri '%s' -Method PUT -Body %s\"",
      url, data
    )):read()
    if not success then error("Failed to send PUT request: " .. res) else result = res end
  elseif system.is_mac or system.is_linux then
    local success, res = io.popen(string.format(
      "curl -X PUT -H 'Content-Type: application/json' -d '%s' %s",
      data, url
    )):read()
    if not success then error("Failed to send PUT request: " .. res) else result = res end
  elseif system.is_chrome then
    warn("Chrome OS is not supported for HTTP requests.")
  end
  return result
end

---***SRG Custom Function***
---
---Send a PATCH request to the specified `url` with the specified json `data`.
---@param url string
---@param data string
---@return string
---@nodiscard
function http.patch(url, data)
  if type(url) ~= "string" then errorMsg("String", "url", url) end
  if type(data) ~= "string" then errorMsg("String", "data", data) end

  local result = ""
  if system.is_windows then
    local success, res = io.popen(string.format(
      "powershell -Command \"Invoke-WebRequest -Uri '%s' -Method PATCH -Body %s\"",
      url, data
    )):read()
    if not success then error("Failed to send PATCH request: " .. res) else result = res end
  elseif system.is_mac or system.is_linux then
    local success, res = io.popen(string.format(
      "curl -X PATCH -H 'Content-Type: application/json' -d '%s' %s",
      data, url
    )):read()
    if not success then error("Failed to send PATCH request: " .. res) else result = res end
  elseif system.is_chrome then
    warn("Chrome OS is not supported for HTTP requests.")
  end
  return result
end

---***SRG Custom Function***
---
---Escapes a string for use in a URL.
---@param s string
---@return string
---@nodiscard
function http.escape(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  s = s:gsub("([^%w%-%.%_%~])", function(c) return string.format("%%%02X", c:byte()) end)
  return s
end

---***SRG Custom Function***
---
---Unescapes a string from a URL.
---@param s string
---@return string
---@nodiscard
function http.unescape(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  s = s:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end)
  return s
end

-------------JSON Library-------------

---***SRG Custom Function***
---
---Encodes a Lua table (`t`) to a JSON string.
---@param t table
---@return string
---@nodiscard
function json.encode(t)
  if type(t) ~= "table" then errorMsg("Table", "t", t) end

  return jsonEncode(t)
end

---***SRG Custom Function***
---
---Decodes a JSON string (`s`) to a Lua table.
---@param s string
---@return any
---@nodiscard
function json.decode(s)
  if type(s) ~= "string" then errorMsg("String", "s", s) end

  return jsonDecode(s)
end

-----------Terminal Library-----------

---***SRG Custom Function***
---
---Clears the terminal.
function terminal.clear()
  if system.is_windows then
    os.execute("cls")
  else
    os.execute("clear")
  end
end

---***SRG Custom Function***
---
---Makes a specific bit of text styled with the specified styles.
---@param text string
---@param ... terminal_styles
---@return string
---@nodiscard
function terminal.style(text, ...)
  if type(text) ~= "string" then errorMsg("String", "text", text) end

  local styled = "\\033["
  local styles = { ... }

  for i, style in ipairs(styles) do
    if type(style) ~= "string" then errorMsg("String", "style", style, i + 1) end
    if not terminalStyles[style] then error("Invalid style: " .. style) end
    styled = styled .. terminalStyles[style] .. ";"
  end

  styled = styled:sub(1, -2) .. "m" .. text .. "\\033[0m"
  return styled
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
---Runs `func` `iterations` times with the given arguments.
---
---NOTE: If `iterations` is not given, the code will run 10 times
---
---Returns:
---- `Total Execution Time`
---- `Average Execution Time Per Run`
---- `The Last Result (if return is added in the code)`
---@param func function
---@param iterations? number
---@param ...? any
---@return number Total_Timer
---@return number Average_Time_Per_Run
---@return string Last_Result
function benchmark(func, iterations, ...)
  if type(func) ~= "function" then errorMsg("Function", "func", func) end
  if iterations then
    if type(iterations) ~= "number" then errorMsg("Number", "iterations", iterations) end
  else
    iterations = 10
  end

  local startTime = os.clock()
  local lastResult

  for i = 1, iterations do
    local success, result = pcall(func, ...)
    if not success then error("Error in iteration " .. i .. ": " .. result) end
    lastResult = result
  end

  local totalTime = os.clock() - startTime
  return totalTime, totalTime / iterations, lastResult
end

---***SRG Custom Function***
---
---Runs `func` and returns the time it takes to run `func` with the given arguments.
---@param func function
---@param ... any
---@return number Time
---@return string Result
function execution_time(func, ...)
  if type(func) ~= "function" then errorMsg("Function", "func", func) end

  local start = os.clock()
  local success, result = pcall(func, ...)
  if not success then error("Error executing function: " .. result) end

  return os.clock() - start, result
end

---***SRG Custom Function***
---
---Yields `t` seconds before running `func` with the given arguments without stopping other code.
---@param t number
---@param func function
---@param ...? any
---@return boolean success
---@return any result
function delay(t, func, ...)
  if type(t) ~= "number" then errorMsg("Number", "t", t) end
  if type(func) ~= "function" then errorMsg("Function", "func", func) end

  local args = { ... }
  return coroutine.wrap(function()
    wait(t)
    return pcall(func, table.unpack(args))
  end)()
end

---***SRG Custom Function***
---
---Yields `t` seconds before running `func` with the given arguments while stopping other code.
---@param t number
---@param func function
---@param ...? any
---@return boolean success
---@return any result
function delay_stop(t, func, ...)
  if type(t) ~= "number" then errorMsg("Number", "t", t) end
  if type(func) ~= "function" then errorMsg("Function", "func", func) end

  wait(t)
  return pcall(func, ...)
end