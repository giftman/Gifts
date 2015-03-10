#!/usr/local/bin/python3
import athletemodel
import yate
import cgi
import cgitb
cgitb.enable()
form_data = cgi.FieldStorage()
athlete_id = form_data['which_athlete'].value
athlete = athletemodel.get_athlete_from_id(athlete_id)

print(yate.start_response())
print(yate.include_header("Coach Kelly's Timing Data"))
print(yate.header("Athlete:" + athlete['Name'] + ",DOB:" + athlete['DOB'] + "."))

print(yate.para("The times for this athlete are:"))
print(yate.u_list(athlete['top3']))
print(yate.para("The entire set of timing data is: " + str(athlete['data']) + "(duplicates removed)."))

print(yate.include_footer({"Home":"/index.html","Choose":"generate_list.py"}))

