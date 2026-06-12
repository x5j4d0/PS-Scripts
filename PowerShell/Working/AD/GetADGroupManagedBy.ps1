<#
.SYNOPSIS
    PowerShell Script to Get AD Groups Details Including the Manager (ManagedBy) Property.

.DESCRIPTION
    PowerShell Script to Get AD Groups Details Including the Manager (ManagedBy) Property.

.PARAMETER GroupName
    Provide your Group Name filter, or leave blank to report on all Groups in the domain.

.PARAMETER ReportPath
    Change this path to match your environment.

.EXAMPLE
    PS C:\> .\GetADGroupManagedBy.ps1
    Edit the variables section and run to powerShell Script to Get AD Groups Details Including the Manager (ManagedBy) Property.

.NOTES
    Requires:   ActiveDirectory
#>

### Start Variables ###
$GroupName = "Sharepoint" #Provide your Group Name filter, or leave blank to report on all Groups in the domain
$ReportPath = "C:\ztemp\Scripts\GetADGroupsReport.csv" #Change this path to match your environment
### End Variables ###

Import-Module ActiveDirectory

Get-ADGroup -filter * -property Managedby | Where {$_.name -like "*$GroupName*"}| select Name, @{N='Managedby';E={$_.Managedby.Substring($_.Managedby.IndexOf("=") + 1, $_.Managedby.IndexOf(",") - $_.Managedby.IndexOf("=") - 1)}} | Export-CSV "$ReportPath" -NoTypeInformation -Encoding "Default"