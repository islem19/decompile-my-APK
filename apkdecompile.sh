#!/bin/bash
# 
# Credits: 
# Dex2Jar - Google
# JD-Cli
# Apktool


# Yelp O.O
help_menu(){
    echo "$(basename "$0") - Yelp Menu!"
    echo " "
    echo "$(basename "$0") [APK path] [OPTION] -- a command line tool to decompile your APK instantly"
    echo " "
    echo "OPTION:"
    echo "-o, --output               Specify the path of the output directory"
    echo "-h, --help                 Prints Yelp Menu!"
    echo "-v, --version              Prints the version number." 
    echo "BY -Abdelkader Sellami- https://github.com/islem19 "
}
export DEPENDENCIES=$HOME"/.dependencies"
SCRIPT_VER="V1.0.0"
FILE_PATH=${1}
FILE_NAME=$(echo "${1##*/}" | cut -f 1 -d '.')
EXTENSION=${1##*.}
OUTDIR="${PWD}/${FILE_NAME}_decompiled"
TMP=$(mktemp)

# Check if a valid APK file is included
if [ "$EXTENSION" != "apk" ]; then
   echo "E: No APK file found, Sorry :("
	help_menu
	exit 1;
fi;

while [ "$#" -gt 0 ]; do
           case "$1" in
                -h | --help)
                   help_menu
                   exit 0
                   ;;
                -v | --version)
                   echo ${SCRIPT_VER}
                   exit 0
                   ;;
                -o | --output)
                    shift
                    OUTDIR="${1}/${FILE_NAME}_decompiled"
                    break
                    ;;
                *)
                   shift
                   ;;
           esac
done
echo "Apkdecompile v1.0.0 - a command line tool to decompile your APK instantly"
echo "I: Checking for dependencies..."
which $DEPENDENCIES/apktool $DEPENDENCIES/jd-cli 7za $DEPENDENCIES/dex-tools-2.1-SNAPSHOT/d2j-dex2jar.sh &> /dev/null
if [ $? = 1 ]; then 
	echo "I: Installing required dependencies..."
	mkdir -p ${DEPENDENCIES}
	sudo apt-get install p7zip unzip wget -y
	echo "I: Downloading Dex2Jar..."
	wget -qP ${TMP} https://github.com/pxb1988/dex2jar/files/1867564/dex-tools-2.1-SNAPSHOT.zip
	unzip -o ${TMP}/dex-tools-2.1-SNAPSHOT.zip -d ${DEPENDENCIES}
	chmod a+x ${DEPENDENCIES}/dex-tools-2.1-SNAPSHOT/*
	echo "I: Downloading JD-cli..."
	wget -qP ${TMP} https://github.com/kwart/jd-cmd/releases/download/jd-cmd-1.0.1.Final/jd-cli-1.0.1.Final-dist.zip
	unzip -o ${TMP}/jd-cli-1.0.1.Final-dist.zip -d ${DEPENDENCIES}
	chmod a+x ${DEPENDENCIES}/jd-cli
   echo "I: Downloading Apktool..."
   wget -q https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -O "${DEPENDENCIES}/apktool"
   chmod a+x ${DEPENDENCIES}/apktool
   wget -q https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.4.1.jar -O "${DEPENDENCIES}/apktool.jar"
   chmod a+x ${DEPENDENCIES}/apktool.jar
	echo "I: DONE...:)"
fi;

echo "I: Start decompiling the APK..."
mkdir -p ${OUTDIR} 
echo "I: Decompiling The Manifest and Resources"
${DEPENDENCIES}/apktool -fq d -s ${FILE_PATH} -o ${OUTDIR} &> /dev/null
echo "I: Converting Dex to Jar..."
sh ${DEPENDENCIES}/dex-tools-2.1-SNAPSHOT/d2j-dex2jar.sh -d -os -ts ${FILE_PATH} -o ${OUTDIR}/${FILE_NAME}.jar &> /dev/null
#7za x -y -r -o${OUTDIR} ${OUTDIR}/classes_dex2jar.jar &> /dev/null
echo "I: Retreiving the Java Files..."
${DEPENDENCIES}/jd-cli ${OUTDIR}/${FILE_NAME}.jar -od ${OUTDIR} &> /dev/null

rm ${OUTDIR}/*.dex ${OUTDIR}/*.jar &> /dev/null
echo "I: APK decompiled..."
rm -rf ${TMP}
echo "I: Check Folder -> "${OUTDIR}