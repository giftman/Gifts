#coding:utf-8
import tornado.ioloop
import tornado.httpserver
import tornado.web
import zipfile
import os
import shutil
from shutil import copy
import gl
from xml.dom import minidom
import fnmatch
 
def iterfindfiles(path, fnexp):
	for root, dirs, files in os.walk(path):
		for filename in fnmatch.filter(files, fnexp):
			yield os.path.join(root, filename)

def zip_dir(dirname,zipfilename):
	filelist=[]
	if os.path.isfile(dirname):
		filelist.append(dirname)
	else:
		for root,dirs,files in os.walk(dirname):
			for name in files:
				filelist.append(os.path.join(root,name))
	f = zipfile.ZipFile(zipfilename,'w',zipfile.ZIP_DEFLATED)
	for tar in filelist:
		arcname = tar[len(dirname):]
		print arcname
		f.write(tar,arcname)
	f.close()

def unzip_apk(apkfilename):
	f = zipfile.ZipFile(apkfilename)
	gl.apkName= os.path.basename(apkfilename)
	file_name = gl.apkName[:-4]
	print file_name
	gl.apk_directory="static/tmp/"+ file_name
	print gl.apk_directory
	gl.config_str=gl.apk_directory+"/assets/raw/config.xml"
	del_folder(gl.apk_directory)
	# f.extractall(gl.apk_directory)
	for replaceFile in gl.replaceFiles:
		f.extract(replaceFile,gl.apk_directory)
	f.close()
	copy(gl.apk_directory + "/res/drawable-hdpi/icon.png","static/images/")
	copy(gl.apk_directory + "/assets/art/auth/union_background.jpg","static/images/")

def get_attrvalue(node,attrname):
	return node.getAttribute(attrname) if node else ''

def get_nodevalue(node,index = 0):
	return node.childNodes[index].nodeValue if node else ''
def set_nodevalue(node,newValue,index = 0):
	node.childNodes[index].nodeValue = newValue 

def apkRemove(apkFile,removeFile):
	rmcmd = "aapt remove {apkFile} {removeFile}"
	rmcmd = rmcmd.replace("{apkFile}",apkFile)
	rmcmd = rmcmd.replace("{removeFile}",removeFile)
	print rmcmd
	os.system(rmcmd)
def apkAdd(apkFile,removeFile):
	rmcmd = "aapt add {apkFile} {removeFile}"
	rmcmd = rmcmd.replace("{apkFile}",apkFile)
	rmcmd = rmcmd.replace("{removeFile}",removeFile)
	print rmcmd
	os.system(rmcmd)
def signApk(apkFile,outputFile):
	cmdshell =gl.cmd
	cmdshell = cmdshell.replace("{unsignedApkFile}",apkFile)
	cmdshell = cmdshell.replace("{signedApkFile}",outputFile)
	print "执行签名"
	os.system(cmdshell)
def zipAlign(apkFile,outputFile):
	cmdshell ="zipalign -f 4 {signedApkFile} {zipalignApkFile}"
	cmdshell = cmdshell.replace("{signedApkFile}",apkFile)
	cmdshell = cmdshell.replace("{zipalignApkFile}",outputFile)
	print "执行zipalign"
	os.system(cmdshell)

def get_xmlnode(node,name):
	return node.getElementsByTagName(name) if node else []

def xml_to_string(doc):
	return doc.toxml('UTF-8')
def xml_write_to_file(dom,filestr):
	with open(filestr,'w') as f:
		f.write(xml_to_string(dom))
def parse_xml(xmlstr):
	configData = {}
	doc = minidom.parse(xmlstr)
	root = doc.documentElement
	for each_key in gl.xmlkey:
		user_nodes = get_xmlnode(root,each_key)
		configData[each_key] = get_nodevalue(user_nodes[0]).encode('utf-8','ignore')
	return configData
def zip_file_and_sign():
	apkstr = gl.apk_directory + "/" +gl.apkName
	copy(gl.inputSdk + gl.apkName,apkstr)
	for replaceFile in gl.replaceFiles:
		apkRemove(apkstr,replaceFile)
		
	apkRemove(apkstr,"META-INF/CERT.RSA")
	apkRemove(apkstr,"META-INF/CERT.SF")
	apkRemove(apkstr,"META-INF/MANIFEST.MF")

	presentStr = os.getcwd()
	os.chdir(gl.apk_directory)
	for replaceFile in gl.replaceFiles:
		apkAdd(gl.apkName,replaceFile)
	os.chdir(presentStr)

	signApk(apkstr,gl.output + "sign_" +gl.apkName)
	zipAlign(gl.output + "sign_" +gl.apkName,apkstr)
	copy(apkstr,gl.clound + "sign_" + gl.apkName)
	del_folder(gl.apk_directory)
def del_folder(fileName):
	if os.path.exists(fileName):
		shutil.rmtree(fileName)
		print "rm " + fileName

class UploadHandler(tornado.web.RequestHandler):
	def get(self):
		import glob
		names = glob.glob(gl.inputSdk +"*.apk")
		self.render('choosefile.html',names=names)
class MainHandler(tornado.web.RequestHandler):
	def get(self):
		fileid = self.get_argument("id")
		filename = os.path.join(fileid)
		unzip_apk(filename)
		configData = parse_xml(gl.config_str)
		self.render('index.html',configData=configData,xmlkey=gl.xmlkey)
	def post(self):
	#文件的暂存路径
		upload_path=os.path.join(os.path.dirname(__file__),'static/images')  
		for pngkey in gl.pngkeys:
	        	#提取表单中‘name’为‘file’的文件元数据
			file_metas=self.request.files[pngkey[:-4]]    
			filepath=""
	        	for meta in file_metas:
	        		filename=meta['filename']
	        		print filename
	        		filepath=os.path.join(upload_path,pngkey)
 	         		#有些文件需要已二进制的形式存储，实际中可以更改
	        		with open(filepath,'wb') as up:      
					up.write(meta['body'])
			for filename in iterfindfiles(gl.apk_directory,pngkey):
				print filename
				copy(filepath,filename)
				print "copy:"+ filepath + "to:" +filename
		configData = parse_xml(gl.config_str)
		self.render('index.html',configData=configData,xmlkey=gl.xmlkey)
class WrapHandler(tornado.web.RequestHandler):
	def post(self):
		doc = minidom.parse(gl.config_str)
		root = doc.documentElement
		for each_key in gl.xmlkey:
			user_nodes = get_xmlnode(root,each_key)
			set_nodevalue(user_nodes[0],self.get_argument(each_key))
		xml_write_to_file(doc,gl.config_str)	
		zip_file_and_sign()
		self.render('package_result.html')
settings = {
		'template_path':os.path.join(os.path.dirname(__file__),"templates"),
		'static_path':os.path.join(os.path.dirname(__file__),"static"),
		'debug':True,
		}
application = tornado.web.Application([
	(r"/",UploadHandler),
	(r"/config",MainHandler),
	(r"/poem",WrapHandler),
	(r"/(.*\.png)", tornado.web.StaticFileHandler, dict(path=settings['static_path'])),
	],**settings)

if __name__ == "__main__":
	sockets = tornado.netutil.bind_sockets(8888)
	# tornado.process.fork_processes(5)                          #不同逻辑阻塞时不同ip可以分到不同进程
	server = tornado.httpserver.HTTPServer(application, xheaders=True)
	server.add_sockets(sockets)
	tornado.ioloop.IOLoop.instance().start()
