<#
.SYNOPSIS
    PowerShell Script To Update Site Column Field Properties.

.DESCRIPTION
    PowerShell Script To Update Site Column Field Properties.

.PARAMETER spfield
    Change this field 'InternalName' if needed.

.EXAMPLE
    PS C:\> .\SP2007UpdateListField.ps1
    Edit the variables section and run to powerShell Script To Update Site Column Field Properties.

.NOTES
    Resources:  http://spm.codeplex.com; http://sharepointkb.wordpress.com/2009/02/12/renaming-root-title-site-column-powershell-example
#>

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")

#Replace the siteurl with your targeted site collection url.
$siteurl = "http://YourWebAppName.com"

$spsite=new-object Microsoft.SharePoint.SPSite($siteurl)
$spweb=$spsite.OpenWeb()
$spfield=$spweb.Fields.GetFieldByInternalName("Title") #Change this field 'InternalName' if needed
$spfield.Title = "Title" #Change this 'Title' field if needed
#Add additional field properties below here if you want to update other properties - example:
#$spfield.Description = "Add Your Description Here"
$spfield.Update()
$spweb.Dispose()
$spsite.Dispose()