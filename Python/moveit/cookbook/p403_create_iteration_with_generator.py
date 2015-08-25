#coding  utf-8

def frange(start,stop,increment):
    x=start
    print('Starting to count from',x)
    while x < stop:
        print('Before yield',x)
        yield x
        x += increment
        print('After yield',x)

c = frange(0,4,0.5)
print(next(c))
print(next(c))
