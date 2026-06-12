<#
.SYNOPSIS
    PowerShell Script to Activate Features Across All Site Collections and Sites (webs) in a Web Application.

.DESCRIPTION
    PowerShell Script to Activate Features Across All Site Collections and Sites (webs) in a
    Web Application.

.EXAMPLE
    PS C:\> .\SP2013ActivateFeatureForAllSiteCollectionsAndSites.ps1
    PowerShell Script to Activate Features Across All Site Collections and Sites (webs) in a Web Application.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://www.smellslikesharepoint.com/2012/06/24/activate-feature-on-all-sites-across-all-site-collections; https://technet.microsoft.com/en-us/library/ee837418.aspx#bkmk_activ_all
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell"

### Start Variables ###
$SPWebApplication = "https://YourWebApp.com"
$SPFeatureID = "00bfea71-7e6d-4186-9ba8-c047ac750105"
### End Variables ###

Get-SPWebApplication $SPWebApplication | Get-SPSite -Limit All | Get-SPWeb -Limit ALL | foreach {Enable-SPFeature $SPFeatureID -url $_.URL }
