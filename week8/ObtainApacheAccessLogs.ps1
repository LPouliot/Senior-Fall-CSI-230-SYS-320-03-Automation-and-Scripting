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
                                        "Client" = $words[11..($words.Count - 1)] -join ' ' 
                                        }
                                    }
                                }

return $tableRecords | Where-Object {$_.IP -ilike "10.*" }

}

$GetApacheLogs = ApacheLogs | Format-Table -AutoSize -Wrap

$GetApacheLogs
