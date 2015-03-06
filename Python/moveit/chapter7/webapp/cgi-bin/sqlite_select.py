#!/usr/local/bin/python3
import sqlite3

connection = sqlite3.connect('coachdata.sqlite')
cursor = connection.cursor()
cursor.execute(SELECT id from athletes WHERE name=? AND dob=?",(name,dob))
the_current_id = cursor.fetchone()[0] 
connection.commit()
connection.close()
print(the_current_id)


