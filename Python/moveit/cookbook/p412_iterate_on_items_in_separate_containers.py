#coding  utf-8
#iterate on different items
from itertools import chain
active_items = set()
in_active_items = set()

for item in chain(active_items,in_active_items):
    #do your jon
    print(item)


