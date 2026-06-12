<#
.SYNOPSIS
    PowerShell Script To List All Site Columns At List Library Level.

.DESCRIPTION
    PowerShell Script To List All Site Columns At List Library Level.

.EXAMPLE
    PS C:\> .\SP2013GetAllListColumns.ps1
    PowerShell Script To List All Site Columns At List Library Level.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://www.sharepointdiary.com/2016/04/get-list-fields-in-sharepoint-using-powershell.html
#>

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
 
#Configuration Parameters
$SiteURL="https://YourSite.com"
$ListName= "YourListName"
 
#Get the List
$List = (Get-SPWeb $SiteURL).Lists.TryGetList($ListName)
 
Write-Host "Field Name | Internal Name | Type"
Write-Host "------------------------------------"
 
#Loop through each field in the list and get the Field Title, Internal Name and Type
ForEach ($Field in $List.Fields)
{
    Write-Host $Field.Title"|"$Field.internalName"|"$Field.Type
}


#Read more: http://www.sharepointdiary.com/2016/04/get-list-fields-in-sharepoint-using-powershell.html#ixzz58tBLXmub