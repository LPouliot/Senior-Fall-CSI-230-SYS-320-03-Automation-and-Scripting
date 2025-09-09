#Without Changing the directory (no outfolder)
#Find every .csv file recursively and change their extentions to .log
#Recursively display all the files (not directories)

$files=Get-ChildItem -Recurse -File
$files | Rename-Item -NewName { $_.Name -replace '.csv', '.log' }
Get-ChildItem -Recurse -File