#!bin/bash

: '
file="/var/log/apache2/access.log"

tail -n 5 "$file"

results=$(cat "$file" | grep "Firefox")

results=$(cat "$file" | cut -d' ' -f1,4 | tr -d "[")

echo "$results"
'

#Deliverable 3
# -f3- removes the characters connected to page1.html, such as the "http:10.0.17.24
# the last command, the translate one, adds a  space character

file="/var/log/apache2/access.log.1"

results=$(cat "$file" | grep "GET /page2.html" | cut -d' ' -f1,11 | cut -d "/" -f3- | tr '\t' ' ')   

echo "$results"
