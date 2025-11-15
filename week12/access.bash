
#!/bin/bash

# Narrowing to get date and time
dateTime=$(date "+%a %b %d %I:%M:%S %p %Z %Y")

# Logging to fileaccesslog.txt
echo "File was Accessed at $datetime" > /home/champuser/Senior-Fall-CSI-230-SYS-320-03-Automation-and-Scripting/week12/fileaccesslog.txt

# Sending Email
echo "To: lily.pouliot@mymail.champlain.edu" >> fileaccesslog.txt
echo "Subject: Access" >> fileaccesslog.txt

cat  fileaccesslog.txt | ssmtp lily.pouliot@mymail.champlin.edu

