#!/usr/bin/python
"""This is the standard way to include a multiple-line comment in your code."""
def print_lol(the_list):
	for _list in the_list:
		if isinstance(_list,list):
			print_lol(_list)
		else:
			print(_list)
