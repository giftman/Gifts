#!/usr/local/bin/python3
import sqlite3
import athletemodel
import yate
import glob

data_files = glob.glob("../data/*.txt")
athletes = athletemodel.put_to_store(data_files)

connection = sqlite3.connect('coachdata.sqlite')
cursor = connection.cursor()
for each_athlete in athletes:
	name = athletes[each_athlete].name
	dob = athletes[each_athlete].dob
	cursor.execute("INSERT INTO athletes(name,dob) VALUES(?,?)",(name,dob))
	connection.commit()
connection.close()


