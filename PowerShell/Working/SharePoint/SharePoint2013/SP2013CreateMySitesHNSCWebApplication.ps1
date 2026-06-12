<#
.SYNOPSIS
    PowerShell Script To create A 'My Sites' Web Application With HNSC.

.DESCRIPTION
    PowerShell Script To create A 'My Sites' Web Application With HNSC.

.PARAMETER hostingMainURL
    Ensure that you use a Fully Qualified Domain Name (FQDN) for your 'place holder' web application.

.EXAMPLE
    PS C:\> .\SP2013CreateMySitesHNSCWebApplication.ps1
    Edit the variables section and run to powerShell Script To create A 'My Sites' Web Application With HNSC.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://technet.microsoft.com/en-us/library/cc424952.aspx; http://www.benjaminathawes.com/2013/12/11/using-host-named-site-collections-in-sharepoint-2013-with-mysites
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue
 
<# App Pool details (New-SPSite)
#>
$appPoolName = "SPMySiteAppPool"
$appPoolUserName = "DOMAIN\spprofilesapppool"
$ownerAlias = "DOMAIN\spprofilesapppool"
$ownerEmail = "spprofilesapppool@DOMAIN.com"
 
<# Web App details  (New-SPWebApplication)-------------------------------------
        Note that the Web App URL is HTTPS per SSL guidelines from Microsoft
#>
$hostingMainURL = "https://mysitewebapp.DOMAIN.com" #Ensure that you use a Fully Qualified Domain Name (FQDN) for your 'place holder' web application
$webAppName = "MySite"
$contentDBName = "DEV_Content_MySites"
 
<# Host-named site collections
        Ensure that the MySite Host URL is configured correctly within the User Profile Service, under the "Setup My Sites" link in SPCA
#>
$mysitehost = "https://mysite.DOMAIN.com"
 
$managedAccount = Get-SPManagedAccount $appPoolUserName
 
<# Create a new Web App using Windows Claims (Windows (NTLM))
      The -Url parameter specifies the Default Public URL. Otherwise, the machine name must be used when creating the root (path based) site collection
      The -SecureSocketsLayer is only required if using SSL
      Also changed -Port to 443
      When the Web App is created, ensure that an appropriate certificate is bound in IIS
#>
$authenticationProvider = New-SPAuthenticationProvider
 
write-host "Creating Web Application for host-named site collections at $hostingMainURL..."
$webApp = New-SPWebApplication -ApplicationPool $appPoolName -ApplicationPoolAccount $managedAccount -Name $webAppName -Port 443 -HostHeader "mysitewebapp.DOMAIN.com" -AuthenticationProvider $authenticationProvider -DatabaseName $contentDBName -Url $hostingMainURL -SecureSocketsLayer
 
<# Sometimes, the New-SPSite cmdlet reports that a path-based site already exists if it is run immediately after creating the Web App, so sleep for a minute
#>
write-host "Web App created" -foreground "green"
write-host "Sleeping for a minute before creating the root path-based site collection..."
Start-Sleep -s 60
 
<# Create path-based Site Collection at the Web App root. This won't be accessed by users but is required for support.
#>
New-SPSite -Url $hostingMainURL -owneralias $ownerAlias -ownerEmail $ownerEmail
 
# Enable self-service site creation for MySites
$webapp = Get-SPWebApplication $hostingMainURL
$webapp.SelfServiceSiteCreationEnabled = $true
$webApp.Update()
write-host "Self-service site creation enabled successfully..." -foreground "green"
 
<# Removing the existing /sites path-based managed path per http://blogs.technet.com/b/speschka/archive/2013/06/26/logical-architecture-guidance-for-sharepoint-2013-part-1.aspx
#>
$sitesManagedPath = Get-SPManagedPath sites -WebApplication $hostingMainURL
if ($sitesManagedPath -ne $null) {Remove-SPManagedPath sites -WebApplication $hostingMainURL -confirm:$false}
write-host "Removed /Sites path-based managed path..." -foreground "green"
 
<# Create MySite Managed Path (a managed path for use with HNSC, so ONE per farm)
#>
$personal = Get-SPManagedPath personal -hostheader
if ($personal -eq $null) {New-SPManagedPath personal -HostHeader}
write-host "Created /Personal managed path for MySites..." -foreground "green"
 
<# Create the MySite Host
#>
New-SPSite -Url $mysitehost -owneralias $ownerAlias -ownerEmail $ownerEmail -HostHeaderWebApplication $hostingMainURL -Template SPSMSITEHOST#0
write-host "Created MySite host at $mysitehost..." -foreground "green"
 
$webApp = Get-SPWebapplication $hostingMainURL
 
<# Confirm that the correct sites have been created
        From http://technet.microsoft.com/en-us/library/cc424952.aspx#section3a
#>
write-host "Confirming the site collections that we created within $hostingMainURL :"
$webApp = Get-SPWebapplication $hostingMainURL
 
foreach($spSite in $webApp.Sites)
{
if ($spSite.HostHeaderIsSiteName) 
{ Write-Host $spSite.Url 'is host-named' -foreground "green"}
else
{ Write-Host $spSite.Url 'is path based' -foreground "red"}
}
 
write-host "Done!" -foreground "green"