--one solve
--[[
a = 1 --create a global variable
-- change current environment
setfenv(1,{ _G = _G})  --p107 you should populate the old enviroment first
_G.print(a) 
_G.print(_G.a) 
]]

--another solve (I think cool) change don't worry about the global table.
a = 1
local newgt = {}
setmetatable(newgt,{__index = _G})
setfenv(1,newgt)
print(a)

--continuing previous code 
a = 10
print(a)
print(_G.a)
_G.a = 20
print(_G.a)
