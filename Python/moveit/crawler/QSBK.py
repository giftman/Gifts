#!/usr/bin/python
# -*- coding:utf-8 -*-
import urllib
import urllib2
import re
import thread
import time

class QSBK:
	def __init__(self):
		self.pageIndex=1
		self.user_agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.104 Safari/537.36'
		self.headers={'User-Agent':self.user_agent}
		self.stories = []
		self.enable=False
	def getPage(self,pageIndex):
		try:
			url="http://www.qiushibaike.com/hot/page/" + str(pageIndex)
			request = urllib2.Request(url,headers=self.headers)
			response = urllib2.urlopen(request)
			content=response.read().decode('utf-8')
			return content
		except urllib2.URLError,e:
			if hasattr(e,"code"):
				print e.code
			if hasattr(e,"reason"):
				print e.reason
	def getPageItems(self,pageIndex):
		pageCode = self.getPage(pageIndex)
		if not pageCode:
			print "load error.."
			return None
		pattern = re.compile('<div class="content">([\s\S]+?)<\/div>',re.S)
    		items = re.findall(pattern,pageCode)
		pageStories = []
		for item in items:
			pageStories.append(item)
		return pageStories
	def loadPage(self):
		if self.enable == True:
			while len(self.stories)<2:
				pageStories = self.getPageItems(self.pageIndex)
				if pageStories:
					self.stories.append(pageStories)
					self.pageIndex +=1
	def getOneStory(self,pageStories,page):
		for story in pageStories:
			input = raw_input()
			self.loadPage()
			if input == "Q":
				self.enable = False
				return
			print u"第%d页%s\n" %(page,story)
	def start(self):
		self.enable = True
		self.loadPage()
		nowPage = 0
		import pdb
		pdb.set_trace()
		while self.enable:
			if len(self.stories)>0:
				pageStories = self.stories[0]
				nowPage +=1
				del self.stories[0]
				self.getOneStory(pageStories,nowPage)
spider = QSBK()
spider.start()
