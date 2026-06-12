<#
.SYNOPSIS
    PowerShell Script to List the Status of Service Applications, and then Start/Stop them if required.

.DESCRIPTION
    PowerShell Script to List the Status of Service Applications, and then Start/Stop them if
    required.

.EXAMPLE
    PS C:\> .\SP2010GetStartStopSPServices.ps1
    PowerShell Script to List the Status of Service Applications, and then Start/Stop them if required.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://get-spscripts.com/2011/12/manage-services-on-sharepoint-servers.html
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

## 1. First Get a list of all Service Applications, along with their Status and Ids

Get-SPServiceInstance -Server "YourMachineName" | sort TypeName | Format-Table -AutoSize

## 2. Now take either the Service Application Name (TypeName) or Id and put this into either commands below to Start / Stop the Service

Get-SPServiceInstance -Server "YourMachineName"  | where-object {$_.TypeName -eq "YourApplicationName" } | Start-SPServiceInstance -Confirm:$false

Get-SPServiceInstance -Server "YourMachineName"  | where-object {$_.TypeName -eq "YourApplicationName" } | Stop-SPServiceInstance -Confirm:$false

# Or using the Id

Start-SPServiceInstance -Identity "YourIdGUID" -Confirm:$false

Stop-SPServiceInstance -Identity "YourIdGUID" -Confirm:$false