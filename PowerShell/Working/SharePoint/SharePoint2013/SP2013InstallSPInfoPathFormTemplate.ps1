<#
.SYNOPSIS
    PowerShell Script to Deploy and Activate InfoPath Form Templates (Administrator-approved form template).

.DESCRIPTION
    PowerShell Script to Deploy and Activate InfoPath Form Templates (Administrator-approved
    form template).

.EXAMPLE
    PS C:\> .\SP2013InstallSPInfoPathFormTemplate.ps1
    PowerShell Script to Deploy and Activate InfoPath Form Templates (Administrator-approved form template).

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://www.appvity.com/blogs/post/2013/06/16/How-to-configure-and-publish-InfoPath-to-SharePoint-2013.aspx; https://technet.microsoft.com/en-us/library/ff608053.aspx
#>

### Start Variables ###
$FormPath = "C:\BoxBuild\InfoPathTemplates"
$FormName = "YourTemplateName.xsn"
$SiteCollection = "http://YourSiteCollection.com"
### End Variables ###

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

##Install the InfoPath Form Template
Install-SPInfoPathFormTemplate -Path $FormPath + '\' $FormName

##Enable and activate the InfoPath Form Template Feature at Site Collection Level
Enable-SPInfoPathFormTemplate -Identity $FormName -Site $SiteCollection
