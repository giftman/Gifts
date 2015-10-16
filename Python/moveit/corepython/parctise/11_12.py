#!/usr/bin/env python
import time
def testit(func,*nkwargs,**kwargs):
    try:
        retval = func(*nkwargs,**kwargs)
        result = (True,retval)
    except Exception,diag:
        result = (False,str(diag))
    return result
def timeit(func,*nkwargs,**kwargs):
    try:
        s_time = time.time()
        retval = func(*nkwargs,**kwargs)
        e_time = time.time()
        result = (True,e_time-s_time,retval)
    except Exception,diag:
        result = (False,str(diag))
    return result

def test():
    funcs = (int,long,float)
    vals = (1234,12.34,'1234','12.34')

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
