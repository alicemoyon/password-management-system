#!/bin/bash

user=$1
service=$2
parm=$3
payload=$4

if [ "$#" -ne 4 ]; then
	echo "Error: parameters problem"
elif [[ ! -z "$parm" && "$parm" != f ]]; then
	echo "Error: parameters problem"
elif ! [ -d "$user" ]; then
	echo "Error: user does not exist"
elif [[ -f "$user/$service" && "$parm" = f ]]; then
	echo "$payload" > "$user/$service"
	echo "OK:service updated"
elif [[ -f "$user/$service" && -z "$parm" ]]; then 
	echo "Error: service already exists"
else
	var=$(dirname "$service")
	if [ "$var" = "." ]; then
		touch "$user/$service"
	else
		mkdir -p "$user/$var"
		touch "$user/$service"
	fi
	printf  "$payload" > "$user/$service"
	echo "OK: service created" 
fi
