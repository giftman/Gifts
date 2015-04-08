#!/usr/local/bin/python3
import glob
import zipfile
import os
import shutil

keystorestr="cbzr.keystore"
storepass="mango123"
keypass="mango123"
cmd = "jarsigner -keystore {keystorestr} -storepass {storepass} -keypass {keypass} -digestalg SHA1 -sigalg MD5withRSA -signedjar {signedApkFile} {unsignedApkFile} cbzr.keystore"
cmd = cmd.replace("{keystorestr}",keystorestr)
cmd = cmd.replace("{storepass}",storepass)
cmd = cmd.replace("{keypass}",keypass)

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
zip_dir("cbzz_uc","cbzr_uc_test.apk")
cmdshell =cmd
cmdshell = cmdshell.replace("{signedApkFile}","cbzr_uc_test_sign.apk")
cmdshell = cmdshell.replace("{unsignedApkFile}","cbzr_uc_test.apk")
os.system(cmdshell)
# data_files = glob.glob("*.apk")
# for each_file in data_files:
# 	print each_file
# 	file_name = each_file[:-4]
# 	cmdshell =cmd
# 	cmdshell = cmdshell.replace("{signedApkFile}",file_name+"_sign.apk")
# 	cmdshell = cmdshell.replace("{unsignedApkFile}",each_file)
# 	os.system(cmdshell)



