local s = tonumber(io.popen("powershell -Command \"((Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize - (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory) * 1KB\""):read())
print(s)
print(type(s))