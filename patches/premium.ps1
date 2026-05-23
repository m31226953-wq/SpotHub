# ============================================
# Premium Unlock Patch
# ============================================

$spotifyPath = "$env:LOCALAPPDATA\Spotify\Apps"

$files = @(
    "$spotifyPath\xpui.js",
    "$spotifyPath\web-player.js"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        
        # ЗАМЕНЫ ДЛЯ ПРЕМИУМА
        $content = $content -replace 'isPremium:!1', 'isPremium:!0'
        $content = $content -replace '"product":"free"', '"product":"premium"'
        $content = $content -replace 'canPlaySkip:!1', 'canPlaySkip:!0'
        $content = $content -replace 'hasTrial:!1', 'hasTrial:!0'
        $content = $content -replace '"type":"free"', '"type":"premium"'
        $content = $content -replace 'paidSubscription:!1', 'paidSubscription:!0'
        
        Set-Content $file $content -NoNewline
        Write-Host "Patched: $file" -ForegroundColor Green
    }
}

Write-Host "PREMIUM UNLOCK PATCH APPLIED" -ForegroundColor Green