<#
.SYNOPSIS
    PowerShell Script To Enumerate Site Template IDs.

.DESCRIPTION
    PowerShell Script To Enumerate Site Template IDs.

.EXAMPLE
    PS C:\> .\SP2010EnumerateSiteTemplateID.ps1
    PowerShell Script To Enumerate Site Template IDs.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue
$web = Get-SPWeb "http://sp2010devportal.npe.theglobalfund.org/sites/recordscenter"
write-host "Web Template:" $web.WebTemplate " | Web Template ID:" $web.WebTemplateId
$web.Dispose()