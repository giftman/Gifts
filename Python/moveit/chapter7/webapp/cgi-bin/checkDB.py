#!/usr/local/bin/python3
import sqlite3
import athletemodel
import yate

connection = sqlite3.connect('coachdata.sqlite')
cursor = connection.cursor()
cursor.execute("SELECT name,id from athletes")
the_current_id=cursor.fetchall()
print(the_current_id)
connection.commit()
connection.close()


