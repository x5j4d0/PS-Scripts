<#
.SYNOPSIS
    PowerShell Script to Produce a Report on All Site Collections Within a Web Application.

.DESCRIPTION
    PowerShell Script to Produce a Report on All Site Collections Within a Web Application.

.PARAMETER SitesReport
    Change this path to match your environment.

.EXAMPLE
    PS C:\> .\SP2013EnumSiteCollections.ps1
    Edit the variables section and run to powerShell Script to Produce a Report on All Site Collections Within a Web Application.

.NOTES
    Requires:   microsoft.sharepoint.powershell
    Resources:  https://blogs.technet.microsoft.com/sharepoint_-_inside_the_lines/2015/09/08/get-site-collection-size-with-powershell/
#>

Add-PSSnapin microsoft.sharepoint.powershell

$SitesReport = "C:\BoxBuild\Scripts\SPSiteCollectionSizes.csv" #Change this path to match your environment

$WebApps = Get-SPWebApplication

foreach($WebApp in $WebApps)

{

$Sites = Get-SPSite -WebApplication $WebApp -Limit All

foreach($Site in $Sites)

{

$SizeInKB = $Site.Usage.Storage

$SizeInGB = $SizeInKB/1024/1024/1024

$SizeInGB = [math]::Round($SizeInGB,2)

$CSVOutput = $Site.RootWeb.Title + "," + $Site.URL + "," + $Site.ContentDatabase.Name + "," + $SizeInGB + "," + $Site.Owner + "," + $Site.SecondaryContact + "," + $Site.LastContentModifiedDate

$CSVOutput | Out-File $SitesReport -Append

}

}

$Site.Dispose()