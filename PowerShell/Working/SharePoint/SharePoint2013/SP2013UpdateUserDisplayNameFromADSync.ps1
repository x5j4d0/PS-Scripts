<#
.SYNOPSIS
    PowerShell Script To Update User Display Names (DisplayName) From AD.

.DESCRIPTION
    PowerShell Script To Update User Display Names (DisplayName) From AD.

.PARAMETER SPWeb
    Change this to match your environment.

.PARAMETER Domain
    Change this domain syntax to match your DC properties.

.EXAMPLE
    PS C:\> .\SP2013UpdateUserDisplayNameFromADSync.ps1
    Edit the variables section and run to powerShell Script To Update User Display Names (DisplayName) From AD.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

##### Begin Variables #####
$SPWeb = "https://yourwebapp.com" #Change this to match your environment
$Domain = "*YourDomain*" #Change this domain syntax to match your DC properties
$LogFilePrior = "C:\BoxBuild\LogFilePrior.txt"
$LogFileAfter = "C:\BoxBuild\LogFileAfter.txt"
##### End Variables #####

## Display all the user accounts for the SPWeb Prior to the AD Sync

Get-SPUser –Web $SPWeb | Where-Object {$_.UserLogin –like $Domain} | Out-File -FilePath $LogFilePrior

## Display a count of all the user accounts for the SPWeb

Get-SPUser –Web $SPWeb | Where-Object {$_.UserLogin –like $Domain} | Measure-Object | Out-File -FilePath $LogFilePrior -Append

## Now run the command to update the accounts with a Sync from Active Dirtecory (AD)

Get-SPUser –Web $SPWeb | Set-SPUser –SyncFromAD

## Display all the user accounts for the SPWeb After the AD Sync

Get-SPUser –Web $SPWeb | Where-Object {$_.UserLogin –like $Domain} | Out-File -FilePath $LogFileAfter

## Display a count of all the user accounts for the SPWeb

Get-SPUser –Web $SPWeb | Where-Object {$_.UserLogin –like $Domain} | Measure-Object | Out-File -FilePath $LogFileAfter -Append