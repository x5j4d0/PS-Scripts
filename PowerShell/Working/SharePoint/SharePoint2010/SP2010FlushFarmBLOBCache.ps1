<#
.SYNOPSIS
    PowerShell Script to flush the BLOB cache in SharePoint Server 2010 Farms.

.DESCRIPTION
    PowerShell Script to flush the BLOB cache in SharePoint Server 2010 Farms.

.EXAMPLE
    PS C:\> .\SP2010FlushFarmBLOBCache.ps1
    PowerShell Script to flush the BLOB cache in SharePoint Server 2010 Farms.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

Write-Host -ForegroundColor White " - Enabling SP PowerShell cmdlets..."
If ((Get-PsSnapin |?{$_.Name -eq "Microsoft.SharePoint.PowerShell"})-eq $null)
{
$PSSnapin = Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue | Out-Null
}
$webAppall = Get-SPWebApplication
foreach ($_.URL in $webAppall) {
$webApp = Get-SPWebApplication $_.URL
[Microsoft.SharePoint.Publishing.PublishingCache]::FlushBlobCache($webApp)
Write-Host "Flushed the BLOB cache for:" $webApp
}