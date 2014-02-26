pair = "name = Anna"
_, _, key,value = string.find(pair,"(%a+)%s*=%s*(%a+)")
print(key,value)
date = "17/7/1990"
_, _, d, m, y = string.find(date,"(%d+)/(%d+)/(%d+)")
print(d,m,y)
s = [[then he said: "it's all right"!]]
a,b,c,quotedPart = string.find(s,"([\"])(.-)%1")
print(quotedPart)
print(a,b,c)
print(string.gsub("hello Lua!","(%a)","%1-%1"))
print(string.gsub("hello Lua","(.)(.)","%2%1"))
function trim (s)
    return (string.gsub(s,"^%s*(.-)%s*s","%1"))
end

s = "sin(3) = $[math.sin(3)]|2^5 = $[2^5]"
print((string.gsub(s,"$(%b[])",function(x)
    x = "return " .. string.sub(x,2,-2)
    local f = loadstring(x)
    return f()
end)))
