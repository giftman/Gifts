--private member should be in one file
--one file can define some packages
--local C = complex --one word express a word --!
--openpackage
function openpackage (ns)
    for n,v in pairs(ns) do 
        if _G[n] ~= nil then 
            error("name clash:" .. n .. " is already defined")
        end
        _G[n] = v
    end
end
--load packages clever.good!
local location = {
    foo = "/usr/local/lua/lib/pack1_1.lua",
    goo = "/usr/local/lua/lib/pack1_1.lua",
    fool = "/usr/local/lua/lib/pack1_2.lua",
    gool = "/usr/local/lua/lib/pack1_3.lua",
}


pack1 = {}
setmetatable(pack1,{__index = function (t,funcname)
    local file = location[funcname] 
    if not file then 
        error("package pack1 does not define" .. funcname)
    end
    assert(loadfile(file))()
    return t[funcname]
end})
return pack1

