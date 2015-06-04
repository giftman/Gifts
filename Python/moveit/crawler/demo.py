#!/usr/bin/python
#2.6
#import urllib2
#response=urllib2.urlopen("http://www.baidu.com")
#print response.read()

#import urllib
#import urllib2
#values = {"username":"121552591@qq.com","password":""}
#headers = {'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','Referer':'http://www.zhihu.com/articles'}
#
#url="https://passport.csdn.net/account/login"
#data = urllib.urlencode(values)
#request = urllib2.Request(url,data)
#try:
#	response = urllib2.urlopen(request)
#except urllib2.URLError,e:
#	if hasattr(e,"code"):
#		print e.code
#	if hasattr(e,"reason"):
#		print e.reason
#else:
#	print "OK"

#####cookie#####
#import urllib2
#import cookielib
###
##cookie = cookielib.CookieJar()
##save to file
##cookie = cookielib.MozillaCookieJar('cookie.txt')
##read from file
#cookie = cookielib.MozillaCookieJar()
#cookie.load('cookie.txt',ignore_discard=True,ignore_expires=True)
#handler = urllib2.HTTPCookieProcessor(cookie)
#opener = urllib2.build_opener(handler)
#response = opener.open('http://www.baidu.com')
#print response.read()

import urllib
import urllib2
import re
headers = {'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36','Referer':'http://www.zhihu.com/articles'}

page = 1
url="http://www.qiushibaike.com/hot/page/" + str(page)
request = urllib2.Request(url,headers=headers)
try:
	response = urllib2.urlopen(request)
	content=response.read().decode('utf-8')
	pattern = re.compile('<div class="content">([\s\S]+?)<\/div>',re.S)
    	items = re.findall(pattern,content)
	for item in items:
        	haveImg = re.search("img",item[3])
        	if not haveImg:
        	    print item
except urllib2.URLError,e:
	if hasattr(e,"code"):
		print e.code
	if hasattr(e,"reason"):
		print e.reason
