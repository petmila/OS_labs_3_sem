#!/bin/bash
trash="$HOME/.trash"
trash_log="$HOME/.trash.log"
restoring_file="$PWD/$1"

if [ ! -d "$trash" ]
then
    echo "There is no trash"
    exit 1
fi
if [ ! $# == 1 ]
then
    echo "There should be exactly 1 argument"
    exit 1
fi
if [ ! -e "$trash_log" ]
then
    echo "There is no trash's logs"
    exit 1
fi

while read -u 3 current_file
do
    current_file_path="$(echo $current_file | awk '{print $1}')"
    current_file_name="$(echo $current_file | awk '{print $2}')"
    echo $current_file_name
    echo $1
    trash_file="$trash/$current_file_name"
    if [[ "$current_file_name" =~ "$1" ]]
    then
        echo "$current_file_path"
        echo "Restore this file[yes/no]?"
        read answer
        if [ $answer = "yes" ]
        then
            if [ -d "$(dirname $current_file_path)" ]
            then
                if [ ! -e "$restoring_file" ]
                then
                    ln "$trash_file" "$restoring_file" 2> temp
                else
                    echo "This file already exist. Rename file"
                    read new_file_name
                    while [ -e "$new_file_name" ]
                    do
                        echo "This file already exist. Rename file"
                        read new_file_name
                    done
                    ln "$trash_file" "$PWD/$new_file_name" 2> temp
                fi

            else
                echo "This directory doesn't exist"
                ln "$trash_file" "$HOME/$new_file_name" 2> temp
            fi

            cat "$trash_log" | grep -v "$current_file" > $trash_log
            rm "$trash_file"
            rm temp
        fi
    fi
done 3< "$trash_log"