

$Message = "`n"
$Message += "Please choose your operation:`n"
$Message += "1 - Show Configuration`n"
$Message += "2 - Change Configuration`n"
$Message += "3 - Exit`n"



$Operations = $true

while($Operations){

Write-Host $Message | Out-String
    $choice = Read-Host 


    # Show configuration, should be displayedf as pscustomobject
    if($choice -eq 1){ 
        $configFile = Get-Content -Path C:\Users\champuser\Senior-Fall-CSI-230-SYS-320-03-Automation-and-Scripting\week7\configuration.txt
        
        $day = $configFile[0]
        $time = $configFile[1]

       $results = [pscustomobject]@{
                  "Day" = $day
                  "Time" = $time
                  }
       $results | Format-Table

    }


    # Change configuration, will ask the user for new configuration and replace the old config with new
    elseif($choice -eq 2){ 
        $configsFile = Get-Content -Path C:\Users\champuser\Senior-Fall-CSI-230-SYS-320-03-Automation-and-Scripting\week7\configuration.txt  
        

        $OldDay = $configsFile[0]
        $OldTime = $configsFile[1]

        $UpdatedDay = Read-Host -Prompt "Please enter the new DAY"
        $NEWDay = $OldDay.Replace($OldDay,$UpdatedDay)
        Write-Host "===================================================="
        Write-Host "Enter as the following for TIMES = Digit:Digit AM/PM" | Out-String
        Write-Host "For Example = 1:22 PM" | Out-String
        Write-Host "===================================================="
        $UpdatedTime = Read-Host -Prompt "Please enter the new TIME"
        $NEWTime = $OldTime.Replace($OldTime,$UpdatedTime)
         Write-Host "Updating..." | Out-String

        $NEWDay, $NEWTime | Set-Content -Path  C:\Users\champuser\Senior-Fall-CSI-230-SYS-320-03-Automation-and-Scripting\week7\configuration.txt
         Write-Host "Updated!" | Out-String
        }
    



    # Exit
    elseif($choice -eq 3){
        Write-Host "Goodbye" | Out-String
        exit
       }
}
