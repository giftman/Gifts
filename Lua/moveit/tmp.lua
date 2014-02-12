--require complex.lua ? how to use this. Just tell me how to require the package in sample
local P = {}
if _REQUIREDNAME == nil then
    complex = P
else
    _G[_REQUIREDNAME] = P
end
