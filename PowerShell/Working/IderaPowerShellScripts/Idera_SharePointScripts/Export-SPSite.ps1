<#
.SYNOPSIS
    Export Site.

.DESCRIPTION
    Export Site.

.PARAMETER url
    url.

.EXAMPLE
    PS C:\> .\Export-SPSite.ps1

#>

param (

   [string]$url = "$(Read-Host 'url [e.g. http://moss]')", 
   [string]$File = "$(Read-Host 'Backup File Name [e.g. Backup.bak]')",
   [string]$Location = "$(Read-Host 'Backup File Location [e.g. C:\Backup\]')"
)

function main() {

	[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")

	Export-SPSite -url $url -File $File -Location $Location
}

function Export-SPSite([string]$url, [string]$File, [string]$Location) {

	if(Test-Path $Location) {

	} else {
		new-item -path $Location -type directory | Out-Null
	}

	if(gci $Location | Where { $_.Name -eq $File }) {

		Write-Host "Backup File $($File) Already Exists." -ForeGroundColor Red

	} else {

		$SPExport = New-Object Microsoft.SharePoint.Deployment.SPExport

		$SPExport.Settings.SiteUrl= $url
		$SPExport.Settings.BaseFilename = $File
		$SPExport.Settings.FileLocation = $Location
		$SPExport.Settings.IncludeSecurity = "All"
		$SPExport.Run()
	}
}

main