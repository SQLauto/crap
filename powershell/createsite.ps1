Param(
    [Parameter(Mandatory=$true, HelpMessage="You must provide a display name for the website.")]
    $SiteName,
	[Parameter(Mandatory=$true, HelpMessage="You must provide a port for the website.")]
    $Port,
    [ValidatePattern("([\w-]+\.)+[\w-]+(/[\w- ;,./?%&=]*)?")]
	[Parameter(Mandatory=$true, HelpMessage="You must provide a host name for the website.")]
    $HostName,
    [ValidateSet("PROD", "PREPROD", "INTEG", "QUAL", "DEV")]
	[Parameter(Mandatory=$true, HelpMessage="You must set the environment for the website.")]
    $Environment="PROD",
    [ValidateSet("0", "1", "2", "3", "4")]
    $Identity="2",
    [ValidateSet("v1.1", "v2.0", "v4.0")]
	[Parameter(Mandatory=$true, HelpMessage="You must set the .Net version for the website.")]
    [string]$Runtime,
    [ValidateSet("Classic", "Integrated")]
	[Parameter(Mandatory=$true, HelpMessage="You must set the runtime mode for the website.")]
    [string]$Pipeline="Integrated"
    )

switch ($Identity)
    {
        0 {$FullIdentity="LocalSystem"}
        1 {$FullIdentity="LocalService"}
        2 {$FullIdentity="NetworkService"}
        3 {$FullIdentity="SpecificUser"}
        4 {$FullIdentity="ApplicationPoolIdentity"}
    }

Function Ask-YesOrNo
{
param([string]$title="Confirmation needed.",[string]$message="Parameters that will be used by the script are listed above.`nIf you want to modify one or more parameter, please restart the script and specify the wanted parameters.`nAny not defined parameter uses its default value.`r`nDo you want to continue with the above parameters?`n")
$choiceYes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Answer Yes."
$choiceNo = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "Answer No."
$options = [System.Management.Automation.Host.ChoiceDescription[]]($choiceYes, $choiceNo)
$nresult = $host.ui.PromptForChoice($title, $message, $options, 1)
switch ($nresult)
    {
        0 {"OK, we can continue..."}
        1 {"Bye bye!" ; exit}
    }
}

Write-Host "`n**********************************************************" -ForegroundColor Yellow
Write-Host "*`t`tAutomatic Website Creation" -ForegroundColor Yellow
Write-Host "*" -ForegroundColor Yellow
Write-Host "*" -ForegroundColor Yellow -nonewline; Write-Host " Parameters"
Write-Host "*" -ForegroundColor Yellow -nonewline; Write-Host " Website Name (-SiteName):`t`t" -nonewline; Write-Host "$SiteName" -ForegroundColor DarkGreen
Write-Host "*" -ForegroundColor Yellow -nonewline; Write-Host " Website Port (-Port):`t`t`t" -nonewline; Write-Host "$Port" -ForegroundColor DarkGreen
Write-Host "*" -ForegroundColor Yellow -nonewline; Write-Host " Website Hostname (-Hostname):`t`t" -nonewline; Write-Host "$HostName" -ForegroundColor DarkGreen
Write-Host "*" -ForegroundColor Yellow -nonewline; Write-Host " Website Environment (-Environment):`t" -nonewline; Write-Host "$Environment" -ForegroundColor DarkGreen
Write-Host "*" -ForegroundColor Yellow -nonewline; Write-Host " AppPool Identity (-Identity):`t`t" -nonewline; Write-Host "$FullIdentity ($Identity)" -ForegroundColor DarkGreen
Write-Host "*" -ForegroundColor Yellow -nonewline; Write-Host " Managed Runtime (-Runtime):`t`t" -nonewline; Write-Host "v$Runtime" -ForegroundColor DarkGreen
Write-Host "*" -ForegroundColor Yellow -nonewline; Write-Host " Managed Pipeline Mode (-Pipeline):`t" -nonewline; Write-Host "$Pipeline" -ForegroundColor DarkGreen
Write-Host "*" -ForegroundColor Yellow
Write-Host "**********************************************************" -ForegroundColor Yellow

Ask-YesOrNo
if ($nresult -eq "$false") {exit}
if ($Identity -eq "3") {
$AppPoolUser=Read-Host "`nPlease provide username for the ApplicationPool identity"
$AppPoolPwd=Read-Host "Please provide the password for '$AppPoolUser' user" -AsSecureString
}

function Read-Choice {
    Param(
        [System.String]$Message,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [System.String[]]$Choices,
        [System.Int32]$DefaultChoice=1,
        [System.String]$Title=[string]::Empty
    )
    [System.Management.Automation.Host.ChoiceDescription[]]$Poss=$Choices | ForEach-Object {
        New-Object System.Management.Automation.Host.ChoiceDescription "&$($_)", "Sets $_ as an answer."
    }
    $Host.UI.PromptForChoice($Title, $Message, $Poss, $DefaultChoice)
}

function Select-IPAddress {
    [cmdletbinding()]
    Param(
        [System.String]$ComputerName='localhost'
    )
    $IPs=Get-WmiObject -ComputerName $ComputerName -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled='True'" | ForEach-Object {
        $_.IPAddress
    } | Where-Object {
        $_ -match "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"
    }
 
    if($IPs -is [array]){
        Write-Host "`nServer $ComputerName uses these IP addresses:"
        $IPs | ForEach-Object {$Id=0} {Write-Host "${Id}: $_" -ForegroundColor Yellow; $Id++}
        $IPs[(Read-Choice -Message "`nChoose an IP Address" -Choices (0..($Id-1)) -DefaultChoice 0)]
    }
    else{$IPs}
}
$ChosenIP=Select-IPAddress
Write-Host "`nThe selected IP address is: $ChosenIP`n" -ForegroundColor DarkGreen
 
$SiteName += "-$Environment"
# Create the website directory
Write-Host "Creating application directory" -ForegroundColor Yellow
$WWWPath = "F:\sites"
$SitePath = "$WWWPath" + "\" + "$SiteName"
if (!(Test-Path $SitePath)) {
    New-Item -ItemType Directory -Path $SitePath
}
 
# Creates the website logfiles directory
Write-Host "Creating application logfiles directory" -ForegroundColor Yellow
$LogsPath = "F:\logs"
$SiteLogsPath = "$LogsPath" + "\" + "$SiteName"
if (!(Test-Path $SiteLogsPath)) {
    New-Item -ItemType Directory -Path $SiteLogsPath
} 

if ($Pipeline -eq "Integrated") {$PipelineMode="0"} else {$PipelineMode="1"}

Write-Host "Creating website application pool" -ForegroundColor Yellow
New-WebAppPool -Name $SiteName -Force
Set-ItemProperty ("IIS:\AppPools\" + $SiteName) -Name processModel.identityType -Value $Identity
if ($Identity -eq "3") {
Set-ItemProperty ("IIS:\AppPools\" + $SiteName) -Name processModel.username -Value $AppPoolUser
Set-ItemProperty ("IIS:\AppPools\" + $SiteName) -Name processModel.password -Value $AppPoolPwd
}
Set-ItemProperty ("IIS:\AppPools\" + $SiteName) -Name managedRuntimeVersion -Value $Runtime
Set-ItemProperty ("IIS:\AppPools\" + $SiteName) -Name managedPipelineMode -Value $PipelineMode

Write-Host "Creating website" -ForegroundColor Yellow
New-Website -Name $SiteName -Port $Port -HostHeader $HostName -PhysicalPath $SitePath -ApplicationPool $SiteName -Force
Set-ItemProperty ("IIS:\Sites\" + $SiteName) -Name logfile.directory -Value $SiteLogsPath

Start-WebAppPool -Name $SiteName
Start-WebSite $SiteName

Write-Host "Website $SiteName created!" -ForegroundColor DarkGreen