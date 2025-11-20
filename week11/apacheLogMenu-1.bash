#! /bin/bash

logFile="/var/log/apache2/access.log.1"

function displayAllLogs(){
	cat "$logFile"
	printf "\n"
}

function displayOnlyIPs(){
        cat "$logFile" | cut -d " " -f 1 | sort -n | uniq -c
	printf "\n"
}

# function: displayOnlyPages:
# like displayOnlyIPs - but only pages

functiion displayOnlyPages(){
	cat "$logFile" | cut -d " " -f 7 | sort -n | uniq -c 
	printf "\n"
}

function histogram(){

	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '['  | sort \
                              | uniq)
	# This is for debugging, print here to see what it does to continue:
	# echo "$visitsPerDay"

        :> newtemp.txt  # what :> does is in slides
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 \
                                     | cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d  " " -f 1)

		local newLine="$IP $withoutHours"
		echo "$IP $withoutHours" >> newtemp.txt
	done 
	cat "newtemp.txt" | sort -n | uniq -c
}

# function: frequentVisitors: 
# Only display the IPs that have more than 10 visits
# You can either call histogram and process the results,
# Or make a whole new function. Do not forget to separate the 
# number and check with a condition whether it is greater than 10
# the output should be almost identical to histogram
# only with daily number of visits that are greater than 10 

function frequentVisitors(){
	:>  More10Visit.txt

	cat "$logFile" | cut -d ' ' -f 1,4 | tr -d "[" | while read -r ip datetime;
	do
		date=$(echo "$datetime" | cut -d ":" -f1)
		echo "$ip $date" >> More10Visit.txt
	done

	sort More10Visit.txt | uniq -c | while read -r count ip date;
	do
		if (( count > 10 ));
		then
			echo "$count $ip $date"
			printf "\n"
		fi

	done
}

# function: suspiciousVisitors
# Manually make a list of indicators of attack (ioc.txt)
# filter the records with this indicators of attack
# only display the unique count of IP addresses.  
# Hint: there are examples in slides

function suspiciousVisitors(){ 
	declare -A ips
	while read -r ioc;
	do
		matching=$(grep "$ioc" "$logFile"

		while read -r line;
		do
			matching=$(echo "$line" | awk '{print $1}')
			if [[ -n "$ip" ]];
			then
				((ips["$ip"]++))
			fi
		done <<< "$matching"
	done < "ioc.txt"
	for ip in "${!ips[@]}";
	do
		echo "${ips[$ip]} $ip"
	done
	printf "\n"

}


# Keep in mind that I have selected long way of doing things to 
# demonstrate loops, functions, etc. If you can do things simpler,
# it is welcomed.

while :
do
	echo "PLease select an option:"
	echo "[1] Display all Logs"
	echo "[2] Display only IPS"
	# Display only pages visited
	echo "[3] Display only Pages"
	echo "[4] Histogram"
	# Frequent visitors
	echo "[5] Frequent Visitors"
	# Suspicious visitors
	echo "[6] Suspicious Visitors"
	echo "[7] Quit"

	read userInput
	echo ""

	if [[ "$userInput" == "7" ]]; then
		echo "Goodbye"		
		break

	elif [[ "$userInput" == "1" ]]; then
		echo "Displaying all logs:"
		displayAllLogs

	elif [[ "$userInput" == "2" ]]; then
		echo "Displaying only IPS:"
		displayOnlyIPs

	# Display only pages visited
	elif [[ "userInput" == "3" ]]; then
		echo "Displaying only Pages:"
		displayOnlyPages

	elif [[ "$userInput" == "4" ]]; then
		echo "Histogram:"
		histogram

        # Display frequent visitors
	elif [[ "userInput" == "5" ]]; then
                echo "Displaying Frequent Visitors:"
                frequentVisitors

	# Display suspicious visitors
	elif [[ "userInput" == "6" ]]; then
                echo "Displaying Suspicious Visitors:"
                suspiciousVisitors

	# Display a message, if an invalid input is given
	else
		echo "Nuh Uh, try again!"

	fi
done

