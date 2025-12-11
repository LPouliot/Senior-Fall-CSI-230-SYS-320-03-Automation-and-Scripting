#!/bin/bash
echo "Enter the file being scanned:"
read logfile
echo "Enter the scanning file:"
read iocfile

# Searching for all of the indicators within IOC.txt
while IFS= read -r ioc;
do
	# Strip leading/trailing whitespace
	ioc=$(echo "$ioc" | xargs)

	[[ -z "$ioc" ]] && continue

	grep -F "$ioc" "$logfile" | awk '{print $1, $4, $7}' > report.txt

done < "$iocfile"

echo "glancing at report.txt file:"
cat report.txt
