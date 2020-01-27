#!/bin/bash

if [ "$#" -lt 2 ]; then
        echo "Error: parameters problem"
else
	case "$2" in
        init)
		if [ "$#" -eq 3 ]; then
			clientid=$1
			request=$2
			username=$3
			echo "$clientid" "$request" "$username" > server.pipe	
			mkfifo "$clientid.pipe"
			read input < "$clientid.pipe"
			echo $input
			rm "$clientid.pipe"
		else
			echo "Error: missing parameters"
		fi;;
        insert)
		if [ "$#" -eq 4 ]; then
                        clientid=$1
                        request=$2
                        username=$3
			servicename=$4
			echo "Please write login:"
			read myLogin
			echo "Please write password:"
			read myPassword
			echo "$clientid" "$request" "$username" "$servicename" "" "$myLogin\\\n$myPassword" > server.pipe
			mkfifo "$clientid.pipe"
			read input < "$clientid.pipe"
			echo $input
			rm "$clientid.pipe"
		else
			echo "Error: missing parameters"
		fi;;
        show)
		if [ "$#" -eq 4 ]; then
                	clientid=$1
                	request=$2
              		username=$3
			servicename=$4
                       	echo "$clientid" "$request" "$username" "$servicename" > server.pipe
			mkfifo "$clientid.pipe"
			while read line ; do
                        	echo "$line"
                        done < "$clientid.pipe"
			rm "$clientid.pipe"
		else
			echo "Error: missing parameters"
		fi;;
	ls)
		if [ "$#" -ge 3 ]; then
                        clientid=$1
                        request=$2
                        username=$3
			servicename=$4
			echo  "$clientid" "$request" "$username" "$servicename" > server.pipe
			mkfifo "$clientid.pipe"
			while read line ; do
				echo "$line"
			done < "$clientid.pipe"
			rm "$clientid.pipe"
		else
			echo "Error: missing parameters"
		fi;;
        edit)
		if [ "$#" -eq 4 ]; then
			clientid=$1
			request=$2
			username=$3
			servicename=$4
			echo "sending edit request"
		else 
			echo "Error: missing parameters"
		fi;;
        rm)
		if [ "$#" -eq 4 ]; then
			clientid=$1
			request=$2
			username=$3
			servicename=$4
			echo "$clientid" "$request" "$username" "$servicename" > server.pipe
			mkfifo "$clientid.pipe"
			read input < "$clientid.pipe"
			echo $input
			rm "$clientid.pipe"
		else
			echo "Error: missing parameters"
		fi;;
        shutdown)
		clientid=$1
		request=$2
		echo "$clientid" "$request" > server.pipe;;
        *)
                echo "Error: bad request"
               	exit 1
esac
fi
