<#
.SYNOPSIS
    PowerShell Script to Set the Path for Diagnostic Logs (ULS) and Usage and Health Data.

.DESCRIPTION
    PowerShell Script to Set the Path for Diagnostic Logs (ULS) and Usage and Health Data.

.EXAMPLE
    PS C:\> .\SP2010SetLoggingLocationPaths.ps1
    PowerShell Script to Set the Path for Diagnostic Logs (ULS) and Usage and Health Data.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

#Configure diagnostic logging path (ULS)
Set-SPDiagnosticConfig -LogLocation "D:\Data\SharePoint\Logs\ULS"

#Configure usage and health data collection
Set-SPUsageService -UsageLogLocation "D:\Data\SharePoint\Logs\Usage"
