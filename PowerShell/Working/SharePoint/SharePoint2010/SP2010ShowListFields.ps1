<#
.SYNOPSIS
    PowerShell Script to Show All Fields In A List (Includes Custom and System Fields).

.DESCRIPTION
    PowerShell Script to Show All Fields In A List (Includes Custom and System Fields).

.PARAMETER site
    Change this to suit your environment.

.PARAMETER list
    Change this to your list name.

.EXAMPLE
    PS C:\> .\SP2010ShowListFields.ps1
    Edit the variables section and run to powerShell Script to Show All Fields In A List (Includes Custom and System Fields).
#>

[system.reflection.assembly]::loadwithpartialname("microsoft.sharepoint")
$site= New-Object Microsoft.SharePoint.SPSite ("http://YourSPSite") #Change this to suit your environment
$web=$site.OpenWeb()
$list=$web.Lists["TestCustomList"] #Change this to your list name
$list.Fields |select title, internalname| more