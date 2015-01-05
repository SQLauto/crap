[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null
$s = New-Object ('Microsoft.SqlServer.Management.Smo.Server') "LOCALHOST"

$dbs=$s.Databases

#Retrieves the last backup dates - both for FULL and LOG backups
$dbs | SELECT Name,LastBackupDate, LastLogBackupDate | Format-Table -autosize 