# Display only logs that contain 505 (Not Found) or 400 (Bad Request)
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ' , ' 400 '