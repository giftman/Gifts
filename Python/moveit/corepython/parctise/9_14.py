#!/usr/bin/env python
import sys
if sys.argv[1] == 'print':
    with open('tmp.txt') as f:
        for line in f:
            print(line)
    with open('tmp.txt', 'w') as f:
        f.write('')
else:
    result =  eval(sys.argv[1])
    with open('tmp.txt','a+') as f:
        f.write(sys.argv[0] + sys.argv[1])
        f.write('\n')
        f.write(str(result))
        f.write('\n')
    print(result)
