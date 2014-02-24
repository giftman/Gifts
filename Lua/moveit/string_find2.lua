s = "hello world"
local t = {}
local i = 0
while true do
    i = string.find(s,"l",i+1)
    if i == nil then break end
    table.insert(t,i)
end
for k,v in pairs(t) do print(v) end
