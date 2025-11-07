#!bin/bash

allLogs=""
file="/var/log/apache2/access.log"

# Creating a function to count every curl access 

function countingCurlAccess(){
  curlAccess=$(cat "$allLogs" | grep "curl" | cut -d' ' -f1 | sort | uniq -c)
}

countingCurlAccess
echo "$curlAccess"
