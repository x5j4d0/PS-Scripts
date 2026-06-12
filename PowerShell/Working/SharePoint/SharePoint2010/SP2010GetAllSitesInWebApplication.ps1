<#
.SYNOPSIS
    PowerShell Script to Report on All Site Collections and Sites in a Web Application.

.DESCRIPTION
    PowerShell Script to Report on All Site Collections and Sites in a Web Application.

.EXAMPLE
    PS C:\> .\SP2010GetAllSitesInWebApplication.ps1
    PowerShell Script to Report on All Site Collections and Sites in a Web Application.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://iedaddy.com/2011/11/sharepoint-information-architecture-diagram-using-powershell-and-visio
#>

### Start Variables ###
$WebApplication = "https://insidewebapp.theglobalfund.org"
$ReportPath = "C:\BoxBuild\Scripts\SPSitesReport.csv"
### End Variables ###

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

Get-SPWebApplication $WebApplication | Get-SPSite -Limit All | Get-SPWeb -Limit All | Select Title, URL, ID, ParentWebID, IsRootWeb, WebTemplate, AssociatedOwnerGroup, AssociatedMemberGroup, HasUniquePerm, Created, LastItemModifiedDate | Export-CSV $ReportPath -NoTypeInformation