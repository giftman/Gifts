--a good example
words = {}
for w in string.gfind("hello hi,again","%a") do
    table.insert(words,w)
end
s = {name = "al", query = "a+b = c", q="yes or no"}
function escape(s)
    s = string.gsub(s,"([&=+%c])",function(c) --%c control character
        return string.format("%%%02X",string.byte(c)) --two %% for the %
    end)
    s = string.gsub(s," ","+")
    return s 
end

function encode(t)
    local s = ""
    for k,v in pairs(t) do
        s = s .. "&" .. escape(k) .. "=" .. escape(v)
    end
    return string.sub(s,2)
end

print(encode(s))
s = encode(s)
cgi = {}
function unescape (s)
    s = string.gsub(s,"+"," ")
    s = string.gsub(s,"%%(%x%x)",function (h)
        return string.char(tonumber(h,16))
    end)
    return s
end
function decode(s)
    for name,value in string.gfind(s,"([^&=]+)=([^&=]+)") do
        name = unescape(name)
        value = unescape(value)
        cgi[name] = value
    end
end
decode(s)
for k,v in pairs(cgi) do print(v) end
