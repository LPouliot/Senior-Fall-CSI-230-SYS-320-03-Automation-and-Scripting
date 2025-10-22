. "C:\Users\champuser\Senior-Fall-CSI-230-SYS-320-03-Automation-and-Scripting\week7\Email.ps1"
. "C:\Users\champuser\Senior-Fall-CSI-230-SYS-320-03-Automation-and-Scripting\week7\Scheduler.ps1"
. "C:\Users\champuser\Senior-Fall-CSI-230-SYS-320-03-Automation-and-Scripting\week6\Event-Logs.ps1"

# Obtaining config
$configuration = Get-Content "C:\Users\champuser\Senior-Fall-CSI-230-SYS-320-03-Automation-and-Scripting\week7\Configuration.txt"

# Obtaining at risk users
$Failed = getFailedLogins 10

# Sending at risk users as email
SendAlertEmail ($Failed | Format-Table | Out-String)

# Setting the script to be run daily
ChooseTimeToRun($configuration[1])


