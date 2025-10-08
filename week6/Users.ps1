

<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for enabled users
****************************** #>
function getEnabledUsers(){

  $enabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "True" } | Select-Object Name, SID
  return $enabledUsers

}



<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for not enabled users
****************************** #>
function getNotEnabledUsers(){

  $notEnabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "False" } | Select-Object Name, SID
  return $notEnabledUsers

}


# -|| Changed this because I kept getting errors from PowerShell ||-

<# ******************************
# Create a function that adds a user
****************************** #>
function createAUser($name, $password){

 try{
   New-LocalUser -Name $name -Password $password 
   
   $newUser = Get-LocalUser -Name $name

   # ***** Policies ******

   # User should be forced to change password
   Set-LocalUser $newUser -PasswordNeverExpires $false

   # First time created users should be disabled
   Disable-LocalUser $newUser

   Write-Host "User policies applied successfully." | Out-String
   }
  catch{
   Write-Host "Error Creating User: $_" | Out-String # Kept getting a lot of errors and wanted to see why
   }

}



<# ******************************
# Create a function that adds a user
****************************** 
function createAUser($name, $password){

   $params = @{
     Name = $name
     Password = $password
   }

   $newUser = New-LocalUser @params 


   # ***** Policies ******

   # User should be forced to change password
   Set-LocalUser $newUser -PasswordNeverExpires $false

   # First time created users should be disabled
   Disable-LocalUser $newUser

   Write-Host "User policies applied successfully." | Out-String

}
#>



function removeAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Remove-LocalUser $userToBeDeleted
   
}



function disableAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Disable-LocalUser $userToBeDeleted
   
}


function enableAUser($name){
   
   $userToBeEnabled = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Enable-LocalUser $userToBeEnabled
   
}

# Create a function called checkUser in Users that: 
#              - Checks if user a exists. 
#              - If user exists, returns true, else returns false

function checkUser($name){

    $allUsers = Get-LocalUser | Select-Object Name

    foreach($user in $allUsers){
        if($user.Name -ieq $name){
            return $true         
        }
        else{
            return $false
    } #close if/else statement
  }

} # Close the function







<#
    $enabledUsers = getEnabledUsers
    $disabledUsers = getNotEnabledUsers

    foreach($user in $enabledUsers){
        if($user.Name -eq $name){
            return $true         
        }
        else{
            return $false
    } #close if/else statement
  }

    foreach($user in $disabledUsers){
        if($user.Name -eq $name){
            return $true
        }
        else{
            return $false
        }
    }
} # Close the function
    #>