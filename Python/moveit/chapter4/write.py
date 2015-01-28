#!/usr/bin/python
from __future__ import print_function
data = open("filename","a")
print("what have been writed?",file=data)
data.close()
