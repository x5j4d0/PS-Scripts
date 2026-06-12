<#
.SYNOPSIS
    PowerShell Script to Add additional URLs in Zones for Host Named Site Collections (HNSC).

.DESCRIPTION
    PowerShell Script to Add additional URLs in Zones for Host Named Site Collections (HNSC).

.PARAMETER SiteCollectionURL
    Provide your original HNSC URL here.

.PARAMETER SiteCollectionAlternateURL
    Provide the new URL to be mapped to the original HNSC.

.PARAMETER SiteCollectionZone
    Provide the Zone property for the new URL (Default; Intranet; Internet; Custom; Extranet).

.EXAMPLE
    PS C:\> .\SP2013AddAlternateSiteCollectionURLMapping.ps1
    Edit the variables section and run to powerShell Script to Add additional URLs in Zones for Host Named Site Collections (HNSC).

.NOTES
    Requires:   microsoft.sharepoint.powershell
#>

$SiteCollectionURL = "https://external.theglobalfund.org" #Provide your original HNSC URL here
$SiteCollectionAlternateURL = "https://vdc2-external.theglobalfund.org" #Provide the new URL to be mapped to the original HNSC
$SiteCollectionZone = "Internet" #Provide the Zone property for the new URL (Default; Intranet; Internet; Custom; Extranet)

Add-PSSnapin microsoft.sharepoint.powershell

Set-SPSiteUrl (Get-SPSite $SiteCollectionURL) -Url $SiteCollectionAlternateURL -Zone $SiteCollectionZone

Get-SPSiteUrl -Identity $SiteCollectionURL