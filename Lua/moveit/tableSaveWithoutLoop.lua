function serialize (o)
    if type(o) == "number" then
        io.write(o)
    elseif type(o) == "string" then
        io.write(string.format("%q",o)) --good choose
    elseif type(o) == "table" then
        io.write("{\n")
        for k,v in pairs(o) do
           -- io.write(" ",k," = ")
           io.write(" [")
           serialize(k)
           io.write("] = ")
            serialize(v)
            io.write(",\n")
        end
        io.write("}\n")
    else
        error("cannot serialize a " .. type(o))
    end
end

serialize{a=12,b='Lua',key='another "one"'}
