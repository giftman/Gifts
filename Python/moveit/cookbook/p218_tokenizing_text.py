#coding  utf-8
#format format_map
#把一字符串 分析 为 字典  token   scanner
text = 'foo=23+42*10'
import re
NAME = r'(?P<NAME>[a-zA-Z][a-zA-Z_0-9]*)'
NUM = r'(?P<NUM>\d+)'
PLUS = r'(?P<PLUS>\+)'
TIMES = r'(?P<TIMES>\*)'
EQ = r'(?P<EQ>=)'
WS = r'(?P<WS>\s+)'

master_pat = re.compile('|'.join([NAME,NUM,PLUS,TIMES,EQ,WS]))

def generator_tokens(pat,text):
    from collections import namedtuple
    Token = namedtuple('Token',['type','value'])
    scanner = pat.scanner(text)
    for m in iter(scanner.match,None):
        yield Token(m.lastgroup,m.group())

for tok in generator_tokens(master_pat,text):
    print(tok.type,tok.value)


