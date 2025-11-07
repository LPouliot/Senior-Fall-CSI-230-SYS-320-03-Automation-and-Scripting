#!bin/bash

#allLogs=
#file=/var/log/apache2/access.log.1


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

# Creating a function to count every curl access to the server from a different IP address

logs=""
file="/var/log/apache2/access.log"

function countingCurlAccess(){
curlAccess=$(echo "$logs" | grep "curl/7.81.0" | cut -d' ' -f1 | sort | uniq -c)
}

countingCurlAccess
echo "$curlAccess" 

