# From every .log file in the directory, only get logs that contains the word 'error'
$A = Get-Content C:\xampp\apache\logs\*.log | Select-String -Pattern 'error'

# Display last 5 elements of the result array 
$A[-5..-1]