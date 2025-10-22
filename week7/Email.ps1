function SendAlertEmail($Body){
    $From = "lily.pouliot@mymail.champlain.edu"
    $To = "lily.pouliot@mymail.champlain.edu"
    $Subject = "Suspicious Activity"

<<<<<<< HEAD
    $Password = "**Password goes Here**" | ConvertTo-SecureString -AsPlainText -Force
=======
    $Password = "**password goes here**" | ConvertTo-SecureString -AsPlainText -Force
>>>>>>> 840c29dad95beb208aef4199226d9b8e473de28d
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

    Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
    -port 587 -UseSsl -Credential $Credential
    }

SendAlertEmail "Body of email" 


