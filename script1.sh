#!/bin/bash

release_file=/etc/os-release

if [ -d /etc/pacman.d ]
then
	sudo pacman -Syu
fi

if [ -d /etc/apt ]
then
	sudo apt update
	sudo apt dist-upgrade
fi

if [ -d /etc/yum ]
then
	sudo yum update
fi
