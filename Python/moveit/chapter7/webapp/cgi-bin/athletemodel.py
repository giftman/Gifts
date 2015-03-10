#!/usr/local/bin/python3
import os
import sqlite3
db_name = 'coachdata.sqlite'
import sys
print(__file__)
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
	@property
	def clean_data(self):
		return(sorted(set([sanitize(t) for t in self])))
		

def get_coach_data(filename):
	try:
		with open(filename) as jsf: 
			data = jsf.readline()
			datas = data.strip().split(',')
		return(AthleteList(datas.pop(0),datas.pop(0),datas))
	except IOError as ioerr:
		print('File error:' + str(ioerr))
		return (None)
def get_namesID_from_store():
	connection = sqlite3.connect('coachdata.sqlite')
	cursor = connection.cursor()
	cursor.execute("""SELECT name,id FROM athletes""")
	response = cursor.fetchall()
	connection.close()
	return(response)
def get_athlete_from_id(athlete_id):
	connection = sqlite3.connect(db_name)
	cursor = connection.cursor()
	results = cursor.execute("""SELECT name, dob FROM athletes WHERE id=?""",(athlete_id,))
	(name,dob)=results.fetchone()
	results = cursor.execute("""SELECT value FROM timing_data WHERE athlete_id=?""",(athlete_id,))
	data = [row[0] for row in results.fetchall()]
	response = {'Name':name,
		    'DOB' :dob,
		    'data':data,
		    'top3':data[0:3]}
	connection.close()
	return(response)
