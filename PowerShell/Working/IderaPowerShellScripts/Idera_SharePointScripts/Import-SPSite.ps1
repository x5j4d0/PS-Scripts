<#
.SYNOPSIS
    Import Site.

.DESCRIPTION
    Import Site.

.PARAMETER url
    url.

.EXAMPLE
    PS C:\> .\Import-SPSite.ps1

#>

param (

   [string]$url = "$(Read-Host 'url [e.g. http://moss]')", 
   [string]$File = "$(Read-Host 'Backup File Name [e.g. Backup.bak]')",
   [string]$Location = "$(Read-Host 'Backup File Location [e.g. C:\Backup\]')"
)

function main() {

	[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")

	Import-SPSite -url $url -File $File -Location $Location
}

function Import-SPSite([string]$url, [string]$File, [string]$Location) {

	$SPImport = New-Object Microsoft.SharePoint.Deployment.SPImport
	$SPImport.Settings.SiteUrl= $url
	$SPImport.Settings.BaseFilename = $File
	$SPImport.Settings.FileLocation = $Location
	$SPImport.Settings.IncludeSecurity = "All"
	$SPImport.Run()
}

main