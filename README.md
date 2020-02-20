# Decompile My APK 

<img src="https://github.com/islem19/decompile-my-APK/blob/master/res/img/icon.png?raw=true" align="left" hspace="10" vspace="10"></a>
<br><br><br><br><br>
a command line tool to decompile your APK instantly.
<br><br><br><br><br><br>

> Note: Command Line is still in Alpha Version. Feel Free to [Contribute](https://github.com/islem19/decompile-my-APK/blob/master/CONTRIBUTING.md)


## Installation

###	Manual

```shell
#####clone the project
git clone "https://github.com/islem19/decompile-my-APK.git"
#####copy the apkdecompile to /usr/bin
sudo cp $(pwd)/apkdecompile.sh /usr/bin/apkdecompile
sudo chmod 0755 /usr/bin/apkdecompile
#####copy the man page to the right target man(1)
sudo cp $(pwd)/man/apkdecompile.1 /usr/share/man/man1/apkdecompile.1
sudo gzip /usr/share/man/man1/apkdecompile.1
sudo mandb
```

###	Auto

```shell
#####clone the project and run the install.sh
git clone "https://github.com/islem19/decompile-my-APK.git"
sh install.sh
############ 
```

## Usage

```shell
apkdecompile [APK path] [OPTION] [-o|--output] [-h|--help] [-v|--version]
```

You can check the man page using:
```shell
########### Help on apkdecompile
man apkdecompile
###########
```

To check the available commands you can run also:
```shell
############
apkdecompile [-h|--help ]
############
```

## Man Page

Manual (man) pages should obey a particular layout. This isn’t strictly necessary, but will help make your man page similar to every other in your system and not confuse or surprise your users.

### Install Man Page

The name of the man page should be <name_of_command>.1 

Check out [man/apkdecompile.1](https://github.com/islem19/decompile-my-APK/blob/master/man/apkdecompile.1) as a demo file.
```shell
############ copy man page to the man(1) category- User Command Man Pages
sudo cp apkdecompile.1 /usr/share/man/man1/apkdecompile.1
############ Compress the file using Gzip
sudo gzip /usr/share/man/man1/apkdecompile.1
############ Source and refresh the Man Database
sudo mandb
```

# License
-------
    Copyright (C) 2007 Free Software Foundation, Inc.
    <https://fsf.org/> Everyone is permitted to copy and distribute verbatim copies of this license document, but changing it is not allowed.

    The GNU General Public License is a free, copyleft license for software and other kinds of works.

    The licenses for most software and other practical works are designed to take away your freedom to share and change the works.  By contrast,
    the GNU General Public License is intended to guarantee your freedom to share and change all versions of a program


