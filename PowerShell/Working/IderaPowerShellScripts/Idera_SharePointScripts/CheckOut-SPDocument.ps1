<#
.SYNOPSIS
    CheckOut Document.

.DESCRIPTION
    CheckOut Document.

.PARAMETER url
    url.

.EXAMPLE
    PS C:\> .\CheckOut-SPDocument.ps1

#>

param (

   [string]$url = "$(Read-Host 'url [e.g. http://moss]')", 
   [string]$List = "$(Read-Host 'Document Library [e.g. Shared Documents]')",
   [string]$Document = "$(Read-Host 'Document Name [e.g. Word Doc.docx]')"
)

function main() {

	[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")

	CheckOut-SPDocument -url $url -List $Folder -Document $Document
}

function Get-SPSite([string]$url) {

	New-Object Microsoft.SharePoint.SPSite($url)
}

function Get-SPWeb([string]$url) {

	$SPSite = Get-SPSite $url
	return $SPSite.OpenWeb()
	$SPSite.Dispose()
}

function CheckOut-SPDocument([string]$url, [string]$List, [string]$Document) {

	$OpenWeb = Get-SPWeb $url
	$GetFolder = $OpenWeb.GetFolder($List)
	$GetFolder.Files | Where { $_.Name -eq $Document } | ForEach {

		if($_.CheckOutStatus -ne "None") {
			Write-Host "$($_.Name) is already Checked out To: $($_.CheckedOutBy)" -ForeGroundColor Yellow
		} else {
			$_.CheckOut()
			Write-Host "$($_.Name) Checked Out" -ForeGroundColor Green
		}
		
	}
	$OpenWeb.Dispose()
}

main