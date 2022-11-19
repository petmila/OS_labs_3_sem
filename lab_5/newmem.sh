#!/bin/bash
array=()
counter=0
N=$1
while [ true ]
do
    array+=(1 2 3 4 5 6 7 8 9 10)

    if [ ${#array[@]} -gt $N ]
    then
        exit 1
    fi
done