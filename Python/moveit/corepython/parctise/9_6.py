#!/usr/bin/env python
import sys
fileone = open(sys.argv[1])
filetwo = open(sys.argv[2])

fileones = fileone.readlines()
filetwos = filetwo.readlines()

m = n = 0
for i in range(min(len(fileones),len(filetwos))):
    one_l = fileones[i]
    two_l = filetwos[i]
    print one_l,two_l
    for j in range(min(len(one_l),len(two_l))):
        print(m,n)
        print(one_l[j],two_l[j])
        if one_l[j] != two_l[j]:
            m = i
            n = j
            break

if m != n:
    print('answser is :')
    print(m,n)
