cd $PSScriptRoot

$files=Get-ChildItem

$folderpath = "$PSScriptRoot/outfolder/"
$filepath = Join-Path $folderpath "out.csv"

#List all the files that has the extension ".psq"
#Save the results to out.csv file

$files | Where-Object { $_.Extension -eq ".ps1" } | `
Export-Csv -Path $filepath
