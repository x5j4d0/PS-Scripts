<#
.SYNOPSIS
    PowerShell Script to Export Site Content Types to an XML File.

.DESCRIPTION
    PowerShell Script to Export Site Content Types to an XML File.

.EXAMPLE
    PS C:\> .\SP2010ExportSiteContentTypes.ps1
    PowerShell Script to Export Site Content Types to an XML File.

.NOTES
    Requires:   Microsoft.SharePoint.Powershell
    Resources:  http://get-spscripts.com/2011/02/export-and-importcreate-site-content.html; http://get-spscripts.com/2011/01/export-and-importcreate-site-columns-in.html
#>

Add-PSSnapin "Microsoft.SharePoint.Powershell" -ErrorAction SilentlyContinue

#### Start Variables ####
$sourceWeb = Get-SPWeb "http://YourSiteName.com"
$xmlFilePath = "C:\BoxBuild\Scripts\ContentTypesExport.xml"
$contentTypesGroup = "YourCustomGroup"
#### End Variables ####

#Create Export File
New-Item $xmlFilePath -type file -force

#Export Content Types to XML file
Add-Content $xmlFilePath "<?xml version=`"1.0`" encoding=`"utf-8`"?>"
Add-Content $xmlFilePath "`n<ContentTypes>"
$sourceWeb.ContentTypes | ForEach-Object {
    if ($_.Group -eq "$contentTypesGroup") {
        Add-Content $xmlFilePath $_.SchemaXml
    }
}
Add-Content $xmlFilePath "</ContentTypes>"

$sourceWeb.Dispose()