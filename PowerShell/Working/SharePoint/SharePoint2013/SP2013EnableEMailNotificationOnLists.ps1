<#
.SYNOPSIS
    PowerShell Script to Enable Email Notifications on Lists via CSOM.

.DESCRIPTION
    PowerShell Script to Enable Email Notifications on Lists via CSOM.

.PARAMETER SPSite
    Provide your SharePoint site URL here.

.PARAMETER SPList
    provide your List Name here.

.EXAMPLE
    PS C:\> .\SP2013EnableEMailNotificationOnLists.ps1
    Edit the variables section and run to powerShell Script to Enable Email Notifications on Lists via CSOM.

.NOTES
    Requires:   Microsoft.SharePoint.Powershell
    Resources:  https://gallery.technet.microsoft.com/office/Enable-email-notifications-390a927c
#>

Add-PSSnapin Microsoft.SharePoint.Powershell -ErrorAction SilentlyContinue

$SPSite = "https://YourSharePointSite.com" #Provide your SharePoint site URL here
$SPList = "Task List" #provide your List Name here

$web = Get-SPWeb "$SPSite"

$list = $web.Lists.TryGetList("$SPList") 

$list.EnableAssignToEmail = $true #Set this to '$false' if you want to disable this property

$list.Update()