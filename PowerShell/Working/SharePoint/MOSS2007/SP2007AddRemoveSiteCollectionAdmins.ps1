<#
.SYNOPSIS
    PowerShell Script To Add and Remove Site Collection Administrators.

.DESCRIPTION
    PowerShell Script To Add and Remove Site Collection Administrators.

.PARAMETER siteURL
    URL to any site in the web application.

.PARAMETER add
    1 for adding the user, 0 to remove the user.

.EXAMPLE
    PS C:\> .\SP2007AddRemoveSiteCollectionAdmins.ps1
    Edit the variables section and run to powerShell Script To Add and Remove Site Collection Administrators.
#>

######################## Start Variables ########################
$newSiteCollectionAdminLoginName = "DOMAIN\AccountName"
$newSiteCollectionAdminEmail = "YourEmail@domain.com"
$newSiteCollectionAdminName = "AccountDisplayName"
$newSiteCollectionAdminNotes = ""
$siteURL = "http://YourSharePointSiteName.com" #URL to any site in the web application.
$add = 1 # 1 for adding the user, 0 to remove the user
######################## End Variables ########################
Clear-Host
$siteCount = 0
[system.reflection.assembly]::loadwithpartialname("Microsoft.SharePoint")
$site = new-object microsoft.sharepoint.spsite($siteURL)
$webApp = $site.webapplication
$allSites = $webApp.sites
foreach ($site in $allSites)
{
    
    $web = $site.openweb()
    $web.allusers.add($newSiteCollectionAdminLoginName, $newSiteCollectionAdminEmail, $newSiteCollectionAdminName, $newSiteCollectionAdminNotes)
    
    $user = $web.allUsers[$newSiteCollectionAdminLoginName]
    $user.IsSiteAdmin = $add
    $user.Update()
    $web.Dispose()
    $siteCount++
}
$site.dispose()
write-host "Updated" $siteCount "Site Collections."