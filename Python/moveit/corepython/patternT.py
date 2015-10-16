#!/user/bin/python
import re

lien = '<public type="id" name="world_btinvest_cacle" id="0x7f0916b4" />'
line = '.field public static final tv_btn_install_appchina:I = 0x7f070008'
pattern = re.compile(r'.*name="(\w*)" +id="(\w*)".*')
rpattern = re.compile(r'.*final (\w*)\:I = (\w*)')
m = rpattern.match(line)
if(m):
    print "OKOK"
    print(m.group(0))
