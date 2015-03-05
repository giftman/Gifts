#!/usr/local/bin/python3
import athletemodel
import yate
import json
import cgi

athletes = athletemodel.get_from_store()
form_data = cgi.FieldStorage()
athlete_name = form_data['which_athlete'].value
print(yate.start_response('application/json'))
print(json.dumps(athletes[athlete_name].to_dict))
