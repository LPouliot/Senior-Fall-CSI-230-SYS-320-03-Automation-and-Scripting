#!/bin/bash

echo "Enter the file being scanned:" 
read logfile

echo "ENter the scanning file:"
read IOCfile

# Searching for all of the indicators within IOC.txt
for ((i=1; i<=${#iocfile}; i++ ));
do
	grep -F "$ioc" "$logfile" | awk '{print $1, $2, $3}' >> report.txt
done
