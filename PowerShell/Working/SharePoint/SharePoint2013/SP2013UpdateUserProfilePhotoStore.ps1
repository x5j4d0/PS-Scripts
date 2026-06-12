<#
.SYNOPSIS
    PowerShell Script to Update User Pictures Mapped to the AD Photo Attribute (thumbnailPhoto).

.DESCRIPTION
    PowerShell Script to Update User Pictures Mapped to the AD Photo Attribute
    (thumbnailPhoto).

.PARAMETER mySitesUrl
    Change this to match your environments My Site URL.

.EXAMPLE
    PS C:\> .\SP2013UpdateUserProfilePhotoStore.ps1
    Edit the variables section and run to powerShell Script to Update User Pictures Mapped to the AD Photo Attribute (thumbnailPhoto).

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue
$mySitesUrl = "https://mysite.yourcompany.com" #Change this to match your environments My Site URL
$mySitesHost = Get-SPSite Identity $mySitesUrl
Update-SPProfilePhotoStore MySiteHostLocation $mySitesHost CreateThumbnailsForImportedPhotos $true