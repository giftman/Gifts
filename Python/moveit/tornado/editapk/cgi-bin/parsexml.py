#!/usr/local/bin/python3
from xml.dom import minidom

xmlkey=["isShowTestView","developVersion","productVersion","publishDate","publishDateQuickFight","IS_DEBUG","IS_LOG","QD_Key","QD_Name","QD_Code1","QD_Code2","QD_Use_Logo","QD_Use_Mango_Logo","Partition_Key","Login_Setting_Url","Login_Domain","Backup_Login_Setting_Url","Help_File_Url","Login_Type","isOffical","zone","Gift_Acitvity_Get_Url","Log_Start_Url","Gift_Activity_Name","Gift_Activity_Url","customer_server","gameName"]

def get_attrvalue(node,attrname):
	return node.getAttribute(attrname) if node else ''

def get_nodevalue(node,index = 0):
	return node.childNodes[index].nodeValue if node else ''
def set_nodevalue(node,newValue,index = 0):
	node.childNodes[index].nodeValue = newValue 

def get_xmlnode(node,name):
	return node.getElementsByTagName(name) if node else []

def xml_to_string(doc):
        return doc.toxml('UTF-8')
def xml_write_to_file(dom,filestr):
	with open(filestr,'w') as f:
		f.write(xml_to_string(dom))
def parse_xml(xmlstr):
	configData = {}
	doc = minidom.parse('config.xml')
	for each_key in xmlkey:
		user_nodes = get_xmlnode(root,each_key)
		configData[each_key] = get_nodevalue(user_nodes[0]).encode('utf-8','ignore')
        return configData
