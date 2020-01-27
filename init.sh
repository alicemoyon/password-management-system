#!/bin/bash

user=$1
if [ "$#" -gt 1 ] || [ "$#" -lt 1 ]; then
	echo "Error: parameters problem"
elif [ -d "$user" ]; then
	echo "Error: user already exists"
else
	mkdir "$user"
	echo "OK: user created"
fi
 
