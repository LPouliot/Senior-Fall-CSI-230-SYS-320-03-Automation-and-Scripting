# Get only logs that contain 404, save into $notfounds
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

# Define a regex for IP addresses
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

# Get $notfound's records that match to the regex
$ipsUnorganized = $regex.Matches($notfounds)

# Get Ips as pscustomObject
$ips = @()
for ($i=0; $i -lt $ipsUnorganized.count; $i++){
 $ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].Value; }
}

# Filter IPs that start with 10
$ipsoftens = $ips | Where-Object { $_.IP -like "10.*" }


# Counting filtered IPs
$counts = $ipsoftens | Group-Object -Property IP| Select-Object Count, Name