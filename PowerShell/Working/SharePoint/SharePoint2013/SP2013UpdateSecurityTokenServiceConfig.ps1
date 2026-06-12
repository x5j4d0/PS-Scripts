<#
.SYNOPSIS
    PowerShell Script to Update the Values used in the Security Token Service Configuration.

.DESCRIPTION
    PowerShell Script to Update the Values used in the Security Token Service Configuration.

.EXAMPLE
    PS C:\> .\SP2013UpdateSecurityTokenServiceConfig.ps1
    PowerShell Script to Update the Values used in the Security Token Service Configuration.

.NOTES
    Requires:   Microsoft.SharePoint.PowerShell
    Resources:  http://blog.trivadis.com/b/collaboration/archive/2014/06/04/ad-group-membership-not-updated-immediately-to-sharepoint.aspx; https://technet.microsoft.com/en-us/library/ff607642.aspx
#>

Add-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue

$sts = Get-SPSecurityTokenServiceConfig

#Get/Display the current Farms Security Token Service Configuration (Defaults: WindowsTokenLifetime 10:00:00 | LogonTokenCacheExpirationWindow 00:10:00)
$sts

#Now Set the new values for the 'WindowsTokenLifetime' and 'LogonTokenCacheExpirationWindow'. Note: 'LogonTokenCacheExpirationWindow' value must always be lower
$sts.WindowsTokenLifetime = (New-TimeSpan –minutes 30) #Change the number of minutes to match your requirements
$sts.LogonTokenCacheExpirationWindow = (New-TimeSpan –minutes 5) #Change the number of minutes to match your requirements
$sts.Update()

#Now Get/Display the updated Farms Security Token Service Configuration
$sts