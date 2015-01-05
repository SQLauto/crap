<#
.SYNOPSIS
    CountFiles - File counter and timer.
.DESCRIPTION
    CountFiles - Counts files under the specified path and times the operation progress in real time.
.PARAMETER Path
    Sets the directory where the files will be counted.
.NOTES
    File Name  : CountFiles.ps1
    Author     : Fabrice ZERROUKI - fabricezerrouki@hotmail.com
.EXAMPLE
    PS D:\>CountFiles.ps1 -path D:\Docs
    The script will count all the files (recurse) under D:\Docs and display its progress in real time.
.EXAMPLE
    PS D:\Scripts\>CountFiles.ps1
    The script will count all the files (recurse) under D:\Scripts\ (the current directory) and display its progress in real time.
#>
function Count-Files {
	Param (
		[Parameter(ValueFromPipeline=$True,HelpMessage="Please enter a valid path.")]
		[ValidateScript({((Test-Path $_) -and (Test-Path $_ -PathType 'Container'))})]
		[string]$Path=$pwd
	)
	Write-Host "`nDefined path is `"$Path`"`n" -ForegroundColor Yellow

	function time_pipeline {
	param ($increment=1000)
	begin{$i=0 ; $timer=[diagnostics.stopwatch]::startnew()}
	process {
		$i++
		if (!($i % $increment)) { Write-Host `Processed $i in $($timer.elapsed.totalseconds) seconds -nonewline }
		$_
    }
	end {
		Write-Host `Processed $i files in $($timer.elapsed.totalseconds) seconds
		Write-Host "`tAverage rate: $([int]($i/$timer.elapsed.totalseconds)) files/sec.`n"
		}
	}
	Get-ChildItem $Path -Recurse | Where { ! $_.PSIsContainer } | time_pipeline | Set-Variable files
}