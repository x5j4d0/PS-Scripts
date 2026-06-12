<#
.SYNOPSIS
    PowerShell Script to provision a new Site Collection.

.DESCRIPTION
    PowerShell Script to provision a new Site Collection.

.PARAMETER SiteCollectionTemplate
    1".

.EXAMPLE
    PS C:\> .\SP2010CreateSiteCollectionInExistingContentDB.ps1
    Edit the variables section and run to powerShell Script to provision a new Site Collection.

.NOTES
    Requires:   Microsoft.SharePoint.Powershell
#>

Add-PSSnapin Microsoft.SharePoint.Powershell
$SiteCollectionName = "Welcome to My Publishing Site"
$SiteCollectionURL = "http://www.contoso.com/sps/"
$ContentDatabase  = "SP2010_ContentDB_Frontend"
$SiteCollectionTemplate = "BLANKINTERNET#1"
$SiteCollectionLanguage = 1033
$SiteCollectionDescription = "Publishing site"
$OwnerAlias = "DOMAIN\admin"
$OwnerEmail = "admin@contoso.com"
$SecondaryOwnerAlias = "DOMAIN\admin2"
$SecondaryEmail = "admin2@contoso.com"
## Provisions a new Sharepoint Site Collection
New-SPSite -Name $SiteCollectionName -URL $SiteCollectionURL -ContentDatabase $ContentDatabase -Template $SiteCollectionTemplate -Language $SiteCollectionLanguage -Description $SiteCollectionDescription -OwnerAlias $OwnerAlias -OwnerEmail $OwnerEmail -SecondaryOwnerAlias $SecondaryOwnerAlias -SecondaryEmail $SecondaryEmail