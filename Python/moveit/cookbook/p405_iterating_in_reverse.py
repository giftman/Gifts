#coding  utf-8

class Countdown:
    def __init__(self,start):
        self._start=start

    def __iter__(self):
        n = self._start
        while n>0:
            yield n
            n -= 1

    def __reversed__(self):
        n = 1
        while n < self._start:
            yield n
            n += 1

for n in Countdown(30):
    print(n)

for n in reversed(Countdown(30)):
    print(n)


