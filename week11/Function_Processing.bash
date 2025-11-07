#!bin/bash

allLogs=""
file="/var/log/apache2/access.log"


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


# Creating a function to count every curl access to the server from a different IP address

function countingCurlAccess(){
curlAccess=$(echo "$allLogs" | grep "curl")
}


getAllLogs
ips
pageCount
countingCurlAccess
echo "$curlAccess" 

