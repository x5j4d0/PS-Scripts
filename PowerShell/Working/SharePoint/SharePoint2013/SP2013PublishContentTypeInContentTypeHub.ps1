<#
.SYNOPSIS
    PowerShell Function to Force a Publish of Content Types in a Content Type Hub.

.DESCRIPTION
    PowerShell Function to Force a Publish of Content Types in a Content Type Hub.

.EXAMPLE
    PS C:\> .\SP2013PublishContentTypeInContentTypeHub.ps1
    PowerShell Function to Force a Publish of Content Types in a Content Type Hub.

.NOTES
    Requires:   Microsoft.SharePoint.Powershell
    Resources:  http://www.mice-ts.com/force-a-publish-of-content-types-in-a-content-type-hub-using-powershell
#>

Add-PSSnapin Microsoft.SharePoint.Powershell -ErrorAction SilentlyContinue

function Publish-ContentTypeHub {
    param
    (
        [parameter(mandatory=$true)][string]$CTHUrl,
        [parameter(mandatory=$true)][string]$Group
    )
 
    $site = Get-SPSite $CTHUrl
    if(!($site -eq $null))
    {
        $contentTypePublisher = New-Object Microsoft.SharePoint.Taxonomy.ContentTypeSync.ContentTypePublisher ($site)
        $site.RootWeb.ContentTypes | ? {$_.Group -match $Group} | % {
            $contentTypePublisher.Publish($_)
            write-host "Content type" $_.Name "has been republished" -foregroundcolor Green
        }
    }
}