#!/usr/bin/python
from __future__ import print_function
import pickle
names = ["james","julie","mikey","sarah"]
def sanitize(time_string):
	if '-' in time_string:
		splitter = '-'
	elif ':' in time_string:
		splitter = ':'
	else:
		return(time_string)
	(mins,secs) = time_string.split(splitter)
	return(mins + '.' + secs)

def get_coach_data(filename):
	try:
		with open(filename) as jsf: 
			data = jsf.readline()
		return(data.strip().split(','))	
	except IOError as ioerr:
		print('File error:' + str(ioerr))
		return (None)

for name in names:
	datas = get_coach_data(name + ".txt")
	print(sorted(set([sanitize(data) for data in datas]))[0:3])
