#!/bin/bash
array=()
counter=0
>report.log
while [ true ]
do
    array+=(1 2 3 4 5 6 7 8 9 10)
    let "counter = counter + 1"

    if (( $counter % 100000 == 0 ))
    then
        echo ${#array[@]} >> report.log
    fi
done