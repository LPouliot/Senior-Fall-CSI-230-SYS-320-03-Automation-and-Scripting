#creating the function to let the user choose the amount of days to look for

function WindowsLoginLogoffInfo {

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

}

#calling the function

WindowsLoginLogoffInfo