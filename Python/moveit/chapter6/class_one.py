#!/usr/bin/python
from __future__ import print_function
class Athelete:
	def __init__(self,a_name,a_dob=None,a_time=[]):
		self.name=a_name
		self.dob=a_dob
		self.time=a_time
sarah=Athelete('Sarah Sweeney','2002-6-17',['2.4','2.58','1.56'])
james=Athelete('James Jones')
type(sarah)
type(james)
sarah
james
print(sarah.name)
