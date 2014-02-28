print(os.time{year=1970,month=1,day=1,hour=0})
print(os.time{year=1970,month=1,day=1,hour=0,sec=1})
print(os.time{year=1970,month=1,day=1})
temp = os.date("%x",906000490)
print(temp)
print(os.date("today is %A,in %B"))
print(os.date("today is %%c"))
print(os.date("today is %x %X"))
--caculate the used time
local x = os.clock()
local s = 0
for i=1,10000000 do s = s + i end
print(string.format("elapsed time: %.2f\n",os.clock()-x))
print(os.getenv("HOME"))
