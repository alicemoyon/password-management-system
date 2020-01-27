#!/bin/bash

user=$1

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
	echo "Error: parameters problem"
elif ! [ -d "$user" ]; then
	echo "Error: user does not exist"
elif [ "$#" -eq 2 ]; then
	folder=$2
	if [ -d "$folder" ]; then
		echo "OK:"
		tree "$user/$folder"
	else
		echo "Error: folder does not exist"
	fi
else 
	echo "OK:"
	tree "$user"
fi
