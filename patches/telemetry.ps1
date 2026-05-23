# ============================================
# Block Telemetry Patch
# ============================================

$hosts = "$env:SystemRoot\System32\drivers\etc\hosts"

$telemetryDomains = @(
    "0.0.0.0 analytics.spotify.com",
    "0.0.0.0 config.spotify.com",
    "0.0.0.0 crashdump.spotify.com",
    "0.0.0.0 log.spotify.com",
    "0.0.0.0 events.spotify.com",
    "0.0.0.0 ping.spotify.com"
)

foreach ($entry in $telemetryDomains) {
    $domain = $entry.Split()[1]
    if (-not (Select-String -Path $hosts -Pattern $domain -ErrorAction SilentlyContinue)) {
        Add-Content $hosts $entry
        Write-Host "Blocked: $domain" -ForegroundColor Gray
    }
}

Write-Host "TELEMETRY BLOCK PATCH APPLIED" -ForegroundColor Green