<#
.SYNOPSIS
    PowerShell SharePoint Online Module Script to create Multiple Site Collections from a CSV File (SPOnline).

.DESCRIPTION
    PowerShell SharePoint Online Module Script to create Multiple Site Collections from a CSV
    File (SPOnline).

.EXAMPLE
    PS C:\> .\SPOnlineCreateSiteCollectionsFromCSVFile.ps1
    PowerShell SharePoint Online Module Script to create Multiple Site Collections from a CSV File (SPOnline).

.NOTES
    Requires:   Microsoft.Online.Sharepoint.PowerShell
    Resources:  https://contoso.sharepoint.com/sites/TeamSite,user1@contoso.com,1024,300,STS#0,2; https://contoso.sharepoint.com/sites/Blog,user2@contoso.com,512,100,BLOG#0,4
#>

#To begin, you will need to load the SharePoint Online module to be able to run commands in PowerShell 
Import-Module Microsoft.Online.Sharepoint.PowerShell 
$credential = Get-credential 
Connect-SPOService -url https://contoso-admin.sharepoint.com -Credential $credential #Replace 'contoso' with your tenant prefix

#The following command will import the content of the CSV, and create a site collection for each row 
Import-Csv .\NewSPOSites.csv| % {New-SPOSite -Owner $_.Owner -StorageQuota $_.StorageQuota -Url $_.Url -NoWait -ResourceQuota $_.ResourceQuota -Template $_.Template -TimeZoneID $_.TimeZoneID -Title $_.Name} 