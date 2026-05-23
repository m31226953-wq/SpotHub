# ============================================
# SpotHub - Main Installer
# ============================================

param([switch]$Restore)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

if ($Restore) {
    & "$scriptDir\tools\restore-spotify.ps1"
    exit
}

Write-Host "SPOTHUB INSTALLER" -ForegroundColor Cyan

# Закрываем Spotify
& "$scriptDir\tools\kill-spotify.ps1"

# Делаем бекап
& "$scriptDir\tools\backup-spotify.ps1"

# ПРИМЕНЯЕМ ВСЕ ПАТЧИ
Write-Host "APPLYING PATCHES..." -ForegroundColor Yellow

& "$scriptDir\patches\ads.ps1"
& "$scriptDir\patches\premium.ps1"
& "$scriptDir\patches\updates.ps1"
& "$scriptDir\patches\telemetry.ps1"

Write-Host "SPOTHUB INSTALLED SUCCESSFULLY!" -ForegroundColor Green

# Запускаем Spotify
Start-Process "$env:LOCALAPPDATA\Spotify\Spotify.exe"