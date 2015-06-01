#coding  utf-8

def manual_iter():
    with open('/etc/passwd') as f:
        try:
            while True:
                line = next(f)
                print(line)
        except StopIteration:
            pass
def manual_iter2():
    with open('/etc/passwd') as f:
         while True:
            line = next(f)
            if line is None:
                break
            print(line)
manual_iter2()
