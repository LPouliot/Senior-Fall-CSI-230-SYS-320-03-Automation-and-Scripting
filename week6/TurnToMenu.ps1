. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Question4.ps1)
. (Join-Path $PSScriptRoot ParsingApacheLogs.ps1)

clear

$Message = "`n"
$Message += "Please choose your operation:`n"
$Message += "1 - Display last 10 Apache Logs`n"
$Message += "2 - Display last 1o failed logins`n"
$Message += "3 - Display at risk users`n"
$Message += "4 - Start Chrome Web Browser`n"
$Message += "5 - Exit`n"



$Operations = $true

while($Operations){

Write-Host $Message | Out-String
    $choice = Read-Host 


    # Display last 10 apache logs 
    # (Utilize function ApacheLogs1 from assignment Parsing Apache Logs)
    if($choice -eq 1){

        Write-Host "Displaying Last 10 Apache Logs.." | Out-String
        ApacheLogs1 | Select-Object -Last 10 |Format-Table -AutoSize -Wrap 
    }

   
   
    # Display last 10 failed logins for all users 
    # (Utilize function getFailedLogins from lab Local User Management Menu)
    if($choice -eq 2){
        Write-Host "Displaying last 10 Failed Logins for All Users.." | Out-String
        getFailedLogins 10 | Select-Object -Last 10 |Format-Table -AutoSize -Wrap 
    }



    # Display at risk users 
    # (Utilize your function from lab Local User Management Menu)
    if($choice -eq 3){
   
    Write-Host "Displaying all at Risk Users.." | Out-String
    $failedLogins = getFailedLogins 90

        if($failedLogins){
            $userFailedCounts = $failedLogins | Group-Object -Property User |`
                            Select-Object Name, Count |`
                            Sort-Object Count -Descending
       
            Write-Host ($userFailedCounts | Format-Table | Out-String)
    }
}
 

    # Start Chrome web browser and navigate it to champlain.edu
    # if no instances of Chrome is running (from lab Process Management - 1)
    if($choice -eq 4){
    Write-Host "Starting or Stopping Chrome.." | Out-String
    StartStopChrome 
    }



    # Exit
    elseif($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
       }

}