#!/usr/bin/python
import re

#pattern = r'.*<uses-permission.*'
patternP = r'.*<permissionCfg>([^^]*)</permissionCfg>'
patternA = r'.*<applicationCfg>([^^]*)</applicationCfg>'
with open("ForManifest.xml") as f:
    content = f.read()
    #comment = re.compile(r'<permissionCfg>(.*)<permissionCfg>')
    permissions = re.findall(patternP,content)
    activities = re.findall(patternA,content)
    print(permissions[0])
    print(activities[0])
fp = open("AndroidManifest.xml",'r')
np = open("AndroidManifest1.xml",'w')
for eachline in fp:
    if 'INTERNET' in eachline:
        eachline = eachline + permissions[0]
    if '</application>' in eachline:
        eachline = activities[0] + eachline
    np.write(eachline)




