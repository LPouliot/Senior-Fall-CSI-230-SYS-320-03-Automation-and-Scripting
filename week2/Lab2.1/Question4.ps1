# If an instance of it is not running already, starts Google Chrome web browser
# If an instance is already running, stop it.


if (Get-Process chrome -ErrorAction SilentlyContinue) {
    Write-Host "Chrome is currently on, shutting down..."
    Stop-Process -Name chrome 
} else {
    Write-Host "Chrome is currently off, turning on.."
    Write-Host "Moving to Champlain.edu"
    Start-Process chrome "https://champlain.edu"
}

