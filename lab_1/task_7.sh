#!/bin/bash

grep -E -o -s -h -r "[[:alnum:]+\.\_\-\%]+@[[:alnum:].\_\-]+\.[[:alpha:]]" /etc | tr "\n" ", " > emails.lst