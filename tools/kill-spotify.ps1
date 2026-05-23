Write-Host "Killing Spotify processes..." -ForegroundColor Yellow
Get-Process -Name "Spotify" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 2
Write-Host "Spotify closed" -ForegroundColor Green