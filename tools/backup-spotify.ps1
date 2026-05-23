$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$backupPath = "$scriptDir\..\bin\backups"
$spotifyPath = "$env:LOCALAPPDATA\Spotify\Apps"

New-Item -ItemType Directory -Force -Path $backupPath | Out-Null

if (Test-Path $spotifyPath) {
    Copy-Item -Path $spotifyPath -Destination $backupPath -Recurse -Force
    Write-Host "Backup saved to $backupPath" -ForegroundColor Green
}