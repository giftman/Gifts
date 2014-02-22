function pairsByKeys (t,f)
    local a = {}
    for n in pairs(t) do table.insert(a,n) end
    table.sort(a,f)
    local i = 0
    local iter = function ()
        i = i + 1
        if a[i] == nil then return nil
        else return a[i],t[a[i]]
        end
    end
    return iter
end
lines = {
    luaH_set = 10,
    luaH_get = 24,
    luaH_present = 48,
}
for name,line in pairsByKeys(lines) do
    print(name,line)
end
