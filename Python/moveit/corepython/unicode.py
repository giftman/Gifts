#!/usr/bin/env python

CODEC = "UTF-8"
FILENAME="unicode.txt"

Content = u'Hello f'
encode_text = Content.encode(CODEC)

f = open(FILENAME,'w')
f.write(encode_text)
f.close()

f = open(FILENAME,'r')
r_bytes = f.read()
f.close()
decode_text = r_bytes.decode(CODEC)
print(decode_text)
