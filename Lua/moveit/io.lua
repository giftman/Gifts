--io.output("date")
--[[
newVersion = 235001 
io.write("sin (3) = ",math.sin(3),"\n")
print("hello","Lua");print("Hi")
io.write("hello","Lua");io.write("Hi","\n")
io.input("AndroidManifest.xml")
t = io.read("*all")
t = string.gsub(t,"android:versionCode=\".-\"","android:versionCode=\"".. newVersion .."\"")
io.output("AndroidManifest.xml")
io.write(t)
]]

io.input("AndroidManifest.xml")
local count = 1
while true do
    local line = io.read()
    if line == nil then break end
    io.write(string.format("%6d ",count),line,"\n")
    count = count + 1
end

