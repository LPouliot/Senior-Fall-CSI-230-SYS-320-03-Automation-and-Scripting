
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
$Prompt += "9 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 9){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
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

        # Create a function called checkUser in Users that: 
        #              - Checks if user a exists. 
        #              - If user exists, returns true, else returns false
        
        function checkUser($name){

            if($enabledUsers -contains $name){
                return $true 
                
             }
             else{
                return $false

             } #close if/else statement

        } # Close the function

        # Check the given username with your new function.
        #              - If false is returned, continue with the rest of the function
        #              - If true is returned, do not continue and inform the user

        $whenUserExists = checkUser $name

        if($whenUserExists){
            Write-Host "Cannot create user, it already exists" | Out-String
        }
        else{
            Write-Host "This user doesn't exist, proceeding.." | Out-String
        }
    }


        # Check the given password with your new function. 
        #              - If false is returned, do not continue and inform the user
        #              - If true is returned, continue with the rest of the function

        $whenPasswordGood = checkPassword $password

        if($whenPasswordGood){
            Write-Host "Password meets requirements" | Out-String
        }
        else{
            Write-Host "Password does not meet requirements" | Out-String
        }
       

        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
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

        if($checkingEnableUser){
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
        if($checkingUserFailedLog){
            Write-Host "User located, checking logs.." | Out-String
            $userLogins = getFailedLogins 90
            Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else{
            
    }


    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    
    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    

}