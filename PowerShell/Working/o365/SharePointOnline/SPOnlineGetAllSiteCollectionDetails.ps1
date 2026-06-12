<#
.SYNOPSIS
    PowerShell SharePoint Online Module Script to Get Deatils on All Site Collections in a Tenant (SPOnline).

.DESCRIPTION
    PowerShell SharePoint Online Module Script to Get Deatils on All Site Collections in a
    Tenant (SPOnline).

.EXAMPLE
    PS C:\> .\SPOnlineGetAllSiteCollectionDetails.ps1
    PowerShell SharePoint Online Module Script to Get Deatils on All Site Collections in a Tenant (SPOnline).

.NOTES
    Requires:   Microsoft.Online.Sharepoint.PowerShell
#>

Import-Module Microsoft.Online.Sharepoint.PowerShell 
$credential = Get-credential 
Connect-SPOService -url https://contoso-admin.sharepoint.com -Credential $credential 

Get-SPOSite -Detailed | Sort-Object StorageUsageCurrent -Descending | Format-Table Url, Template, WebsCount, StorageUsageCurrent, StorageQuota, ResourceUsageCurrent, LastContentModifiedDate -AutoSize