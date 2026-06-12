<#
.SYNOPSIS
    PowerShell Script To Remove Fields From Content Types And List Libraries.

.DESCRIPTION
    PowerShell Script To Remove Fields From Content Types And List Libraries.

.PARAMETER rootUrl
    Change this to match your environment URL.

.PARAMETER ContentTypeName
    Change this to your Content Type Name".

.PARAMETER FieldDisplayName
    Change this to your Field Name.

.EXAMPLE
    PS C:\> .\SP2010RemoveListFieldAll.ps1
    Edit the variables section and run to powerShell Script To Remove Fields From Content Types And List Libraries.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://sharepointburger.wordpress.com/2012/04/12/removing-a-site-column-from-a-content-type-that-cannot-be-deleted-from-ui
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

######################## Start Variables ##################################################

$rootUrl = "http://YourWebApp.com" #Change this to match your environment URL

$ContentTypeName = "YourContentTypeName" #Change this to your Content Type Name"

$FieldDisplayName = "YourFieldName" #Change this to your Field Name

######################## End Variables ####################################################

$web = Get-SPWeb $rootUrl

# Remove Field from Content Type and any derived Content Types

$contentType = $web.ContentTypes[ $ContentTypeName ]

$contentType.FieldLinks.Delete( $web.Fields[ $FieldDisplayName ].Id )

$contentType.Update( $true )

# Find lists where content type is used

$usages = [Microsoft.SharePoint.SPContentTypeUsage]::GetUsages( $contentType ) | Where-Object { $_.IsUrlToList } | ForEach-Object { $rootUrl + $_.Url }

# Remove field from lists

$usages | ForEach-Object {

$listUrl = $_

$listSite = New-Object Microsoft.SharePoint.SPSite( $listUrl )

$listWeb = $listSite.OpenWeb( )

$list = $listWeb.GetList( $listUrl )

$field = $list.Fields[ $FieldDisplayName ]

$field.AllowDeletion = $true

$field.Sealed = $false

$field.Delete( )

$list.Update( )

$listWeb.Dispose( )

$listSite.Dispose( )

}