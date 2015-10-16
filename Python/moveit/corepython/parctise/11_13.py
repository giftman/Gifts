#!/usr/bin/env python

import time

def mult(x,y):
    return x*y

print(reduce(mult,range(1,10)))
print(reduce(lambda x,y:x*y,range(1,10)))

def factorial(n):
    if n == 0 or n == 1:
        return 1
    else:
        return (n*factorial(n-1))

def fa_reduce(n):
    return reduce(lambda x,y:x*y,range(1,n+1))

def fa_for(n):
    result = 1
    while n>0:
        result=result*n
        n=n-1
    return result

def testit(func,*nkwargs,**kwargs):
    try:
        retval = func(*nkwargs,**kwargs)
        result = (True,retval)
    except Exception,diag:
        result = (False,str(diag))
    return result

def timeit(func,*nkwargs,**kwargs):
    try:
        s_time = time.time()*100000
        retval = func(*nkwargs,**kwargs)
        e_time = time.time()*100000
        result = (True,e_time-s_time,retval)
    except Exception,diag:
        result = (False,str(diag))
    return result

def test():
    funcs = (factorial,fa_reduce,fa_for)
    vals = (12,10,11,900)

    for eachFunc in funcs:
        print "-"*20
        for eachVal in vals:
            retval = timeit(eachFunc,eachVal)
            if retval[0]:
                print '%s(%s) =  ' % (eachFunc.__name__,eachVal),retval[2],'cost time %s' % retval[1]
            else:
                print '%s(%s) = FAILED: ' % (eachFunc.__name__,eachVal),retval[1]

if __name__ =='__main__':
    test()
