--Lua use weak tables to help recycle. An Object(Object) only live in weak tables it will be recycle.
--__mode-->weak
--key or value is weak, then they will be recycle.Only object will be recycle,not a number,method or string.
a = {}
b = {}
setmetatable(a,b)
b.__mode = "k"

key = {}
a[key] = 1
key = {}
a[key] = 2

collectgarbage()

for k,v in pairs(a) do print(v) end
