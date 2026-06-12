<#
.SYNOPSIS
    PowerShell Script to List Trusted Sites in IE Browser.

.DESCRIPTION
    PowerShell Script to List Trusted Sites in IE Browser.

.EXAMPLE
    PS C:\> .\GetInternetExplorerTrustedSites.ps1
    PowerShell Script to List Trusted Sites in IE Browser.
#>

$_List1 = @()
$_List2 = @()
$_List3 = @()

$_List1 = $(Get-item 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMapKey' -ErrorAction SilentlyContinue).property  

$_List2 = $(Get-item 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMapKey' -ErrorAction SilentlyContinue).property | Out-GridView

$_List3 = $_List1 + $_List2 
$_List3 | Out-GridView