<#
.SYNOPSIS
    PowerShell Script to set Managed Properties to Refinable And / Or Sortable.

.DESCRIPTION
    PowerShell Script to set Managed Properties to Refinable And / Or Sortable.

.EXAMPLE
    PS C:\> .\SP2013SetManagedPropertiesRefinableSortable.ps1
    PowerShell Script to set Managed Properties to Refinable And / Or Sortable.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  https://yoursite.yourdomain.com"; http://srevathi.wordpress.com/2013/06/29/powershell-to-make-managed-properties-sortable-and-refinable-in-sharepoint-2013
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

## 1. Function to set Managed Property as 'Refinable' (Yes - active) ##

## Yes - active: Enables using the property as a refiner for search results in the front end. You must manually configure the refiner in the web part.

Function SetRefinable($siteUrl, $searchApp, $propertyName)

{

$site = Get-SPSite $siteUrl

# get current search service aplication

$sspApp = Get-SPEnterpriseSearchServiceApplication | where {$_.name -eq $SearchApp};

if( $sspApp -ne $null){

$schema=new-object Microsoft.Office.Server.Search.Administration.Schema($sspApp)

$managedProperties=$schema.AllManagedProperties | where {$_.Name -eq $propertyName}

$managedProperties[0].Refinable=$true

$managedProperties[0].Update()

Write-Host “Refinable set for property :” $managedProperties[0].Name

}else{

write-host “Search service application does not exist – $sspApp”

}

$site.Dispose()

}

## 2. Function to set Managed Property as 'Sortable' (Yes - active) ##

## Yes - active: Enables using the property as a refiner for search results in the front end. You must manually configure the refiner in the web part. 

Function SetSortable($siteUrl, $searchApp, $propertyName)

{

$site = Get-SPSite $siteUrl

# get current search service aplication

$sspApp = Get-SPEnterpriseSearchServiceApplication | where {$_.name -eq $SearchApp};

if( $sspApp -ne $null){

$schema=new-object Microsoft.Office.Server.Search.Administration.Schema($sspApp)

$managedProperties=$schema.AllManagedProperties | where {$_.Name -eq $propertyName}

$managedProperties[0].Sortable=$true

$managedProperties[0].SortableType=[Microsoft.Office.Server.Search.Administration.SortableType]::Enabled

$managedProperties[0].Update()

Write-Host “sortable set for property :” $managedProperties[0].Name

} else{

write-host “Search service application does not exist – $sspApp”

}

$site.Dispose()

}