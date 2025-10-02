
# Dot notation
. C:\Users\champuser\Senior-Fall-CSI-230-SYS-320-03-Automation-and-Scripting\week5\ScrapingChamplain\ScapesTable.ps1

# Function call 
$Classes = gatherClasses

$ClassesWTranslator = daysTranslator $Classes 

<#
$ClassesWTranslator | Format-Table -Autosize
#>

# List all the classes of Instructor Furkan Paligu
<#
 $ClassesWTranslator | select "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
              where {$_."Instructor" -ilike "Furkan Paligu"}
#>

# List all the classes of JOYC 310 Mondays, only display Class Code and Times
# Sort by Start Time

<#
$ClassesWTranslator | Where-Object {( $_.Location -ilike "JOYC 310") -and ($_.days -contains "Monday")} |`
                     Sort-Object "Time Start" | `
                     Select-Object "Time Start", "Time End", "Class Code"
                     #>

# Make a list of all instructors that teach at least 1 course in 
# SYS, SEC, NET, FOR, CSI, DAT
# Sort by name, and make it unique

$ITSInstructors = $ClassesWTranslator | Where-Object { ($_."Class Code" -ilike "SYS*") -or `
                                              ($_."Class Code" -ilike "NET*") -or `
                                              ($_."Class Code" -ilike "SEC*") -or `
                                              ($_."Class Code" -ilike "FOR*") -or `
                                              ($_."Class Code" -ilike "CSI*") -or `
                                              ($_."Class Code" -ilike "DAT*") } `
                             | Sort-Object "Instructor" `
                             | Select-Object "Instructor" -Unique
# $ITSInstructors 

# Group all the instructors by the number of classes they are teaching, sort by the number of classes they are teaching
$ClassesWTranslator | Where-Object { $_.Instructor -in $ITSInstructors.Instructor } `
                    | Group-Object "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending

                             