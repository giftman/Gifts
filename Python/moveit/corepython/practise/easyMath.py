#!/usr/bin/env python

from operator import add,sub,imul
from random import randint,choice

ops={'+':add,'-':sub,'*':imul}
MAXTRIES=2

def doprob():
    op=choice('+-*')
    nums=[randint(1,10) for i in range(2)]
    nums.sort(reverse=True)
    ans =ops[op](*nums)
    pr= '%d %s %d=' %(nums[0],op,nums[1])
    oops=0
    while True:
        try:
            if int(raw_input(pr)) ==ans:
                print 'correct'
                break
            if oops==MAXTRIES:
                print 'answer: %s%d ' % (pr,ans)
            else:
                print 'try again'
                oops +=1
        except Exception,e:
            print e

def main():
    while True:
        doprob()
        try:
            opt = raw_input('Again?[y]').lower()
            if opt and opt[0] == 'n':
                break
        except Exception,e:
            break

if __name__== '__main__':
    main()
