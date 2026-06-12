<#
.SYNOPSIS
    PowerShell Script To Flush BLOB Cache For Web Applications.

.DESCRIPTION
    PowerShell Script To Flush BLOB Cache For Web Applications.

.PARAMETER webApp
    Change the web application name to match your environment.

.EXAMPLE
    PS C:\> .\SP2013FlushBLOBCache.ps1
    Edit the variables section and run to powerShell Script To Flush BLOB Cache For Web Applications.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

# Resource: http://technet.microsoft.com/en-us/library/gg277249(v=office.15).aspx

# Environments: SharePoint Server 2010 / 2013 Farms

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

$webApp = Get-SPWebApplication "https://webapp.yourdomain.com" #Change the web application name to match your environment

[Microsoft.SharePoint.Publishing.PublishingCache]::FlushBlobCache($webApp)

Write-Host "Flushed the BLOB cache for:" $webApp