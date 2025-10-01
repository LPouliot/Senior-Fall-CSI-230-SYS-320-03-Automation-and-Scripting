#using dot notation to call the functioninto the file main.ps1 

#dot notation
. (Join-Path $PSScriptRoot Apache_Logs.ps1)

clear

# Input from user
$page = Read-Host "Enter the page visited (ex: index.html)"
$code = Read-Host "Enter the HTTP response number (ex: 200)"
$browsername = Read-Host "Enter the name of the browser (ex: Chrome)"

# Function call
vistedpages -$page -$code $browsername