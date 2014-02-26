--io.output("date")
--replace
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
--io.lines
--[[
local count = 1
while true do
local line = io.read()
if line == nil then break end
io.write(string.format("%6d ",count),line,"\n")
count = count + 1
end]]
--io.sort
--[[
local lines = {}
-- read the lines in table 'lines'
for line in io.lines() do
    print(line)
    i,j =string.find(line,".*permission.*") 
    print(i,j)
    if  i~= nil  then  
        table.insert(lines,line)
    end
end
table.sort(lines)
io.output("AndroidManifest1.xml")
for i,l in ipairs(lines) do io.write(l,"\n") end
]]
io.input("date")
local pat = "(%S+)%s+(%S+)%s+(%S+)%s+"
for n1,n2,n3 in string.gfind(io.read("*all"),pat) do
    print(math.max(n1,n2,n3))
end
