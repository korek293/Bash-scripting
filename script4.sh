#!/bin/bash

check_even_odd() {
	if (( number % 2 == 0 ))
	then
		echo "Your number is even"
	else
		echo "Your number is odd"
	fi
}

echo "Please enter the number: "
read number
check_even_odd
