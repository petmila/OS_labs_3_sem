#!/bin/bash

if [ ! -d "$HOME/.trash" ]
then
        mkdir "$HOME/.trash"
        >$log
fi
if [ ! -f "$PWD/$1" ]
then
        echo "File does not exist"
        exit 1
fi
if [ "rmtrash.sh" = "$1" ]
then
        echo "Not able to delete rmtrash.sh - running script"
        exit 1
fi
link_name="$1$RANDOM"
ln "$PWD/$1" "$HOME/.trash/$link_name" 2> temp
echo "$PWD/$1 $link_name" >> "$HOME/.trash.log"
rm "$PWD/$1"
rm temp