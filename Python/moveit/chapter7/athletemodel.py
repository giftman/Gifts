#!/usr/bin/python
from __future__ import print_function
import pickle
names = ["james2","julie2","mikey2","sarah2"]
def sanitize(time_string):
	if '-' in time_string:
		splitter = '-'
	elif ':' in time_string:
		splitter = ':'
	else:
		return(time_string)
	(mins,secs) = time_string.split(splitter)
	return(mins + '.' + secs)
class AthleteList(list):
	def __init__(self,a_name,a_dob=None,a_times=[]):
		list.__init__([])
		self.name=a_name
		self.dob=a_dob
		self.extend(a_times)
	def top3(self):
		return(sorted(set([sanitize(data) for data in self]))[0:3])
		

def get_coach_data(filename):
	try:
		with open(filename) as jsf: 
			data = jsf.readline()
			datas = data.strip().split(',')
		return(AthleteList(datas.pop(0),datas.pop(0),datas))
	except IOError as ioerr:
		print('File error:' + str(ioerr))
		return (None)
def put_to_store(files_list):
	all_athletes = {}
	for name in files_list:
		data = get_coach_data(name + ".txt")
		all_athletes[name]=data
	try:
		with open("man_data.txt","wb") as man_data:
			pickle.dump(all_athletes,man_data)
	except PickleError as err:
		print('The datafile is missing' + str(err))
	except IOError as err:
		print('The datafile is missing' + str(err))
	return(all_athletes)

def get_from_store():
	all_athletes={}
	try:
		all_athletes = pickle.load("man_data.txt")
	except PickleError as err:
		print('The datafile is missing' + str(err))
	except IOError as err:
		print('The datafile is missing' + str(err))
	return(all_athletes)
