#!bin/bash

: '
file="/var/log/apache2/access.log"

tail -n 5 "$file"

results=$(cat "$file" | grep "Firefox")

results=$(cat "$file" | cut -d' ' -f1,4 | tr -d "[")

echo "$results"
'

#Deliverable 3

file="/var/log/apache2/access.log.1"

results=$(cat "$file" | grep "GET /page2.html" | cut -d' ' -f1,11 | tr -d "/" | tr -d "http:10.0.17.24") 

echo "$results"
