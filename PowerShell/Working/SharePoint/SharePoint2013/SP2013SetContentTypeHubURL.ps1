<#
.SYNOPSIS
    PowerShell Script To Update The Content Type Hub URL For The Managed Metadata Service.

.DESCRIPTION
    PowerShell Script To Update The Content Type Hub URL For The Managed Metadata Service.

.PARAMETER ServiceApplicationName
    Change this to match your environment.

.PARAMETER ContentTypeHub
    Change this to the path of your Content Type Hub.

.EXAMPLE
    PS C:\> .\SP2013SetContentTypeHubURL.ps1
    Edit the variables section and run to powerShell Script To Update The Content Type Hub URL For The Managed Metadata Service.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

$ServiceApplicationName = "Managed Metadata Service" #Change this to match your environment
$ContentTypeHub = "https://contenttypehub.yourdomain.com" #Change this to the path of your Content Type Hub

Set-SPMetadataServiceApplication -Identity $ServiceApplicationName -HubURI $ContentTypeHub