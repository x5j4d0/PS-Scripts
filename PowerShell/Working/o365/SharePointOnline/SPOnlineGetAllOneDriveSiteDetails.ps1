<#
.SYNOPSIS
    PowerShell Script to Produce a Report on All Users OneDrive Sites (MSOnline / SPOnline).

.DESCRIPTION
    PowerShell Script to Produce a Report on All Users OneDrive Sites (MSOnline / SPOnline).

.EXAMPLE
    PS C:\> .\SPOnlineGetAllOneDriveSiteDetails.ps1
    PowerShell Script to Produce a Report on All Users OneDrive Sites (MSOnline / SPOnline).

.NOTES
    Requires:   MSOnline, MSOnlineExtended, Microsoft.Online.Sharepoint.PowerShell
#>

Import-Module MSOnline
Import-Module MSOnlineExtended
Import-Module Microsoft.Online.Sharepoint.PowerShell

## Connects to MSOnline and SPOnline PowerShell Commandlets
$cred=Get-Credential
Connect-MsolService -Credential $cred
Connect-SPOService -url https://YourTenant-admin.sharepoint.com -Credential $cred

function GetODUsage($url)
{
    $sc = Get-SPOSite $url -Detailed -ErrorAction SilentlyContinue | select url, storageusagecurrent, Owner
    $usage = $sc.StorageUsageCurrent /1024
    return "$($sc.Owner), $($usage), $($url)"
}
foreach($usr in $(Get-MsolUser -All ))
{
    if ($usr.IsLicensed -eq $true)
    {
        $upn = $usr.UserPrincipalName.Replace(".","_")
        $od4bSC = "https://YourTenant-my.sharepoint.com/personal/$($upn.Replace("@","_"))"
        $od4bSC
        foreach($lic in $usr.licenses)
        {
            if ($lic.AccountSkuID -eq "YourTenant:ENTERPRISEPACK") {Write-Host "$(GetODUsage($od4bSC)), E3"}
            elseif ($lic.AccountSkuID -eq "YourTenant:WACONEDRIVESTANDARD") {Write-Host "$(GetODUsage($od4bSC)), OneDrive"} 
        }
    }
}
