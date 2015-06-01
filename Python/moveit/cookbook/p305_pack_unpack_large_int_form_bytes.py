#coding  utf-8

#bytes ---> int
data = b'\x00\x124V\x00x\x90\xab\x00\xcd\xef\x01\x00#\x004'
x = int.from_bytes(data,'big')
print(x)
#int ---> bytes
print(x.to_bytes(16,'big'))
#too big can't convert  find the right length first
x = 523**23
nbytes,rem = divmod(x.bit_length(),8)
if rem:
    nbytes +=1
print(x.to_bytes(nbytes,'big'))

