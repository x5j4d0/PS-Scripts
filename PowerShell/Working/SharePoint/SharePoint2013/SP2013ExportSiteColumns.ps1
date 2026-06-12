<#
.SYNOPSIS
    PowerShell Script to Export Site Columns Groups to an XML File.

.DESCRIPTION
    PowerShell Script to Export Site Columns Groups to an XML File.

.EXAMPLE
    PS C:\> .\SP2013ExportSiteColumns.ps1
    PowerShell Script to Export Site Columns Groups to an XML File.

.NOTES
    Requires:   Microsoft.SharePoint.Powershell
    Resources:  http://get-spscripts.com/2011/01/export-and-importcreate-site-columns-in.html; http://get-spscripts.com/2011/02/export-and-importcreate-site-content.html
#>

#### Start Variables ####
$sourceWeb = Get-SPWeb "https://YourSharePointSite.com"
$xmlFilePath = "C:\BoxBuild\Scripts\SiteColumnsExport.xml"
$siteColumnsGroup = "YourCustomGroup"
#### End Variables ####

Add-PSSnapin "Microsoft.SharePoint.Powershell" -ErrorAction SilentlyContinue

#Create Export Files
New-Item $xmlFilePath -type file -force

#Export Site Columns to XML file
Add-Content $xmlFilePath "<?xml version=`"1.0`" encoding=`"utf-8`"?>"
Add-Content $xmlFilePath "`n<Fields>"
$sourceWeb.Fields | ForEach-Object {
   if ($_.Group -eq "$siteColumnsGroup") {
        Add-Content $xmlFilePath $_.SchemaXml
    }
}
Add-Content $xmlFilePath "</Fields>"

$sourceWeb.Dispose()