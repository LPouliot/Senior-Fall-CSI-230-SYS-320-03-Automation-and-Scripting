#creating the function to let the user choose the amount of days to look for

function WindowsComputerStartShutdown {

$chosendays = Read-Host "Fill in the number of days you would like to check for cpmputer start and shutdown times:" 

# Get login and logoff records from Widndows Events and save to a variable
$startstop = Get-EventLog system -Source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-$chosendays)

$loginoutsTable = @() #Empty Array to fill customly
for($i=0; $i -lt $startstop.Count; $i++){

# creating event property value 
$event = ""
if($startstop[$i].EventId -eq "6005") {$event="Start"}
if($startstop[$i].EvemtId -eq "6006") {$event="Shutdown"}

# Creating user Property valuTe 
# $user = $loginouts[$i].ReplacementStrings[1]
$user = New-Object System.Security.Principal.SecurityIdentifier($startstop[$i].ReplacementStrings[1])
$account = $user.Translate([System.Security.Principal.NTAccount])
$username = $account.system


# Adding each new line (in form of a custom object) to our empty array
$loginoutsTable += [pscustomobject]@{"Time" = $startstop[$i].TimeGenerated; `
                                       "Id" = $startstop[$i].InstanceId; `
                                    "Event" = $event; `
                                     "User" = $username; 
                                     }
} #End of for loop

Write-Host "Giving the computer start and shutdown times for the specified days."

return $loginoutsTable

}

#calling the function

WindowsComputerStartShutdown