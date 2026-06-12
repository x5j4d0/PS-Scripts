<#
.SYNOPSIS
    PowerShell Script to Get All MSOnline Groups that have not been Synchronised via DirSync (o365).

.DESCRIPTION
    PowerShell Script to Get All MSOnline Groups that have not been Synchronised via DirSync
    (o365).

.EXAMPLE
    PS C:\> .\GetMSOnlineGroupsWithoutLastDirSyncTime.ps1
    PowerShell Script to Get All MSOnline Groups that have not been Synchronised via DirSync (o365).

.NOTES
    Requires:   MSOnline, MSOnlineExtended
#>

Import-Module MSOnline
Import-Module MSOnlineExtended
$cred=Get-Credential
Connect-MsolService -Credential $cred

## Retrieve the Groups that don't have a last DirSyncTime
$objDistributionGroups = Get-MSolgroup -All | where lastdirsynctime -eq $null
Foreach
($objDistributionGroup in $objDistributionGroups)

{

Write-host "$($objDistributionGroup.DisplayName + ', ' + $objDistributionGroup.EmailAddress)"

}
