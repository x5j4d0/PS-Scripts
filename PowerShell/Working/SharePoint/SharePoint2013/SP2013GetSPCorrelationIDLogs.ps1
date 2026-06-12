<#
.SYNOPSIS
    PowerShell Script to Check ULS logs and Merge the Correlation ID Events into One Log File.

.DESCRIPTION
    PowerShell Script to Check ULS logs and Merge the Correlation ID Events into One Log
    File.

.PARAMETER CorrelationID
    Provide your Correlation ID GUID here.

.PARAMETER LogFile
    Change this log path to suit your environment.

.EXAMPLE
    PS C:\> .\SP2013GetSPCorrelationIDLogs.ps1
    Edit the variables section and run to powerShell Script to Check ULS logs and Merge the Correlation ID Events into One Log File.
#>

Add-PSSnapIn Microsoft.SharePoint.PowerShell

$CorrelationID = "d9e7c69c-f2a5-f061-86b8-afda705c908c" #Provide your Correlation ID GUID here
$LogFile = "C:\BoxBuild\SPError.log" #Change this log path to suit your environment
Merge-SPLogFile -Path "$LogFile" -Correlation "$CorrelationID"
