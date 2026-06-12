<#
.SYNOPSIS
    PowerShell Content Type Specific Queries.

.DESCRIPTION
    PowerShell Content Type Specific Queries.

.PARAMETER site
    Change the URL to match your environment.

.EXAMPLE
    PS C:\> .\SP2007GetContentTypeQueries.ps1
    Edit the variables section and run to powerShell Content Type Specific Queries.
#>

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")

$site = New-Object Microsoft.SharePoint.SPSite("http://yourserver/sites/yoursite") #Change the URL to match your environment

$webs = $site.AllWebs

foreach ($web in $webs) 
{
  foreach ($lst in $web.lists) 
  { 
    foreach ($ctype in $lst.ContentTypes) 
    { 
      if ($ctype.Name -eq "Document") #Change your Site Content Type name here
      { $lst.DefaultViewUrl }
    }
  } 
  $web.Dispose() 
}

## 2. PowerShell Script To Show All List Items Where A Specific Content Type Has Been Used

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")

$site = New-Object Microsoft.SharePoint.SPSite("http://yourserver/sites/yoursite") #Change the URL to match your environment

$webs = $site.AllWebs

foreach ($web in $webs)
{
  foreach ($lst in $web.lists)
  {
    foreach ($item in $lst.Items)
    {
      if ($item.ContentType.Name -eq "Document") #Change your Site Content Type name here
      { $item.Url}
    }
  }
  $web.Dispose() 
}

## 3. PowerShell Script To Show All Content Types Used On Site Collections And Webs

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")

$site = New-Object Microsoft.SharePoint.SPSite("http://yourserver/sites/yoursite") #Change the URL to match your environment

$webs = $site.AllWebs

$web = $site.RootWeb

foreach ($ctype in $web.ContentTypes) {$ctype.Name}

$web.Dispose()