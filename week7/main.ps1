. (Join-Path $PSScriptRoot Email.ps1)
. (Join-Path $PSScriptRoot Scheduler.ps1)
. (Join-Path $PSScriptRoot Configuration.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

# Obtaining config
$configuration = 

# Obtaining at risk users
$Failed = atRiskUsers $failedloginsTable.get

# Sending at risk users as email
SendAlertEmail ($Failed | Format-Table | Out-String)

# Setting the script to be run daily
ChooseTimeToRun($scheduledTasks.daily)


