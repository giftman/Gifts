#coding  utf-8
#只是去掉前面有"的
from itertools import dropwhile
with open('/root/.vimrc') as f:
    for line in dropwhile(lambda line:line.startswith('"'),f):
        print(line,end='')

from itertools import islice
items = ['a','b','c',1,4,10,15]
for x in islice(items,3,None):
    print(x)

#过滤掉所有以"开头的
with open('/root/.vimrc') as f:
    lines = (line for line in f if not line.startswith('"'))
    for line in lines:
        print(line,end='')

