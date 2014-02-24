s = string.gsub("Lua is cute","cute","great")
print(s)
s = string.gsub("all lii","l","x")
print(s)
s = string.gsub("Lua is great","perl","tcl")
print(s)
s = string.gsub("all lii","l","x",1)
print(s)
s = string.gsub("all lii","l","x",2)
print(s)
_,count = string.gsub("all lii what is good"," "," ")
print(count)
s = "Deadline is 10/05/1999,firm"
date = "%d%d/%d%d/%d%d%d%d"
print(string.sub(s,string.find(s,date)))
print(string.gsub("hello, up-down!","%A","."))
_, nvow = string.gsub("test","[AEIOUaeiou]","")
print(nvow)
--[%w_]  [01] [%[%]] [0-9] [0-7] [^\n]
i,j = string.find("the number 1298 is even","%d+")
print(i,j)


