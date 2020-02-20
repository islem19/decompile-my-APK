#!/bin/bash
#The following script is to copy the command line and man page in your system

#copy the apkdecompile to /usr/bin
sudo cp $(pwd)/apkdecompile.sh /usr/bin/apkdecompile
sudo chmod 0755 /usr/bin/apkdecompile
#copy the man page to the right target man(1)
sudo cp $(pwd)/man/apkdecompile.1 /usr/share/man/man1/apkdecompile.1
sudo gzip /usr/share/man/man1/apkdecompile.1
sudo mandb