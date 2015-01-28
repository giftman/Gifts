#!/usr/bin/python
from __future__ import print_function
import sys
def print_lol(the_list,indent=False,level=0,output=sys.stdout):
	for _list in the_list:
		if isinstance(_list,list):
			print_lol(_list,indent,level + 1,output)
		else:
			if indent:
				for num_ in range(level):
					print('\t',end="",file=output)
			print(_list,file=output)
