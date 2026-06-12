<#
.SYNOPSIS
    PowerShell Script to run the Content Type Hub related Timer Jobs following Content Type Updates.

.DESCRIPTION
    PowerShell Script to run the Content Type Hub related Timer Jobs following Content Type
    Updates.

.PARAMETER ctSubTJ
    Change this path to match your web application URL.

.EXAMPLE
    PS C:\> .\SP2010RunContentTypeHubTimerJobs.ps1
    Edit the variables section and run to powerShell Script to run the Content Type Hub related Timer Jobs following Content Type Updates.

.NOTES
    Requires:   Microsoft.SharePoint.Powershell
#>

Add-PSSnapin Microsoft.SharePoint.Powershell -ErrorAction SilentlyContinue

#Run the Content Type Hub timer job (default is to run once daily)
$ctHubTJ = Get-SPTimerJob "MetadataHubTimerJob"
$ctHubTJ.RunNow()

#Run the Content Type Subscriber timer job for a specific Web Application (default to run every hour)
$ctSubTJ = Get-SPTimerJob "MetadataSubscriberTimerJob" -WebApplication "https://yourwebapp.com" #Change this path to match your web application URL
$ctSubTJ.RunNow()