#!/bin/bash

restore="$HOME/restore"
backup="$HOME/$(ls $HOME | grep "^Backup-" | sort -n | tail -1)"

if [ -z "$backup" ]
then
    echo "There is no backups"
    exit 1
fi

if [ ! -d "$restore" ]
then
    mkdir "$restore"
fi

IFS=$'\n'
for file in $(ls -1 $backup | grep -Ev "\.[0-9]{4}-[0-9]{2}-[0-9]{2}$")
do
if [ -d "$restore/$file" ]
then
    echo "There is a directory with file name. Directory was deleted"
    rm -rf "$restore/$file"
fi
if [ -e "$restore/$file" ]
then
    echo "There is a duplicate file, this file was deleted"
    rm "$restore/$file"
fi
    cp -a "$backup/$file" "$restore/$file"
done