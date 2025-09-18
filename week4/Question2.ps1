# Get login and logoff records from Widndows Events and save to a variable
# Get the last 14 days 

$loginouts = Get-EventLog system -Source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-14)

$loginoutsTable = @() #Empty Array to fill customly
for($i=0; $i -lt $loginouts.Count; $i++){

# creating event property value 
$event = ""
if($loginouts[$i].InstanceId -eq "7001") {$event="Logon"}
if($loginouts[$i].InstanceId -eq "7002") {$event="Logoff"}

# Creating user Property value 
$user = $loginouts[$i].ReplacementStrings[1]

# Adding each new line (in form of a custom object) to our empty array
$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].InstanceId; `
                                    "Event" = $event; `
                                     "User" = $user; 
                                     }
} #End of for loop

$loginoutsTable