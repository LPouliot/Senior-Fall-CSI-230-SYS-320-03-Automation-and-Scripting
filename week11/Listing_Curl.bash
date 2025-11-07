#!bin/bash

file="/var/log/apache2/access.log"

# Creating a function to count every curl access 

function countingCurlAccess(){
  curlAccess=$(cat "$file" | grep "curl" | cut -d' ' -f1,12 )
}

countingCurlAccess
echo "$curlAccess"
