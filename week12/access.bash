#!/bin/bash

# Narrowing to get date and time
FILE="fileaccesslog.txt"
ACCESSED="$1"
TIMESTAMP=$(date "+%Y-%m-%d %H-%M-%S")

# Log the file
echo "[$TIMESTAMP] File Accessed: $ACCESSED" >> "$FILE"

# Send email 
echo "To: lily.pouliot@mymail.champlain.edu" > fileaccesslog.txt
echo "Subject: Access" >> fileaccesslog.txt
cat "$FILE" >> fileaccesslog.txt
cat fileaccesslog.txt | ssmtp lily.pouliot@mymail.champlain.edu 
