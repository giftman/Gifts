print(table.getn{2,3,1})
print(table.getn{2,3,nil})
print(table.getn{10,2,nil; n=3})
print(table.getn{n=1000})

--a = {}
--print(table.getn(a))
--table.setn(a,10000) --deperate...
--print(table.getn(a))
--table insert
a = {}
for line in io.lines() do
    table.insert(a,line)
end
print(table.getn(a))

