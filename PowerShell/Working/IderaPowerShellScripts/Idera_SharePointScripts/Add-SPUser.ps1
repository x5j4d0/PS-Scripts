<#
.SYNOPSIS
    Add User.

.DESCRIPTION
    Add User.

.PARAMETER url
    url.

.EXAMPLE
    PS C:\> .\Add-SPUser.ps1

#>

param (

   [string]$url = "$(Read-Host 'url [e.g. http://moss]')", 
   [string]$Group = "$(Read-Host 'Group Name [e.g. New Group]')", 
   [string]$DomainUser = "$(Read-Host 'User Logon Name [e.g. powershell\nigo]')",
   [string]$FullName = "$(Read-Host 'Users FullName [e.g. Niklas Goude]')", 
   [string]$Mail = "$(Read-Host 'Users Email [e.g. goude@powershell.nu]')"
)

function main() {

	[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")

	Add-SPUser -url $url -Group $Group -DomainUser $DomainUser -mail $mail -FullName $FullName
}

function Get-SPSite([string]$url) {

	New-Object Microsoft.SharePoint.SPSite($url)
}

function Get-SPWeb([string]$url) {

	$SPSite = Get-SPSite $url
	$SPSite.OpenWeb()
}

function Add-SPUser ([string]$url, [string]$Group, [string]$DomainUser, [string]$mail, [string]$FullName) {

	$SPSite = Get-SPSite $url

	if($SPSite.RootWeb.SiteGroups[$Group].Users | Where { $_.LoginName -eq $DomainUser }) {

		Write-Host "User: $($DomainUser) Already Exists in Group." -ForeGroundColor Red

	} else {

		$SPSite.RootWeb.SiteGroups[$Group].AddUser($DomainUser,$mail, $FullName,"")

	}

	$SPSite.Dispose()
}

main