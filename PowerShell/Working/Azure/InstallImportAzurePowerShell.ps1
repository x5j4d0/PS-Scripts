<#
.SYNOPSIS
    PowerShell Commands For Installing and Importing The Azure PowerShell Modules.

.DESCRIPTION
    PowerShell Commands For Installing and Importing The Azure PowerShell Modules.

.EXAMPLE
    PS C:\> .\InstallImportAzurePowerShell.ps1
    PowerShell Commands For Installing and Importing The Azure PowerShell Modules.

.NOTES
    Requires:   Azure
    Resources:  http://www.microsoft.com/en-us/download/details.aspx?id=48729; https://github.com/Azure/azure-powershell
#>

# Install all of the AzureRM.* modules
Install-Module AzureRM

Install-AzureRM

Install-Module Azure

# Import all of the AzureRM.* modules within the known semantic version range
Import-AzureRM

# Import Azure Service Management
Import-Module Azure