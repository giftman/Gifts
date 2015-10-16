#!/usr/bin/env python

import sys

def usage():
    print 'At least 2 arguments (incl. cmd name).'
    print 'usage: args.py arg1 arg2 [arg3...]'
    sys.exit(1)

argc=len(sys.argv)
if argc < 3:
    usage()

print 'number of args enter:',argc
print 'args(incl. cmd name) were:',sys.argv
