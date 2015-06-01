#coding  utf-8
#format format_map
s = '{name} has {n} message.'
print(s.format(name='CCCFFF',n=21))

name = 'Guido'
n=77
print(s.format_map(vars()))

class safesub(dict):

    def __missing__(self,key):
        return '{' + key +'}'

del n
print(s.format_map(safesub(vars())))


import sys

def sub(text):
    return text.format_map(safesub(sys._getframe(1).f_locals))

print(sub('Hello {name}'))
