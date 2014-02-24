pair = "name = Anna"
_, _, key,value = string.find(pair,"(%a+)%s*=%s*(%a+)")
print(key,value)
date = "17/7/1990"
_, _, d, m, y = string.find(date,"(%d+)/(%d+)/(%d+)")
print(d,m,y)
