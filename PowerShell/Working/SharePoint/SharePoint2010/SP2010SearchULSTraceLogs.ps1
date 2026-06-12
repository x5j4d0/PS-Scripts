<#
.SYNOPSIS
    PowerShell Script to Search for Strings or Correlation IDs in ULS / Trace Logs Across a Farm.

.DESCRIPTION
    PowerShell Script to Search for Strings or Correlation IDs in ULS / Trace Logs Across a
    Farm.

.PARAMETER Servers
    Add the SharePoint Servers you want to query the ULS logs on here.

.PARAMETER SearchPattern
    Add your Correlation ID or Search Pattern here.

.PARAMETER LogDirectory
    Change this path to match the location of the Farm ULS logs.

.EXAMPLE
    PS C:\> .\SP2010SearchULSTraceLogs.ps1
    Edit the variables section and run to powerShell Script to Search for Strings or Correlation IDs in ULS / Trace Logs Across a Farm.
#>

$Servers = "SPWEB1","SPWEB2" #Add the SharePoint Servers you want to query the ULS logs on here
 
$MyScript = { 
#search for specific keywords and specific duration 
$SearchPattern = "539c059d-12a1-f061-86b8-a3aa7335ea67" #Add your Correlation ID or Search Pattern here
[int] $LogDuration = "60" #Specify how far in minutes you want to go back in the ULS logs
 
$LogDirectory = "C:\Data\SharePoint\Logs\ULS\*.log" #Change this path to match the location of the Farm ULS logs
$LastLogTime = (Get-Date).AddMinutes(-$LogDuration) 
$LogFiles = Get-ChildItem -Path $LogDirectory | Where-Object {$_.LastWriteTime -gt $LastLogTime} 
Write-Output "Matching files for the mentioned duration are: $LogFiles" | Out-file -FilePath "C:\BoxBuild\SPTraceLogs\ParsedLogs.txt"
foreach($file in $LogFiles) 
{ 
    Write-Output "" | Out-file -FilePath "C:\BoxBuild\SPTraceLogs\ParsedLogs.txt"  -Append 
    Write-Output "Matching logs from $file are as..." | Out-file -FilePath "C:\BoxBuild\SPTraceLogs\ParsedLogs.txt" -Append 
    Write-Output "==================================" | Out-file -FilePath "C:\BoxBuild\SPTraceLogs\ParsedLogs.txt" -Append 
    Select-String -Path $file -Pattern $SearchPattern -SimpleMatch -AllMatches| Out-file -FilePath "C:\BoxBuild\SPTraceLogs\ParsedLogs.txt" -Append 
} 
 
} 
 
Invoke-Command -ComputerName $Servers -ScriptBlock $MyScript 
 
$Path = Split-Path $MyInvocation.MyCommand.Path 
foreach($Server in $Servers) 
{ 
    $LocalPath = $Path + "\ParsedSPLogs-$Server.txt" 
    Copy-Item -Path "\\$Server\C$\Boxbuild\SPTraceLogs\ParsedLogs.txt" -Destination $LocalPath -Force #Change this path to match the location of where the script is run from
} 