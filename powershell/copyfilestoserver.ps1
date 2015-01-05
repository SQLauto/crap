# Add to top of your scripts and the script will automatically create a log file called <script name>.log to the AppData folder 
# The location is in a folder called PS_Data. 
#
# If the location or file do not exist, this script will sort this out. If the script file grows large, it will archive by renaming the log file and create
# a new one.
#
# Has been designed to run in conjunction with trace32.exe - Configmr tool for reading SMS log files. It will record exception errors in your script file and 
# log them with the keyword 'error' so they are highlighted in trace32.exe. 
# 
# An additional function called sendl will allow you to easily write out to the log file - simply use sendl "message for log file". 
#

#region Log File Management 
$ScriptName = $MyInvocation.mycommand.name 
$LocalAppDir = "$(gc env:LOCALAPPDATA)\PS_Data" 
$LogName = $ScriptName.replace(".ps1", ".log") 
$MaxLogFileSizeMB = 5 # After a log file reaches this size it will archive the existing and create a new one 

trap
[Exception] { 
sendl
"error: $($_.Exception.GetType().Name) - $($_.Exception.Message)" 
} 
function LogFileCheck 
{
if (!(Test-Path $LocalAppDir)) # Check if log file directory exists - if not, create and then create log file for this script. 
{
mkdir $LocalAppDir 
New-Item "$LocalAppDir\$LogName" -type file 
break 
}
if
(Test-Path "$LocalAppDir\$LogName")  {
if (((gci "$LocalAppDir\$LogName").length/1MB) -gt $MaxLogFileSizeMB) # Check size of log file - to stop unweildy size, archive existing file if over limit and create fresh. 
{
$NewLogFile = $LogName.replace(".log", " ARCHIVED $(Get-Date -Format dd-MM-yyy-hh-mm-ss).log") 
ren "$LocalAppDir\$LogName" "$LocalAppDir\$NewLogFile" 
}
}
}
function sendl ([string]$message) # Send to log file 
{
$toOutput
= "$(get-date) > $message " | Out-File "$LocalAppDir\$LogName" -append -NoClobber 
}
LogFileCheck


[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
Get-Credential domain\usermname
$Server = [Microsoft.VisualBasic.Interaction]::InputBox("Enter Location of Server List (Ex: 'c:\servers.txt')", "Server List", "$env:ServerList")
$FileLocation = [Microsoft.VisualBasic.Interaction]::InputBox("Enter File Location (Ex: 'C:\tool.exe')", "File Location", "$env:FileLocation")
$FileDestination = [Microsoft.VisualBasic.Interaction]::InputBox("Enter File Destination (Ex: 'windows\system32')", "File Destination", "$env:FileDestination")
Get-Content $Server | foreach {Copy-Item $FileLocation -Destination \\$_\c$\$FileDestination}