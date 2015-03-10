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
	cursor.execute("SELECT id from athletes WHERE name=? AND dob=?",(name,dob))
	the_current_id=cursor.fetchone()[0]
	for each_time in athletes[each_athlete].clean_data:
		cursor.execute("INSERT INTO timing_data(athlete_id,value) VALUES(?,?)",(the_current_id,each_time))
	connection.commit()
connection.close()


