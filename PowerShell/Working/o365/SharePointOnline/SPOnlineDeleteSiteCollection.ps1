<#
.SYNOPSIS
    PowerShell SharePoint Online Module Script to Delete a Site Collection (SPOnline).

.DESCRIPTION
    PowerShell SharePoint Online Module Script to Delete a Site Collection (SPOnline).

.EXAMPLE
    PS C:\> .\SPOnlineDeleteSiteCollection.ps1
    PowerShell SharePoint Online Module Script to Delete a Site Collection (SPOnline).

.NOTES
    Requires:   Microsoft.Online.Sharepoint.PowerShell
#>

$SiteURL = "https://contoso.sharepoint.com/sites/sitetoremove"

Import-Module Microsoft.Online.Sharepoint.PowerShell
$credential = Get-credential 
Connect-SPOService -url https://contoso-admin.sharepoint.com -Credential $credential 

Remove-SPOSite -Identity $SiteURL -NoWait