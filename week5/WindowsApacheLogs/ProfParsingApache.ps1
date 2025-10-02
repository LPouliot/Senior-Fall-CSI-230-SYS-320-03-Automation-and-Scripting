Select-String "/$page " | Select-String " $httpc " | Select-String " $browser/"

return $logsNotformatted


# $logsNotformatted = ApacheLogs1 "*" "404" "Chrome"
# $logsNotformatted


# --------------------------------------------------------------------
# Parsing Apache Logs Assignment 
# (this is a more structured, better approach to analyzing apache logs.
# They do the earlier assignments to learn Get-Content, Select-String)
# --------------------------------------------------------------------
function ApacheLogs1(){
$logsNotformatted = Get-Content C:\xampp\apache\logs\access.log
$tableRecords = @()

for($i=0; $i -lt $logsNotformatted.Count; $i++){

# split a string into words
$words = $logsNotformatted[$i].Split(" ");

 $tableRecords += [pscustomobject]@{ "IP" = $words[0]; `
                                     "Time" = $words[3].Trim('['); `
                                     "Method" = $words[5].Trim('"'); `
                                     "Page" = $words[6]; `
                                     "Protocol" = $words[7]; `
                                     "Response" = $words[8]; `
                                     "Referrer" = $words[10]; `
                                     "Client" = $words[11..($words.Length - 2)]; }
} # end of for loop
return $tableRecords | Where-Object { $_.IP -ilike "10.*" }
}
$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap