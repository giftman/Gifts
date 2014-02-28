--complete io has the handle...and use the ":" to call the method
local f = assert(io.open("date","r"))
local t = f:read("*all")
f:close()
io.stderr:write("Your message")

--complex use
local temp = io.input()
io.input("AndroidManifest.xml")
local android = io.read("*all")
print(android)
io.input():close()
io.input(temp)
