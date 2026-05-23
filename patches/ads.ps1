# ============================================
# Ads Blocker Patch
# ============================================

$spotifyPath = "$env:LOCALAPPDATA\Spotify\Apps"

# Файлы которые патчим
$files = @(
    "$spotifyPath\xpui.js",
    "$spotifyPath\web-player.js",
    "$spotifyPath\bootstrap.js"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        
        # ЗАМЕНЫ ДЛЯ БЛОКА РЕКЛАМЫ
        $content = $content -replace 'adsEnabled:!0', 'adsEnabled:!1'
        $content = $content -replace 'showAd\(', '//showAd('
        $content = $content -replace 'bannerAd', 'null'
        $content = $content -replace 'interstitialAd', 'null'
        $content = $content -replace 'videoAdPlayer', 'null'
        $content = $content -replace '\.displayAd\(', '//.displayAd('
        $content = $content -replace 'preRollEnabled', 'false'
        $content = $content -replace 'midRollEnabled', 'false'
        
        Set-Content $file $content -NoNewline
        Write-Host "Patched: $file" -ForegroundColor Green
    }
}

Write-Host "ADS BLOCKER PATCH APPLIED" -ForegroundColor Green