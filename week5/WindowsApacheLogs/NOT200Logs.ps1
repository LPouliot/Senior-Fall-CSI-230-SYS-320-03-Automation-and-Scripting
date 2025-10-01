# Display only logs that does NOT contain 200 (ok)
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch