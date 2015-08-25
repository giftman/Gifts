#coding  utf-8

import random
keys=[1,2,3,4,5,6]
tmp = 10000
times=[]
while(tmp>0):
    tkey = str(random.choice(keys))
    times.append(tkey)
    tmp -=1
from collections import Counter
#print(sorted(Counter(times)))

print(sorted(zip(Counter(times).values(),Counter(times).keys())))

print(random.sample(keys,2))
random.shuffle(keys)
print(keys)
print(random.randint(0,10))
#0~1
print(random.random())
#N
print(random.getrandbits(2000))
