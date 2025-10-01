# From every file with .log extension in the directory, only get logs that contain the word "error"
$A = Get-Content C:\xampp\apache\logs\*.log | Select-String -Pattern 'error'

#Display the last 5 elements of the result array
$A[-5..-1]