<#
.SYNOPSIS
    PowerShell Script to Get GUID IDs (GUIDs) for Lists in a Site Collection.

.DESCRIPTION
    PowerShell Script to Get GUID IDs (GUIDs) for Lists in a Site Collection.

.PARAMETER site
    Edit this site collection URL to match your environment.

.EXAMPLE
    PS C:\> .\SP2010GetSiteCollectionListGUIDs.ps1
    Edit the variables section and run to powerShell Script to Get GUID IDs (GUIDs) for Lists in a Site Collection.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://www.enjoysharepoint.com/Articles/Details/sharepoint-2013-get-sharepoint-list-or-document-library-guids-using-21333.aspx
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell"
$site = Get-SPSite "https://yoursitecollection.com" #Edit this site collection URL to match your environment
$web = $site.RootWeb

## Returns GUIDs for all lists in a site collection
$lists = $web.lists 
$lists | Format-Table title,id -AutoSize 

## Returns GUIDs for all lists in a site collection where the Base Type is 'GenericList' 
##$lists = $web.lists | Where-Object { $_.BaseType -Eq "GenericList" }
##$lists | Format-Table title,id -AutoSize

## Returns GUIDs for all lists in a site collection where the Base Type is 'DocumentLibrary' 
##$libraries = $web.lists | Where-Object { $_.BaseType -Eq "DocumentLibrary" }
##$libraries | Format-Table title,id -AutoSize
