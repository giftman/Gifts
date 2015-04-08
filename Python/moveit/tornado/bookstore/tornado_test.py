import tornado.ioloop
import tornado.web
import os.path
import random

class MainHandler(tornado.web.RequestHandler):
	def get(self):
		self.render('index.html',
		page_title = "Burt's Books | Home",
		header_text = "Welcome to Burt's Books!",
		# footer_text = "Welcome to Burt's Books!",
		)
class BookModule(tornado.web.UIModule):
	def render(self,book):
		return self.render_string('modules/book.html',book=book)
	def css_files(self):
		return "css/recommended.css"
	
	def javascript_files(self):
		return "js/recommended.js"
class RecommendedHandler(tornado.web.RequestHandler):
	def get(self):
		self.render(
			"recommended.html",
			page_title = "Burt's Books | Recommended Reading",
			header_text = "Recommended Reading",
			books=[
				{
					"title":"Programming Collective Intelligence",
					"subtitle": "Building Smart Web 2.0 Applications",
					"image":"/static/images/collective_intelligence.gif",
					"author": "Toby Segaran",
					"date_added":1310248056,
					"date_released": "August 2007",
					"isbn":"978-0-596-52932-1",
					"description":"<p>This fascinating book demonstrates how you can build web applications to mine the enormous amount of data created by people on the Internet. With the sophisticated algorithms in this book, you can write smart programs to access interesting datasets from other web sites, collect data from users of your own applications, and analyze and understand the data once you've found it.</p>"
				},
				{
					"title":"RESTful Web Services",
					"subtitle": "Web services for the real world",
					"image":"/static/images/restful_web_services.gif",
					"author": "Leonard Richardson, Sam Ruby",
					"date_added":1311148056,
					"date_released": "May 2007",
					"isbn":"978-0-596-52926-0",
					"description":"<p>You've built web sites that can be used by humans. But can you also build web sites that are usable by machines? That's where the future lies, and that's what this book shows you how to do. Today's web service technologies have lost sight of the simplicity that made the Web successful. This book explains how to put the &quot;Web&quot; back into web services with REST, the architectural style that drives the Web.</p>"
				},
				{
					"title":"Head First Python",
					"subtitle": "",
					"image":"/static/images/head_first_python.gif",
					"author": "Paul Barry",
					"date_added":1311348056,
					"date_released": "November 2010",
					"isbn":"Head First Python",
					"description":"<p>Ever wished you could learn Python from a book? Head First Python is a complete learning experience for Python that helps you learn the language through a unique method that goes beyond syntax and how-to manuals, helping you understand how to be a great Python programmer. You'll quickly learn the language's fundamentals, then move onto persistence, exception handling, web development, SQLite, data wrangling, and Google App Engine. You'll also learn how to write mobile apps for Android, all thanks to the power that Python gives you.</p>"
				}
			]
		)
settings = dict(
	template_path=os.path.join(os.path.dirname(__file__),"templates"),
	static_path=os.path.join(os.path.dirname(__file__),"static"),
	ui_modules={"Book":BookModule},
	debug=True,
	)
application = tornado.web.Application([
	(r"/",MainHandler),
	(r"/recommended/",RecommendedHandler),
],**settings)
if __name__ == "__main__":
	application.listen(8888)
	tornado.ioloop.IOLoop.instance().start()
