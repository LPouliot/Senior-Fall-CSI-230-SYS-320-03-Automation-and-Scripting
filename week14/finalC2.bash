#!/bin/bash

echo "Enter the file being scanned:" 
read logfile

echo "Enter the scanning file:"
read iocfile

# Searching for all of the indicators within IOC.txt
while IFS= read -r ioc;
do
	[[ -z "$ioc" ]] &&  continue
	grep -F "$ioc" "$logfile" | awk '{print $1, $2, $3'} > report.txt
done < "iocfile"
