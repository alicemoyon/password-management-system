#!/bin/bash

user=$1
service=$2

if [ "$#" -ne 2 ]; then
	echo "Error: parameters problem"
elif ! [ -d "$user" ]; then
	echo "Error: user does not exist"
elif ! [ -f "$user/$service" ]; then
	echo "Error: service does not exist"
else
	rm "$user/$service"
	echo "OK: service removed"
fi
 
