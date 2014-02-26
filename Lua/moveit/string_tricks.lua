--...don't know why it do this...
--pattern = string.rep("[^\n]",70) .. "[^\n]*"
--print(pattern)
function code (s)
    return (string.gsub(s,"\\(.)",function (x)
        print(x)
        return string.format("\\%03d",string.byte(x))
    end))
end
function decode (s)
    return (string.gsub(s,"\\(%d%d%d)",function(d)
        return  "\\" .. string.char(d)
    end))
end
s = [[follows a typical string: "This is "great"!".]]
s = code(s)
print(s)
s = string.gsub(s,'(".-")',string.upper)
s = decode(s)
print(s)
