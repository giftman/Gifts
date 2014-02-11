--14.1 what ..it means ...
function getfield (f)
    local v = _G
    for w in string.gfind(f,"[%w_]+") do
        v = v[w]
    end
    return v
end

a.b.c.d.e = v
local temp = a.b.c.d
temp.e = v
