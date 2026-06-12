<#
.SYNOPSIS
    PowerShell Script to List All Inactive Features at Farm, Web Application, Site Collection, Web (sub-site) Scope.

.DESCRIPTION
    PowerShell Script to List All Inactive Features at Farm, Web Application, Site
    Collection, Web (sub-site) Scope.

.PARAMETER siteFeatures
    Farm, WebApp, Site and Web.

.EXAMPLE
    PS C:\> .\SP2013GetAllInactiveFeatures.ps1
    Edit the variables section and run to powerShell Script to List All Inactive Features at Farm, Web Application, Site Collection, Web (sub-site) Scope.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://www.theroks.com/list-all-installed-features-that-are-not-active-with-powershell; http://sharepoint.stackexchange.com/questions/76245/powershell-command-to-find-active-features-for-site-collection
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell"

$siteFeatures = Get-SPFeature | Where-Object {$_.Scope -eq "Site" } # Farm, WebApp, Site and Web
if ($siteFeatures -ne $null)
{
   foreach ($feature in $siteFeatures)
   {
      # -Site can be replace by -Farm (without url), -WebApp, -Web
      if ((Get-SPFeature -Site "https://yoursitecollection.com" | Where-Object {$_.Id -eq $feature.id}) -eq $null)
      {
         # Inactive features
         Write-Host "Scope: $($feature.Scope) FeatureName: $($feature.DisplayName) FeatureID: $($feature.ID) " -ForeGroundColor Green
      }
   }
}