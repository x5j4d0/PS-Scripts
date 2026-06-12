<#
.SYNOPSIS
    Determine Your Farm ID With PowerShell.

.DESCRIPTION
    Determine Your Farm ID With PowerShell.

.EXAMPLE
    PS C:\> .\SP2007GetFarmID.ps1
    Determine Your Farm ID With PowerShell.
#>

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")
$spFarm=[Microsoft.SharePoint.Administration.SPfarm]::Local
$spFarm.Id
