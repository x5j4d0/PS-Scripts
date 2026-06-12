<#
.SYNOPSIS
    PowerShell Content Type Specific Queries.

.DESCRIPTION
    PowerShell Content Type Specific Queries.

.PARAMETER webs
    Change the URL to match your environment.

.PARAMETER site
    Change the URL to match your environment.

.EXAMPLE
    PS C:\> .\SP2010GetContentTypeQueries.ps1
    Edit the variables section and run to powerShell Content Type Specific Queries.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

$webs = get-spsite "http://yourserver/sites/yoursite" | get-spweb #Change the URL to match your environment

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

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

$webs = get-spsite "http://yourserver/sites/yoursite" | get-spweb #Change the URL to match your environment

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

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

$site = Get-SPSite "http://yourserver/sites/yoursite" #Change the URL to match your environment

$web = $site.RootWeb

foreach ($ctype in $web.ContentTypes) {$ctype.Name}

$web.Dispose()