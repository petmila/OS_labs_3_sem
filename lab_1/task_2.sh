#!/bin/bash
read string
while [[ "$string" != "q" ]]
do
	result+="$string"
	read string
done
echo "$result"