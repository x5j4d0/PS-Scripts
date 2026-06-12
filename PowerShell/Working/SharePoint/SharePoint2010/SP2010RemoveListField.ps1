<#
.SYNOPSIS
    PowerShell Scripts To Delete Column Fields Attached To Content Types Or Directly To Lists.

.DESCRIPTION
    PowerShell Scripts To Delete Column Fields Attached To Content Types Or Directly To
    Lists.

.PARAMETER web
    Change this to your URL.

.PARAMETER ct
    Change this to the Content Type name.

.PARAMETER spFieldLink
    Change this to your Field name.

.PARAMETER list
    Change this to your List Name.

.PARAMETER field
    Change this to your Field name.

.EXAMPLE
    PS C:\> .\SP2010RemoveListField.ps1
    Edit the variables section and run to powerShell Scripts To Delete Column Fields Attached To Content Types Or Directly To Lists.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

#Attach to the web and content type
$web = Get-SPWeb "http://YourWebApp/YourSite.com" #Change this to your URL
$ct = $web.ContentTypes["YourContentTypeName"] #Change this to the Content Type name

#Get link to the column from the web
$spFieldLink = New-Object Microsoft.SharePoint.SPFieldLink ($web.Fields["YourColumnName"]) #Change this to your Field name

#Remove the column from the content type and update
$ct.FieldLinks.Delete($spFieldLink.Id)
$ct.Update()

#Dispose of the web object
$web.Dispose()


## Script 2: Removes a Column Field attached to List Libraries

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

$web = Get-SPWeb "http://YourWebApp/YourSite.com" #Change this to your URL
$list = $web.Lists["YourListName"] #Change this to your List Name
$field = $list.Fields["YourFieldName"] #Change this to your Field name
$field.AllowDeletion = “true”
$field.Sealed = “false”
$field.Delete()
$list.Update()
$web.Dispose()