import tornado.ioloop
import tornado.web
import textwrap

class MainHandler(tornado.web.RequestHandler):
	def get(self):
		self.write('<html><body><form action="/" method="post">'
			   '<input type="text" name="message">'
			   '<input type="submit" value="Submit">'
			   '</form></body></html>')
	def post(self):
		self.set_header("Content-Type","text/plain")
		self.write("You wrote " + self.get_argument("message"))

class StoryHandler(tornado.web.RequestHandler):
	def get(self,story_id):
		self.write("You requested the story " + story_id)
class ReverseHandler(tornado.web.RequestHandler):
	def get(self,input):
		self.write(input[::-1])
class WrapHandler(tornado.web.RequestHandler):
	def post(self):
		text = self.get_argument('text')
		width = self.get_argument('width',40)
		self.write(textwrap.fill(text,width))
application = tornado.web.Application([
	(r"/",MainHandler),
	(r"/story/([0-9]+)",StoryHandler),
	(r"/reverse/(\w+)",ReverseHandler),
	(r"/wrap",WrapHandler),
])
if __name__ == "__main__":
	application.listen(8888)
	tornado.ioloop.IOLoop.instance().start()
