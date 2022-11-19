#!/bin/bash

array=()
count=0
>report2.log
while [ true ]
do
        array+=(1 2 3 4 5 6 7 8 9 10)
        let "count += 1"
        if (( $count % 100000 == 0 ))
        then
                echo ${#array[@]} >> report2.log
        fi
done