#gl.py
xmlkey=["isShowTestView","developVersion","productVersion","publishDate","publishDateQuickFight","IS_DEBUG","IS_LOG","QD_Key","QD_Name","QD_Code1","QD_Code2","QD_Use_Logo","QD_Use_Mango_Logo","Partition_Key","Login_Setting_Url","Login_Domain","Backup_Login_Setting_Url","Help_File_Url","Login_Type","isOffical","zone","Gift_Acitvity_Get_Url","Log_Start_Url","Gift_Activity_Name","Gift_Activity_Url","customer_server","gameName"]
apkName=""
apk_directory="tmp"
config_str=apk_directory+"/assets/raw/config.xml"
inputSdk="/mnt/cbzr/SDK/"
output="signed_apk/"
clound="/mnt/cbzr/SDK_sign/"


keystorestr="data/cbzr.keystore"
storepass="mango123"
keypass="mango123"
cmd = "jarsigner -tsa http://timestamp.digicert.com -keystore {keystorestr} -storepass {storepass} -keypass {keypass} -digestalg SHA1 -sigalg MD5withRSA -signedjar {signedApkFile} {unsignedApkFile} cbzr.keystore"
cmd = cmd.replace("{keystorestr}",keystorestr)
cmd = cmd.replace("{storepass}",storepass)
cmd = cmd.replace("{keypass}",keypass)
pngkeys=["icon.png","union_background.jpg"]
replaceFiles=["assets/art/auth/union_background.jpg","res/drawable-hdpi/icon.png","res/drawable-mdpi/icon.png","res/drawable-ldpi/icon.png","assets/raw/config.xml"]
