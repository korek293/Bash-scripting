#!/bin/bash

release_file=/etc/os-release
logfile=/var/log/updater.log
errorlog=/var/log/updater_errors.log

if grep -q "Arch" $release_file
then
	#The host is based on Arch
	sudo pacman -Syu
fi

if grep -q "Ubuntu" $release_file || grep -q "Debian" $release_file
then
	#The host is based on Ubuntu or Debian
	sudo apt update 1>>$logfile 2>>$errorlog
	if [ $? -ne 0 ]
	then
		echo "An error occured, please check the $errorlog file."
	fi
	sudo apt dist-upgrade -y 1>>$logfile 2>>$errorlog
	if [ $? -ne 0 ]
	then
		echo "An error occured, please check the $errorlog file."
	fi
fi

if [ -d /etc/yum ]
then
	#The host is based on Red Hat
	sudo yum update 1>>$logfile 2>>$errorlog
	if [ $? -ne 0 ]
	then
		echo "An error occured, please check the $errorlog file"
	fi
fi
