$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$backupPath = "$scriptDir\..\bin\backups"
$spotifyPath = "$env:LOCALAPPDATA\Spotify\Apps"

if (Test-Path $backupPath) {
    Copy-Item -Path "$backupPath\*" -Destination $spotifyPath -Recurse -Force
    Write-Host "Restored from backup" -ForegroundColor Green
}