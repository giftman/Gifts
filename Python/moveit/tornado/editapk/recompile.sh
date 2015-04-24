#/usr/bin
#1 apk 2 packageName 3versionCode 4 VersionName 5newapkName
apktool d $1 ./testapk
sed -i  -e "s%versionCode=\"\S*\" android%versionCode=\"$3\" android%g"  -e "s%versionName=\"\S*\" %versionName=\"$4\" %g" -e "s%package=\"\S*\"%package=\"$2\"%g" ./testapk/AndroidManifest.xml
apktool b testapk $5
cat ./testapk/AndroidManifest.xml
rm -rf ./testapk
