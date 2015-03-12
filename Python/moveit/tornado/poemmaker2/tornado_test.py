import tornado.ioloop
import tornado.web
import os.path

class MainHandler(tornado.web.RequestHandler):
	def get(self):
		self.render('index.html')
class WrapHandler(tornado.web.RequestHandler):
	def post(self):
		noun1=self.get_argument("noun1")
		noun2=self.get_argument("noun2")
		noun3=self.get_argument("verb")
		noun4=self.get_argument("noun3")
		self.render('poem.html',roads=noun1,wood=noun2,made=noun3,difference=noun4)
settings = {
	'template_path':os.path.join(os.path.dirname(__file__),"templates"),
	}
application = tornado.web.Application([
	(r"/",MainHandler),
	(r"/poem",WrapHandler),
],**settings)
if __name__ == "__main__":
	application.listen(8888)
	tornado.ioloop.IOLoop.instance().start()
