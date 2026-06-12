<#
.SYNOPSIS
    PowerShell Script to Provision Personal Sites (MySite) for One Drive For Business (OD4B) via CSV File Input (SPOnline).

.DESCRIPTION
    PowerShell Script to Provision Personal Sites (MySite) for One Drive For Business (OD4B)
    via CSV File Input (SPOnline).

.PARAMETER InputFilePath
    Change this to match your environment.

.EXAMPLE
    PS C:\> .\SPOnlineCreatePersonalSiteCollectionsFromCSVFile.ps1
    Edit the variables section and run to powerShell Script to Provision Personal Sites (MySite) for One Drive For Business (OD4B) via CSV File Input (SPOnline).

.NOTES
    Requires:   Microsoft.Online.Sharepoint.PowerShell
    Resources:  https://technet.microsoft.com/en-us/library/dn792367.aspx
#>

Import-Module "Microsoft.Online.Sharepoint.PowerShell" -ErrorAction SilentlyContinue
$credential = Get-credential 
Connect-SPOService -url https://contoso-admin.sharepoint.com -Credential $credential

$InputFilePath = "C:\BoxBuild\Scripts\SPOnlineUsers.csv" #Change this to match your environment

$CsvFile = Import-Csv $InputFilePath

ForEach ($line in $CsvFile)

{ 

Request-SPOPersonalSite -UserEmails $line.User -NoWait

Write-Host Personal site provisioned for $line.User -ForegroundColor Yellow

}