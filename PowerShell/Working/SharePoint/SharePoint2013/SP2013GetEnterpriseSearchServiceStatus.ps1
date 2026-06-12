<#
.SYNOPSIS
    PowerShell Script to Query the Status of the Enterprise Search Service Application.

.DESCRIPTION
    PowerShell Script to Query the Status of the Enterprise Search Service Application.

.PARAMETER ssa
    Change this to match your SSA Name.

.EXAMPLE
    PS C:\> .\SP2013GetEnterpriseSearchServiceStatus.ps1
    Edit the variables section and run to powerShell Script to Query the Status of the Enterprise Search Service Application.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

$ssa = "Search Service Application" #Change this to match your SSA Name

Get-SPEnterpriseSearchStatus -SearchApplication $ssa -Detailed -Text