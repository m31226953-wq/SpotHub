# ============================================
# SpotHub - Ultimate Spotify Patcher (ALL-IN-ONE)
# ============================================

param([switch]$Restore)

Write-Host "SPOTHUB v1.0 - ALL IN ONE PATCHER" -ForegroundColor Cyan
Write-Host ""

# Check Admin
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "RUN AS ADMINISTRATOR!" -ForegroundColor Red
    pause
    exit
}

# Restore mode
if ($Restore) {
    $backupPath = "$env:USERPROFILE\SpotHubBackup"
    $spotifyPath = "$env:LOCALAPPDATA\Spotify\Apps"
    if (Test-Path $backupPath) {
        Copy-Item -Path "$backupPath\*" -Destination $spotifyPath -Recurse -Force
        Write-Host "Spotify restored!" -ForegroundColor Green
    }
    pause
    exit
}

# Kill Spotify
Write-Host "Closing Spotify..." -ForegroundColor Yellow
Get-Process -Name "Spotify" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 2

# Backup
$backupPath = "$env:USERPROFILE\SpotHubBackup"
$spotifyPath = "$env:LOCALAPPDATA\Spotify\Apps"
if (Test-Path $spotifyPath) {
    Write-Host "Creating backup..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Force -Path $backupPath | Out-Null
    Copy-Item -Path $spotifyPath -Destination $backupPath -Recurse -Force
}

# Find JS files
$jsFiles = @(
    "$spotifyPath\xpui.js",
    "$spotifyPath\web-player.js",
    "$spotifyPath\bootstrap.js"
)

# PATCH 1: BLOCK ADS
Write-Host "Applying ADS BLOCKER..." -ForegroundColor Yellow
foreach ($file in $jsFiles) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -ErrorAction SilentlyContinue
        if ($content) {
            $content = $content -replace 'adsEnabled:!0', 'adsEnabled:!1'
            $content = $content -replace 'showAd\(', '//showAd('
            $content = $content -replace 'bannerAd', 'null'
            $content = $content -replace 'interstitialAd', 'null'
            $content = $content -replace 'videoAdPlayer', 'null'
            $content = $content -replace 'preRollEnabled', 'false'
            $content = $content -replace 'midRollEnabled', 'false'
            Set-Content $file $content -NoNewline -ErrorAction SilentlyContinue
            Write-Host "  Patched: $(Split-Path $file -Leaf)" -ForegroundColor Green
        }
    }
}

# PATCH 2: UNLOCK PREMIUM
Write-Host "Applying PREMIUM UNLOCK..." -ForegroundColor Yellow
foreach ($file in $jsFiles) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -ErrorAction SilentlyContinue
        if ($content) {
            $content = $content -replace 'isPremium:!1', 'isPremium:!0'
            $content = $content -replace '"product":"free"', '"product":"premium"'
            $content = $content -replace 'canPlaySkip:!1', 'canPlaySkip:!0'
            $content = $content -replace 'hasTrial:!1', 'hasTrial:!0'
            $content = $content -replace '"type":"free"', '"type":"premium"'
            $content = $content -replace 'paidSubscription:!1', 'paidSubscription:!0'
            Set-Content $file $content -NoNewline -ErrorAction SilentlyContinue
            Write-Host "  Patched: $(Split-Path $file -Leaf)" -ForegroundColor Green
        }
    }
}

# PATCH 3: DISABLE UPDATES
Write-Host "Disabling updates..." -ForegroundColor Yellow
$prefsFile = "$env:LOCALAPPDATA\Spotify\prefs"
if (Test-Path $prefsFile) {
    Add-Content $prefsFile "app.update.disabled=true"
    Add-Content $prefsFile "app.update.auto=false"
    Write-Host "  Updates disabled" -ForegroundColor Green
}

# PATCH 4: BLOCK TELEMETRY
Write-Host "Blocking telemetry..." -ForegroundColor Yellow
$hostsPath = "$env:SystemRoot\System32\drivers\etc\hosts"
$domains = @(
    "0.0.0.0 analytics.spotify.com",
    "0.0.0.0 config.spotify.com",
    "0.0.0.0 crashdump.spotify.com",
    "0.0.0.0 log.spotify.com",
    "0.0.0.0 events.spotify.com",
    "0.0.0.0 ping.spotify.com"
)

foreach ($entry in $domains) {
    $domain = $entry.Split()[1]
    $exists = Select-String -Path $hostsPath -Pattern $domain -ErrorAction SilentlyContinue
    if (-not $exists) {
        Add-Content -Path $hostsPath -Value $entry
        Write-Host "  Blocked: $domain" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "SPOTHUB INSTALLED SUCCESSFULLY!" -ForegroundColor Green
Write-Host ""

# Launch Spotify
$spotifyExe = "$env:LOCALAPPDATA\Spotify\Spotify.exe"
if (Test-Path $spotifyExe) {
    Start-Process $spotifyExe
} else {
    Write-Host "Launch Spotify manually" -ForegroundColor Yellow
}

pause
