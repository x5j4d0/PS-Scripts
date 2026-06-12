<#
.SYNOPSIS
    PowerShell Script to List All Web Sites within IIS, and Exports these to a CSV file.

.DESCRIPTION
    PowerShell Script to List All Web Sites within IIS, and Exports these to a CSV file.

.EXAMPLE
    PS C:\> .\IIS_Get_Web_Sites.ps1
    PowerShell Script to List All Web Sites within IIS, and Exports these to a CSV file.

.NOTES
    Requires:   WebAdministration
#>

Import-Module WebAdministration

get-website | select name,id,state,physicalpath, 
@{n="Bindings"; e= { ($_.bindings | select -expa collection) -join ';' }} ,
@{n="LogFile";e={ $_.logfile | select -expa directory}}, 
@{n="attributes"; e={($_.attributes | % { $_.name + "=" + $_.value }) -join ';' }} |
Export-Csv -NoTypeInformation -Path "C:\IIS_Web_Sites.csv" #Change this path to suit your environment