#!/bin/bash

man bash | sed 'y/._-+,/     ' | tr '[:space:]' '\n' | sort | uniq -c | sort -n -r |
awk -F' ' '{if (length($2) >= 4) print $2}' | head -3