#coding  utf-8
import os.path

def read_into_buffer(filename):
    buf = bytearray(os.path.getsize(filename))
    with open(filename,'rb') as f:
        f.readinto(buf)
    return buf

#with open('testfile.bin','wb') as f:
#    f.write(b'Hello World')
#with open('testfile.bin','rb') as f:
#    data = f.read()
#    text = data.decode('utf-8')
#    print(text)

with open('sample.bin','wb') as f:
    f.write(b'Hello World')
buf = read_into_buffer('sample.bin')
print(buf)
buf[0:5] = b'Hallo'
print(buf)
with open('newsample.bin','wb') as f:
    f.write(buf)

record_size = 32
buf = bytearray(record_size)
with open('somefile','rb') as f:
    while True:
        n = f.readinto(buf)
        if n < record_size:
            break
        #use the content of buf

