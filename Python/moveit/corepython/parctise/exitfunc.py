#!/usr/bin/python

import sys
prev_exit_func = getattr(sys,'exitfunc',None)

def my_exit_func(old_exit = prev_exit_func):
    print 'clean function data'

    if old_exit is not None and callable(old_exit):
        old_exit()

sys.exitfunc = my_exit_func
