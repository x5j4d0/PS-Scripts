<#
.SYNOPSIS
    PowerShell Script To Test SharePoint Send Mail Functionality.

.DESCRIPTION
    PowerShell Script To Test SharePoint Send Mail Functionality.

.PARAMETER spsite
    Provide your SharePoint site details here.

.PARAMETER email
    Add your recipient email address here.

.PARAMETER subject
    Change your subject here.

.PARAMETER body
    Change your body text here.

.EXAMPLE
    PS C:\> .\SP2013TestEmailFunctionality.ps1
    Edit the variables section and run to powerShell Script To Test SharePoint Send Mail Functionality.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

##### Begin Variables #####
$spsite = "https://devinside.npe.theglobalfund.org" #Provide your SharePoint site details here
$email = "yourname@youremail.com" #Add your recipient email address here
$subject = "SharePoint SendMail Test" #Change your subject here
$body = "Email sent via SharePoint site $spsite" #Change your body text here
##### End Variables #####

$site = New-Object Microsoft.SharePoint.SPSite "$spsite"
$web = $site.OpenWeb()
[Microsoft.SharePoint.Utilities.SPUtility]::SendEmail($web,0,0,$email,$subject,$body)
