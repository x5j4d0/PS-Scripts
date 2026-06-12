<#
.SYNOPSIS
    PowerShell Script To Set The Maximum File Size Limit Per File Extension At Web Application Level.

.DESCRIPTION
    PowerShell Script To Set The Maximum File Size Limit Per File Extension At Web
    Application Level.

.PARAMETER FileExtension
    Just provide the file extension here e.g wmv.

.PARAMETER FileSize
    Provide the maximum file size value in MB.

.EXAMPLE
    PS C:\> .\SP2013SetMaximumFileSizePerExtension.ps1
    Edit the variables section and run to powerShell Script To Set The Maximum File Size Limit Per File Extension At Web Application Level.

.NOTES
    Resources:  http://sharepointrelated.com/2012/07/30/maximum-file-size-per-extension-in-sharepoint-2013; http://blogs.technet.com/b/sammykailini/archive/2013/11/06/how-to-increase-the-maximum-upload-size-in-sharepoint-2013.aspx
#>

##### Begin Variables #####
$WebAppURL = ""
$FileExtension = "" #Just provide the file extension here e.g wmv
$FileSize = "" #Provide the maximum file size value in MB
##### End Variables #####

# Check what is currently configured for your web application

$WebApp = Get-SPWebApplication "$WebAppURL"
$WebApp.MaximumFileSizePerExtension

# Now add your maximum file extension type and maximum size value

$WebApp = Get-SPWebApplication ""
$WebApp.MaximumFileSizePerExtension.Add("$FileExtension","$FileSize")
$WebApp.Update()