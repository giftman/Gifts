#coding  utf-8
#拼接字符串
parts = ['Is','Chicago','Not','Chicago?']
print(' '.join(parts))
def sample():
    yield 'Is'
    yield 'Chicago'
    yield 'Not'
    yield 'Chicago?'
i=0
for part in sample():
    print( str(i) + part)
    i+=1
