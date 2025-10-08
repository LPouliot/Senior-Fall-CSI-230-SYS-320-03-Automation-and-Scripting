
. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List At Risk Users`n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"


        # Check the given username with your new function.
        #              - If false is returned, continue with the rest of the function
        #              - If true is returned, do not continue and inform the user

        $whenUserExists = checkUser $name

        if($whenUserExists){
            Write-Host "This user already exists." | Out-String
        }
        else{
            Write-Host "New user! proceeding.." | Out-String
            
            # Using convert secure string into plain text

            $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
            $plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
    
        # Check the given password with your new function. 
        #              - If false is returned, do not continue and inform the user
        #              - If true is returned, continue with the rest of the function

        $whenPasswordGood = checkPassword $plainPassword

        if($whenPasswordGood){
            Write-Host "Password meets requirements" | Out-String

            #Write back to plain
            $securePassword = ConvertTo-SecureString $plainPassword -AsPlainText -Force

            createAUser $name $securePassword
            Write-Host "User: $name is created." | Out-String
        }
        else{
            Write-Host "Password does not meet requirements. Try again." | Out-String
            }
           
        }
       
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        #Check the given username with the checkUser function.
        $checkingRemoveUser = checkUser $name

        if($checkingRemoveUser){
            Write-Host "Removing user..." | Out-String
            removeAUser $name
            Write-Host "User: $name Removed." | Out-String
        }
        else{
            Write-Host "This user doesn't exist." | Out-String
            
        }
   
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        #Check the given username with the checkUser function.
        $checkingEnableUser = checkUser $name

        if($checkingEnableUser){
            Write-Host "Enabling user..." | Out-String
            enableAUser $name
            Write-Host "User: $name Enabled." | Out-String
        }
        else{
            Write-Host "This user doesn't exist." | Out-String
            
        }
   
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        #Check the given username with the checkUser function.
        $checkingDisableUser = checkUser $name

        if($checkingDisableUser){
            Write-Host "Disabling user..." | Out-String
            disableAUser $name
            Write-Host "User: $name Disabled." | Out-String
        }
        else{
            Write-Host "This user doesn't exist." | Out-String
            
        }
   
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        #Check the given username with the checkUser function.
        #Change the above line in a way that, the days 90 should be taken from the user
        $checkingUserLog = checkUser $name

        if($checkingUserLog){
            Write-Host "User located, checking logs.." | Out-String
            $userLogins = getLogInAndOffs 90
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else{
            Write-Host "This user doesn't exist." | Out-String
            
        }
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        #Check the given username with the checkUser function.
        #Change the above line in a way that, the days 90 should be taken from the user
        $checkingUserFailedLog = checkUser $name

        if($checkingUserFailedLog){
            Write-Host "User located, checking logs.." | Out-String
            $userLogins = getFailedLogins 90
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else{
            Write-Host "This user doesn't exist." | Out-String
            
        }
    }


    # Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    
    elseif($choice -eq 9){

        $days = Read-Host -Prompt "Choose a number of days to check for failed logins"

        #converting into an integer
        $days = [int]$days
     
        Write-Host "Checking for at-risk users with more than 10 failed logins for the number of $days days..." | Out-String

        $failedLogins = getFailedLogins $days 

        if($failedLogins -and $failedLogins.Count -gt 0){
            $userFailedCounts = $failedLogins | Group-Object -Property User |`
                            Select-Object Name, Count |`
                            Where-Object {$_.Count -gt 10} |`
                            Sort-Object Count -Descending
            if($userFailedCounts){
            
                Write-Host "At Risk Users with more than 10 failed login attemps..." | Out-String
                Write-Host ($userFailedCounts | Format-Table | Out-String)
            }
            else{
                Write-Host "Not At Risk Users were located, or had 10 or fewer failed logins."
            }
        }
        else{
        Write-Host "No failed login attempswere found in the last 90 days"
       }
    }


    elseif($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
       }

    # If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    else{
        Write-Host "INVALID CHOICE. Enter a number between 1 and 10."
    }
}