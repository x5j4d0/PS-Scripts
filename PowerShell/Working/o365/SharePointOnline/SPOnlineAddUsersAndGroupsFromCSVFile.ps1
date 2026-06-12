<#
.SYNOPSIS
    PowerShell SharePoint Online Module Script to add Users / Groups to Multiple Site Collections from a CSV File (SPOnline).

.DESCRIPTION
    PowerShell SharePoint Online Module Script to add Users / Groups to Multiple Site
    Collections from a CSV File (SPOnline).

.EXAMPLE
    PS C:\> .\SPOnlineAddUsersAndGroupsFromCSVFile.ps1
    PowerShell SharePoint Online Module Script to add Users / Groups to Multiple Site Collections from a CSV File (SPOnline).

.NOTES
    Requires:   Microsoft.Online.Sharepoint.PowerShell
    Resources:  https://contoso.sharepoint.com/sites/TeamSite,Contoso; https://contoso.sharepoint.com/sites/Blog,Contoso
#>

#To begin, you will need to load the SharePoint Online module to be able to run commands in PowerShell
Import-Module Microsoft.Online.Sharepoint.PowerShell 
$credential = Get-credential 
Connect-SPOService -url https://contoso-admin.sharepoint.com -Credential $credential #Replace 'contoso' with your tenant prefix
 
#The following command will import the content of the CSV, and assign membership for users or groups for each row
Import-Csv \SPOUserGroups.csv | % {Add-SPOUser -Site $_.Site -Group $_.Group -LoginName $_.User}