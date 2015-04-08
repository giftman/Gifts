import tornado.ioloop
import tornado.web
import os.path
import random

class MainHandler(tornado.web.RequestHandler):
	def get(self):
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
