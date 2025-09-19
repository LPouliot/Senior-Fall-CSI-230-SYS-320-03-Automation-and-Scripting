# Login and Logoff information function

#creating biggo Function

function WindowsandComputers {

$chosendays = Read-Host "Fill in the number of days you would like to check for login and logoff events"

# Get login and logoff records from Widndows Events and save to a variable
$loginouts = Get-EventLog system -Source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-$chosendays)

$loginoutsTable = @() #Empty Array to fill customly

for($i=0; $i -lt $loginouts.Count; $i++){

# creating event property value 
$event = ""
if($loginouts[$i].InstanceId -eq "7001") {$event="Logon"}
if($loginouts[$i].InstanceId -eq "7002") {$event="Logoff"}

# Creating user Property valuTe 
# $user = $loginouts[$i].ReplacementStrings[1]
$user = New-Object System.Security.Principal.SecurityIdentifier($loginouts[$i].ReplacementStrings[1])
$account = $user.Translate([System.Security.Principal.NTAccount])
$username = $account.Value


# Adding each new line (in form of a custom object) to our empty array
$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].InstanceId; `
                                    "Event" = $event; `
                                     "User" = $username; 
                                     }
} #End of for loop

Write-Host "Giving the login and logoff events for the specified days"

return $loginoutsTable

##################################################
# Computer start and stop 

$chosendays = Read-Host "Fill in the number of days you would like to check for computer start and shutdown times"

# Get computer start and stop records from Windows Events, then saving them to a variable
# Have to use Where-Object to track system events 
$startstop = Get-EventLog system -After (Get-Date).AddDays(-$chosendays) | `
Where-Object {$_.EventID -eq 6005 -or $_.EventID -eq 6006}

$StartStopTable = @() #Empty Array to fill customly

for($i=0; $i -lt $startstop.Count; $i++){

# creating event property value 
$event = ""
if($startstop[$i].EventID -eq "6005") {$event="Start"}
if($startstop[$i].EventID -eq "6006") {$event="Shutdown"}

# Creating a new user property value using System
$username = "System"


# Adding each new line (in form of a custom object) to our empty array
$StartStopTable += [pscustomobject]@{"Time" = $startstop[$i].TimeGenerated; `
                                       "Id" = $startstop[$i].EventID; `
                                    "Event" = $event; `
                                     "User" = $username; 
                                     }
} #End of for loop

Write-Host "Giving the computer start and shutdown times for the specified days."

return $StartStopTable
}

#calling the function

WindowsandComputers