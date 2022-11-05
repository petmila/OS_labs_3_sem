#!/bin/bash

if [ ! -d "$HOME/source" ]
then
    echo "There is no source dir"
    exit 1
fi

backup_date="$(date +"%Y-%m-%d")"
backup_sec="$(date -d "$todayDate" +"%s")"

last_backup_date="$(ls $HOME | grep -E "^Backup-" | sort -n | tail -1 | sed "s/Backup-//")"
last_backup="$HOME/Backup-$last_backup_date"
last_backup_sec="$(date -d "$last_backup_date" +"%s")"

day_diff="$(echo "($backup_sec - $last_backup_sec) / 60 / 60 / 24" | bc)"

report="$HOME/backup-report"

if [[ "$day_diff" -gt "7" ]] || [ -z "$last_backup_date" ]
then
    backup="$HOME/Backup-$backup_date"
    mkdir $backup

    echo "$backup created in $backup_date:" >> $report

    IFS=$'\n'
    for file in $(ls -1 $HOME/source)
    do
        if [ ! -d "$HOME/source/$file" ]
        then
            cp -a "$HOME/source/$file" "$backup"
            echo "$file" >> $report
        fi
    done
else
    backup="$last_backup"
    touch temp
    echo "$backup modified in $backup_date:" >> $report

    IFS=$'\n'
    for file in $(ls $HOME/source)
    do
        if [ ! -d "$HOME/source/$file" ]
        then
            if [ -f "$backup/$file" ]
            then
                file_size="$(stat $HOME/source/$file -c%s)"
                last_file_size="$(stat $backup/$file -c%s)"

                if [ "$file_size" != "$last_file_size" ]
                then
                    mv "$backup/$file" "$backup/$file.$backup_date"
                    cp -a "$HOME/source/$file" "$backup"
                    echo "$file $file.$backup_date" >> temp
                fi
            else
                cp -a "$HOME/source/$file" "$backup"
                echo "$file" >> $report
            fi
        fi
    done

    cat temp >> $report
    rm temp
fi