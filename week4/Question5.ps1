#creating the function to let the user choose the amount of days to look for

function WindowsComputerStartShutdown {

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

WindowsComputerStartShutdown