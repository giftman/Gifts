#!/usr/bin/env python
#testfile = open('unicode.txt')
#for line in testfile:
#    #if line.startswith('#'):
#    if '#' in line:
#        continue
#    else:
#        print line,
#lineN = raw_input('Please input lines num')
#filename = raw_input('Please input lines filename :  ')
#testfile = open(filename)
#lines = 25
#while True:
#    if lines > 0:
#        print(testfile.readline())
#        lines = lines - 1
#        if lines == 0:
#            endpoint = raw_input('Entern any key continue :  ')
#            if endpoint == 'e':
#                testfile.close()
#                break;
#            else:
#                lines = 25

with open('data.txt','w') as f:
    for i in range(100):
        f.write(str(i))
        f.write('\n')
with open('data.txt') as f:
    num = 1
    for eachline in f:
        if num % 26 != 0:
            print(eachline)
            num += 1
        else:
            endpoint = raw_input('continue until c happen : ')
            num += 1
            if endpoint == 'c':
                break




