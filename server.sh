#!/bin/bash

mkfifo server.pipe
read input1 input2 input3 input4 input5 < server.pipe
	echo "read from pipe" $input1 $input2 $input3 $input4 $input5
case "$input2" in
	init)
		echo "$(./init.sh  "$input3" &)" > "$input1.pipe";;
	insert)
		echo "$input4"
		echo "$input5"	
		echo "$(./insert.sh "$input3" "$input4" "" "$input5" &)" > "$input1.pipe";;
	show)
		echo "$(./show.sh "$input3" "$input4" &)" > "$input1.pipe";;
	update)
		./insert.sh "$input3" "$input4" f "$input5" &;;
	rm)
		echo "$(./rm.sh "$input3" "$input4" &)" > "$input1.pipe";;
	ls)
		if [ -z $input4 ]; then
			echo "$(./ls.sh "$input3" &)" > "$input1.pipe"
		else
			echo"$(./ls.sh "$input3" "$input4" &)" > "$input1.pipe"
		fi;;
	shutdown)
		rm "server.pipe"
		rm "$input1.pipe"
		exit 0;;
	*)
		echo "Error: bad request"
		exit 1
esac
