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
class Athlete:
	def __init__ (self,a_name,a_dob=None,a_time=[]):
		self.name=a_name
		self.dob=a_dob
		self.time=a_time
	def gettop3(self):
		return(sorted(set([sanitize(data) for data in self.time]))[0:3])
	def add_time(self,new_time):
		self.time.append(new_time)
	def add_times(self,new_time):
		self.time.extend(new_time)

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

for name in names:
	people = get_coach_data(name + ".txt")
	people.append('2.00') 
	people.extend(['2.00','1.1'])
	print(people.name + "'s fastest times are: " + str(people.top3()))
