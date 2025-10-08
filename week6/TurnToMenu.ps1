. (Join-Path $PSScriptRoot ParsingApacheLogs.ps1)
. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot main.ps1)
. (Join-Path $PSScriptRoot Question4.ps1)

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

Write-Host $Prompt | Out-String
    $choice = Read-Host 


    # Display last 10 apache logs 
    # (Utilize function ApacheLogs1 from assignment Parsing Apache Logs)
    if($choice -eq 1){
        $tableRecords = (Get-Date).AddDays(-10) 
        $tableRecords | Format-Table -AutoSize -Wrap 
    }



   
    # Display last 10 failed logins for all users 
    # (Utilize function getFailedLogins from lab Local User Management Menu)
    if($choice -eq 2){

    }



    # Display at risk users 
    # (Utilize your function from lab Local User Management Menu)
    if($choice -eq 3){

    }







    # Start Chrome web browser and navigate it to champlain.edu
    # if no instances of Chrome is running (from lab Process Management - 1)
    if($choice -eq 4){

    }







    # Exit
    elseif($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
       }

    # If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    else{
        Write-Host "INVALID CHOICE. Enter a number between 1 and 5."
    }
}