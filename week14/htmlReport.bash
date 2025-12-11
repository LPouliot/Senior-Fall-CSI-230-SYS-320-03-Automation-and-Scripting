#!/bin/bash

# Creating the html document 

cat > report.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
<title>
Reported Access Logs
</title>
</head>
<body>
<h1> Access logs with IOC indicators:</h1>
<table>
EOF

# Reading report.txt and creating the table rows!
# Using the same trick from last challenge to avoid  spacers
while IFS= read -r line;
do
	#splitting into IP, timestamp, and spefific IOC page
	ip=$(echo "$line" | awk '{print $1}')
	timestamp=$(echo "$line" | awk '{print $2}')
	page=$(echo "$line" | awk '{print $3}')

	#adding  rows for the table
	echo " <tr>" >> report.html
	echo " <td>$ip</td>" >> report.html
	echo " <td>$timestamp</td>" >> report.html
	echo " <td>$page</td>" >> report.html
	echo " </tr>" >> report.html

done < report.txt

# closing up the html

cat >> report.html << 'EOF'
</table>
</body>
</html>
EOF

sudo mv report.html /var/www/html

echo "the report.html has been relocated to the webpage."
