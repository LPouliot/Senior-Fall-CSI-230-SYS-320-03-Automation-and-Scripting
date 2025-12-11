#!/bin/bash
echo "Enter the file being scanned:"
read logfile
echo "Enter the scanning file:"
read iocfile

#clear report before use
> report.txt

# Searching for all of the indicators within IOC.txt

# added this because there was a problem with the spaces withint the IOC.txt file
while IFS= read -r ioc;
do
	# Strip leading/trailing whitespace
	ioc=$(echo "$ioc" | xargs)

	[[ -z "$ioc" ]] && continue

	grep -F "$ioc" "$logfile" | awk '{print $1, $4, $7}' >> report.txt

done < "$iocfile"
