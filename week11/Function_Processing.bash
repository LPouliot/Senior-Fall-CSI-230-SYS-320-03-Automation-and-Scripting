#!bin/bash

allLogs=""
file="/var/log/apache2/access.log.1"

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f1,4,7 | tr -d "[")
}

function ips(){
ipsAccessed=$(echo "$allLogs" | cut -d' ' -f1)
}

# extracting field 3, sorts pages alphabetically, counts duplicate and prefixses each line  

function pageCount(){
countedPages=$(echo "$allLogs" | cut -d' ' -f3 | sort | uniq -c)
}


getAllLogs
ips
pageCount 

echo "$allLogs"
