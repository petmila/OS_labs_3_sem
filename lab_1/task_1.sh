#!/bin/bash
if [[ "$1" -gt "$2" ]] 
then 
    if [[ "$2" -gt "$3" ]]
    then 
        echo "$1"
    fi
else 
    if [[ "$1" -gt "$3" ]]
    then 
        echo "$2"
    else 
        echo "$3"
    fi
fi