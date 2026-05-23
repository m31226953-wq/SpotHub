# ============================================
# Disable Updates Patch
# ============================================

$spotifyPath = "$env:LOCALAPPDATA\Spotify"

# Патчим настройки
$settings = "$spotifyPath\prefs"
if (Test-Path $settings) {
    Add-Content $settings "app.update.disabled=true"
    Add-Content $settings "app.update.auto=false"
    Add-Content $settings "app.update.enabled=false"
}

# Блокируем обновы через hosts
$hosts = "$env:SystemRoot\System32\drivers\etc\hosts"
$updateDomains = @(
    "upgrade.spotify.com",
    "spotify-upgrade.akamaized.net",
    "api.spotify.com/v1/upgrade"
)

foreach ($domain in $updateDomains) {
    $entry = "127.0.0.1 $domain"
    if (-not (Select-String -Path $hosts -Pattern $domain -ErrorAction SilentlyContinue)) {
        Add-Content $hosts $entry
    }
}

Write-Host "UPDATES DISABLED PATCH APPLIED" -ForegroundColor Green