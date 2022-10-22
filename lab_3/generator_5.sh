#!/bin/bash

while true;
do
	read line
	echo "$line" > pipe
	if [[ "$line" == "QUIT" ]];
	then
			#rm pipe
			echo "Finish"
			exit 0
	fi
	if [[ ! $line =~ [0-9"+*"]+ ]];
	then
			#rm pipe
			echo "Error command: generator"
			exit 1
	fi
done