#!/usr/bin/env python
o_content = open('teststrip.txt')
f_content = map(lambda x:x.strip(),o_content)
p_input = raw_input("enter new or Enter overite")
newfn = 'teststrip.txt'
if p_input != '':
    newfn = p_input.strip()
f  = open (newfn,'w')
for eachlien in f_content:
    f.write(eachlien)
    f.write('\n')
    print(eachlien)
f.close()
