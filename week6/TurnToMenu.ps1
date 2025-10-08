. (Join-Path $PSScriptRoot ParsingApacheLogs.ps1)
. (Join-Path $PSScriptRoot )
. (Join-Path $PSScriptRoot )
. (Join-Path $PSScriptRoot )

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 Apache Logs`n"
$Prompt += "2 - Display last 1o failed logins`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome Web Browser`n"
$Prompt += "5 - Exit`n"



$operation = $true

while($operation){