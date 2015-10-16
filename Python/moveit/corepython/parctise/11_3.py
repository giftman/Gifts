#!/usr/bin/env python
def m_max(seq=()):
    if seq == ():
        print "seq is empty!"
        return ""
    max_n = 0
    for eachse in seq:
        if eachse > max_n:
            max_n = eachse
    return max_n

print(m_max(()))
a=[1,2,3]
b=['abc','def','ghi']
print(map(None,a,b))
print(zip(a,b))

print([n for n in range(2000,2010) if n%400])

