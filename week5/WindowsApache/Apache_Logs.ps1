#Three inputs: The page visted or referred from, the HTTP code returned, and the name of the Web Browser
#One Output: IP addresses that have visited the given or referred from, with the given web browser, and the given HTTP response
#Dot notation to call your function from the file named main.ps1 

function vistedpages($page, $code, $browsername){

# Looks through access logs in apache and filters through the three options
# These were pulled from the main.ps1 file

$accesslogs = Get-Content C:\xampp\apache\logs\access.log | Select-String -Pattern ".+$page.+$code.+$browsername.+"

# Empty array for collected IPs
$IPArray = @()

#For loop for access logs and IPs
foreach ($line in $accesslogs) {
 $IPArray += [regex]::Matches($line.ToString(), "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}")
}

#Change the collected IPs into a custom object with "IP"
# So grouping and couting can be completed 
$ips = @()
foreach ($ip in $IPArray) {
 $ips += [pscustomobject]@{IP=$ip}
 }

 # Filter for only IP addresses with 10
 $ipcount = $ips | Where-Object {$_.IP -ilike "10.*"}

 # Grouping IP and counting
 $ipcount | Group-Object IP | Select-Object Count, Name
}

vistedpages 