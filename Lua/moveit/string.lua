--s won't change s's value
s = "[in brackets]"
s = string.sub(s,2,-2)
print(string.char(97,98,99,100))
print(string.byte("abc",-1))
print(string.format("pi = %.4f",3.14))
d = 5; m = 11; y = 1990
print(string.format("%02d/%02d/%04d",d,m,y))
tag,title = "h1","a title"
print(string.format("<%s>%s</%s>",tag,title,tag))


