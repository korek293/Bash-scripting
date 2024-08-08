#!/bin/bash

finished=0

while [ $finished -ne 1 ]
do
	echo "What is your favorite Linux distribution?"

	echo "1 - Arch"
	echo "2 - CentOS"
	echo "3 - Ubuntu"
	echo "4 - Exit the script"

	read choice

	case $choice in
		1) echo "Arch is a rolling release.";;
		2) echo "CentOS is popular on servers";;
		3) echo "Ubuntu is popular on both servers and computers";;
		4) finished=1;;
		*) echo "you didn't enter an appropriate choice."

	esac
done

echo "Thank you for using this script"
