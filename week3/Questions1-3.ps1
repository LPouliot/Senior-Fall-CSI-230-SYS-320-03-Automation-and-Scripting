# Question one, lists every process for which ProcessName starts with C
#Get-Process | Where-Object { $_.Name -ilike "C*" }

# Question two, lists every process for which path does not include the string "system32"
#Get-Process | Where-Object {$_.Name -notlike "system32*"}

#Quetion three, lists every stopped service, orders it alphabetically, saves to csv fil

$folderpath = "C:\Users\champuser\Downloads"
$filepath = Join-Path $folderpath "Q3Output.csv"
$files = Get-Service

$files | Where-Object {$_.Status -eq "Stopped" } | Sort-Object |`
Export-csv -Path $filepath