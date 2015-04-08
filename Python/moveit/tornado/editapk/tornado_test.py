import tornado.ioloop
import tornado.web
import zipfile
import os
import shutil

def zip_dir(dirname,zipfilename):
	filelist=[]
	if os.path.isfile(dirname):
		filelist.append(dirname)
	else:
		for root,dirs,files in os.walk(dirname):
			for name in files:
				filelist.append(os.path.join(root,name))
	f = zipfile.ZipFile(zipfilename,'w')
	for tar in filelist:
		arcname = tar[len(dirname):]
		print arcname
		f.write(tar,arcname)
	f.close()

def unzip_apk(apkfilename):
	f = zipfile.ZipFile(apkfilename)
	file_name = apkfilename[:-4]
	f.extractall(file_name)
	f.close()

class MainHandler(tornado.web.RequestHandler):
	def get(self):
		filename = os.path.join(os.path.dirname(__file__),"cbzz_uc.apk")
		print filename
		unzip_apk(filename)
		self.render('index.html')
class WrapHandler(tornado.web.RequestHandler):
	def map_by_first_letters(self,text):
		mapped = dict()
		for line in text.split('\r\n'):
			for word in [x for x in line.split(' ') if len(x) > 0]:
				if word[0] not in mapped: mapped[word[0]] =[]
				mapped[word[0]].append(word)
		return mapped

	def post(self):
		source_text=self.get_argument("source")
		text_to_change=self.get_argument("change")
		source_map=self.map_by_first_letters(source_text)
		change_lines=text_to_change.split('\r\n')
		self.render('munged.html',source_map=source_map,change_lines=change_lines,choice=random.choice)
settings = {
	'template_path':os.path.join(os.path.dirname(__file__),"templates"),
	'static_path':os.path.join(os.path.dirname(__file__),"static"),
	'debug':True,
	}
application = tornado.web.Application([
	(r"/",MainHandler),
	(r"/poem",WrapHandler),
],**settings)

if __name__ == "__main__":
	application.listen(8888)
	tornado.ioloop.IOLoop.instance().start()
