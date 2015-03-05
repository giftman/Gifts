#!/usr/local/bin/python3
import athletemodel
import yate
import json

names = athletemodel.get_names_from_store()
print(yate.start_response('application/json'))
print(json.dumps(sorted(names)))
