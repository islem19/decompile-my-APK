#!/bin/bash
# 
# Credits: 
# Dex2Jar - Google
# JAD - Pavel Kouznetsov

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

SCRIPT_VER="V1.0.0"
FILE_PATH=${1}
FILE_NAME=$(echo "${1##*/}" | cut -f 1 -d '.')
EXTENSION=${1##*.}
OUTDIR="${PWD}/${FILE_NAME}_decompiled"
TMP=$(mktemp)
DEPENDENCIES=$HOME"/.dependencies"

# Check if a valid APK file is included
if [ "$EXTENSION" != "apk" ]; then
   echo "No APK file found, Sorry :("
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

echo "Checking for dependencies..."
which ${DEPENDENCIES}/jad 7za ${DEPENDENCIES}/dex-tools-2.1-SNAPSHOT/d2j-dex2jar.sh &> /dev/null
if [ $? = 1 ]; then 
	echo "Installing required dependencies..."
	mkdir -p ${DEPENDENCIES}
	sudo apt-get install p7zip unzip wget -y
	echo "Downloading Dex2Jar..."
	wget -qP ${TMP} https://github.com/pxb1988/dex2jar/files/1867564/dex-tools-2.1-SNAPSHOT.zip
	unzip -o ${TMP}/dex-tools-2.1-SNAPSHOT.zip -d ${DEPENDENCIES}
	chmod a+x ${DEPENDENCIES}/dex-tools-2.1-SNAPSHOT/*
	echo "Downloading JAD..."
	wget -qP ${TMP} https://varaneckas.com/jad/jad158e.linux.static.zip
	unzip -o ${TMP}/jad158e.linux.static.zip -d ${DEPENDENCIES}
	chmod a+x ${DEPENDENCIES}/jad
	
	echo "DONE...:)"
fi;

echo "Start decompiling the APK..."
mkdir -p ${OUTDIR} 
echo "Decompressing the APK..."
7za x -y -r -o${OUTDIR} ${FILE_PATH} classes.dex &> /dev/null
echo "converting Dex to Jar..."
sh ${DEPENDENCIES}/dex-tools-2.1-SNAPSHOT/d2j-dex2jar.sh -d -os -ts ${OUTDIR}/classes.dex -o ${OUTDIR}/classes_dex2jar.jar &> /dev/null
7za x -y -r -o${OUTDIR} ${OUTDIR}/classes_dex2jar.jar &> /dev/null
echo "Converting classes to Java Files..."
find ${OUTDIR} -iname '*.class' -exec jad -o -r -s .java -d${OUTDIR} {} \; &> /dev/null
find ${OUTDIR} -iname '*.class' -exec rm -f {} \;

rm ${OUTDIR}/*.dex ${OUTDIR}/*.jar 
echo "APK decompiled..."
rm -rf ${TMP}
echo "Check Folder -> "${OUTDIR}

