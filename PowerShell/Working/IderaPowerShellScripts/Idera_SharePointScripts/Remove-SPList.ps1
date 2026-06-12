<#
.SYNOPSIS
    Remove List.

.DESCRIPTION
    Remove List.

.PARAMETER url
    url.

.EXAMPLE
    PS C:\> .\Remove-SPList.ps1

#>

param (

   [string]$url = "$(Read-Host 'url [e.g. http://moss]')", 
   [string]$List = "$(Read-Host 'List Name [e.g. My List]')"
)

function main() {

	[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")

	Remove-SPField -url $url -List $List
}

function Get-SPSite([string]$url) {

	New-Object Microsoft.SharePoint.SPSite($url)
}

function Get-SPWeb([string]$url) {

	$SPSite = Get-SPSite $url
	return $SPSite.OpenWeb()
	$SPSite.Dispose()
}

function Remove-SPField([string]$url, [string]$List) {

	$OpenWeb = Get-SPWeb $url
	$OpenList = $OpenWeb.Lists[$List]

	$OpenList.Delete()

	$OpenWeb.Dispose()
}

main