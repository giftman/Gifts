#coding  utf-8
import os
import fnmatch
import gzip
import re

def gen_find(filepat,top):
    for path,dirlist,filelist in os.walk(top):
        for name in fnmatch.filter(filelist,filepat):
            yield os.path.join(path,name)

def gen_opener(filenames):
    for filename in filenames:
        if filename.endswith('.gz'):
            f=gzip.open(filename,'rt')
        else:
            f = open(filename,'rt')
        yield f
        f.close()
def gen_concatenate(iterators):
    for it in iterators:
        yield from it

def gen_grep(pattern,lines):
    pat = re.compile(pattern)
    for line in lines:
        if pat.search(line):
            yield line

lognames = gen_find("testdata",".")
files = gen_opener(lognames)
lines = gen_concatenate(files)
bytecolumn = (line.rsplit(None,1)[1] for line in lines)
m_bytes = (int(x) for x in bytecolumn if x != '-')
for line in bytecolumn:
    print(line)

