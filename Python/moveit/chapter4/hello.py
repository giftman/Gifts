#!/usr/bin/python
from __future__ import print_function
import giftman_nester
import pickle
man=[]
other=[]
try:
	data=open("sketch.txt")
	for each_line in data:
		try:
			(role,line_spoken) = each_line.split(":")
			line_spoken = line_spoken.strip()
			if role == 'Man':
				man.append(line_spoken)
			elif role == 'Other Man':
				other.append(line_spoken)
		except ValueError:
			pass
	data.close()
except IOError:
	print('The datafile is missing')
#try:
#	man_data = open("man_data.txt","w")
#	print(man,file=man_data)
#	other_data = open("other_data.txt","w")
#	print(other,file=other_data)
#except IOError:
#	print('The datafile is missing')
#finally:
#	if 'man_file' in locals():
#		man_data.close()
#	if 'other_file' in locals():
#		other_data.close()

#try:
#	with open("man_data.txt","w") as man_data:
#		giftman_nester.print_lol(man,man_data)
#	with open("other_data.txt","w") as other_data:
#		giftman_nester.print_lol(other,other_data)
#except IOError as err:
#	print('The datafile is missing' + str(err))

try:
	with open("man_data.txt","wb") as man_data:
		pickle.dump(man,man_data)
	with open("other_data.txt","wb") as other_data:
		pickle.dump(other,other_data)
except PickleError as err:
	print('The datafile is missing' + str(err))
except IOError as err:
	print('The datafile is missing' + str(err))
