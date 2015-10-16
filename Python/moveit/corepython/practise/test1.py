#!/usr/bin/env python

from operator import add,sub,mul
from random import randint,choice

ops={'-':sub,'+':add,'*':mul}
MAXTRIES=2

def drop():
    op=choice('-+*')
    nums=[randint(1,10) for i in range(2)]
    nums.sort(reverse=True)
    ans = ops[op](*nums)
    pre = "%d %s %d = " % (nums[0],op,nums[1])
    times = 0
    while True:
        try:
            if int(raw_input(pre)) == ans:
                print 'corret'
                break
            if times == MAXTRIES:
                print '%s %s' % (pre,ans)
                break
            else:
                print 'wrong tryagain'
                times +=1
        except Exception,e:
            print e

def main():
    while True:
        drop()
        try:
            op = raw_input('Again?[y]')
            if op and op=='n':
                break
        except Exception,e:
            print e

if __name__ == '__main__':
    main()

