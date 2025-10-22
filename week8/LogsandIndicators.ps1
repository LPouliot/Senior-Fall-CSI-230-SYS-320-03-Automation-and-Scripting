
function ApacheLogs(){

$logsNotFormatted = Get-Content C:\Users\champuser\Downloads\access.log 

$tableRecords = @()

for ($i=0; $i -lt $logsNotFormatted.Length; $i++) {

# Split a string into words
$words = $logsNotFormatted[$i].Split(" ");

for($i=0; $i -lt $logsNotFormatted.Length; $i++) {
    $words = $logsNotFormatted[$i].Split(" ");
    $tableRecords += [PSCustomObject]@{ "IP" = $words[0]; `
                                        "Time" = $words[3].Trim('['); `
                                        "Method" = $words[5].Trim('"'); `
                                        "Page" = $words[6]; `
                                        "Protocol" = $words[7].Trim('"'); `
                                        "Response" = $words[8]; `
                                        "Refrrer" = $words[10]; `
                                        }
                                    }
                                }


$filtered =  $tableRecords | Where-Object `
                                          {($_.Page -ilike "*etc/passwd*") `
                                       -or ($_.Page -ilike "*cmd=*") `
                                       -or ($_.Page -ilike "*/bin/bash*") `
                                       -or ($_.Page -ilike "*/bin/sh*") `
                                       -or ($_.Page -ilike "*1=1#*") `
                                       -or ($_.Page -ilike "*1=1--*") }

return $filtered | Where-Object {$_.IP -ilike "10.*" }

  }

$GetApacheLogs = ApacheLogs | Format-Table -AutoSize -Wrap

$GetApacheLogs