<#
.SYNOPSIS
    PowerShell SharePoint Online Module Script to remove a Deleted Site Collection from the Recycle Bin (SPOnline).

.DESCRIPTION
    PowerShell SharePoint Online Module Script to remove a Deleted Site Collection from the
    Recycle Bin (SPOnline).

.EXAMPLE
    PS C:\> .\SPOnlineRemoveDeletedSiteCollection.ps1
    PowerShell SharePoint Online Module Script to remove a Deleted Site Collection from the Recycle Bin (SPOnline).

.NOTES
    Requires:   Microsoft.Online.Sharepoint.PowerShell
#>

$SiteURL = "https://contoso.sharepoint.com/sites/sitetoremove"

Import-Module Microsoft.Online.Sharepoint.PowerShell
$credential = Get-credential 
Connect-SPOService -url https://contoso-admin.sharepoint.com -Credential $credential 

Remove-SPODeletedSite -Identity $SiteURL