#coding  utf-8

from collections import deque

class linehistory:
    def __init__(self,lines,histlen=3):
        self.lines = lines
        self.history=deque(maxlen = histlen)

    def __iter__(self):
        for lineno,line in enumerate(self.lines,1):
            self.history.append((lineno,line))
            yield line

    def clear(self):
        self.history.clear()

with open('/etc/passwd') as f:
    lines = linehistory(f)
    for line in lines:
        if 'gopher' in line:
            for lineno,line in lines.history:
                print('{}:{}'.format(lineno,line))

#这个太绕了吧，history 记录了每一行，只是它最长就3
#每次__iter__ 就返回一行line: 因为你要的是即要这行也要这行前面的数据，即本次说的额外的内容
