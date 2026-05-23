# 🎵 SPOTHUB | Ультимальный патчер Spotify

### Блок рекламы · Премиум · Отключение обновлений · Блок телеметрии

![Windows](https://img.shields.io/badge/Windows-10%2F11-0078D6?style=flat&logo=windows&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-5391FE?style=flat&logo=powershell&logoColor=white)
![GitHub](https://img.shields.io/badge/Open%20Source-%E2%9C%93-brightgreen)
![License](https://img.shields.io/badge/License-MIT-red)

---

## 🚀 ОДНА КОМАНДА ДЛЯ УСТАНОВКИ

**Открой PowerShell и вставь это:**

iex (iwr -UseBasicParsing 'https://raw.githubusercontent.com/m31226953-wq/SpotHub/main/SpotHub.ps1').Content

**Всё. Не нужен Git. Не нужны скачивания. Никакого говна.**

---

## ✨ Что делает

| Функция | Статус | Описание |
|---------|--------|----------|
| Блок рекламы | ✅ | Аудио, видео, баннеры — ВСЁ |
| Премиум | ✅ | Безлимитные пропуски, любые треки |
| Отключение обновлений | ✅ | Spotify никогда не обновится |
| Блок телеметрии | ✅ | Никакой аналитики |
| Авто-бекап | ✅ | Оригинальные файлы сохранены |
| Восстановление | ✅ | Одна команда чтобы вернуть всё |

---

## 📁 Что патчится

JavaScript файлы:
- %LOCALAPPDATA%\Spotify\Apps\xpui.js
- %LOCALAPPDATA%\Spotify\Apps\web-player.js
- %LOCALAPPDATA%\Spotify\Apps\bootstrap.js

Записи в hosts файл:

0.0.0.0 analytics.spotify.com
0.0.0.0 config.spotify.com
0.0.0.0 crashdump.spotify.com
0.0.0.0 log.spotify.com
0.0.0.0 events.spotify.com
0.0.0.0 ping.spotify.com
127.0.0.1 upgrade.spotify.com

Настройки Spotify:

app.update.disabled=true
app.update.auto=false

---

## 🔄 Как восстановить

Вернуть Spotify в исходное состояние:

iex (iwr -UseBasicParsing 'https://raw.githubusercontent.com/m31226953-wq/SpotHub/main/SpotHub.ps1').Content -Restore

---

## ✅ Как проверить что работает

Проверка hosts файла:

Get-Content "$env:SystemRoot\System32\drivers\etc\hosts" | Select-String "spotify"

Проверка в Spotify:
1. Открой Spotify с БЕСПЛАТНЫМ аккаунтом
2. Нет рекламы
3. Работают безлимитные пропуски
4. Можно включить любую песню

---

## 📋 Требования

- Windows 10 или 11
- Spotify (обычная версия, НЕ из Microsoft Store)
- PowerShell (встроен в Windows)

---

## 💾 Где хранится бекап

%USERPROFILE%\SpotHubBackup

---

## ⚠️ Предупреждение

Только для образовательных целей. Используй на свой страх и риск.

---

## ⭐ Поставь звезду

Если работает — нажми звезду на GitHub!

---

**Сделано CobraStudio**
