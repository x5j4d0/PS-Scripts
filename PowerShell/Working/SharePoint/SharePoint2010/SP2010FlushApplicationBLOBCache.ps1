<#
.SYNOPSIS
    PowerShell Script to flush the BLOB cache for a Web Application.

.DESCRIPTION
    PowerShell Script to flush the BLOB cache for a Web Application.

.PARAMETER webApp
    Change this URL to match your environment.

.EXAMPLE
    PS C:\> .\SP2010FlushApplicationBLOBCache.ps1
    Edit the variables section and run to powerShell Script to flush the BLOB cache for a Web Application.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

$webApp = Get-SPWebApplication "<WebApplicationURL>" #Change this URL to match your environment
[Microsoft.SharePoint.Publishing.PublishingCache]::FlushBlobCache($webApp)
Write-Host "Flushed the BLOB cache for:" $webApp
