# PSPlexBackup.ps1

$Date = Get-Date -UFormat "%Y%m%d"
$PlexSource = “C:\Plex Media Server”
$BackupDest = “D:\Backup\”

$PlexXD = $PlexSource + “cache”
$PlexDest = $BackupDest + “PMS”
$PlexLog = $BackupDest + “PMSLog.txt”
$ZipDest = $BackupDest + “*”
$ZipFile = $BackupDest + “PlexBK” + $Date + “.7z”

Stop-Service -displayname “PlexService”

Reg export “HKCU\Software\Plex, Inc.\Plex Media Server” $PlexSource + “\plexkey.reg”

Robocopy $PlexSource $PlexDest /XD $PlexXD /MIR /E /NP /TEE /SEC /r:5 /w:5 /LOG+:$PlexLog

Start-Service -displayname “PlexService”

7z.exe a $ZipFile $ZipDest
