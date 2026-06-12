<#
.SYNOPSIS
    PowerShell Script to Connect to Exchange Online and Get Distribution Lists Group Members (o365).

.DESCRIPTION
    PowerShell Script to Connect to Exchange Online and Get Distribution Lists Group Members
    (o365).

.EXAMPLE
    PS C:\> .\GetExchangeOnlineDistributionListMembers.ps1
    PowerShell Script to Connect to Exchange Online and Get Distribution Lists Group Members (o365).
#>

Import-PSSession $(New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Authentication Basic -AllowRedirection -Credential $(Get-Credential))

(Get-DistributionGroup -Identity 'GroupName*').identity | ForEach-Object{
    $DistributionGroupName = $_
    Get-DistributionGroupMember -Identity $_ | ForEach-Object{
        [PSCustomObject]@{
            DistributionGroup = $DistributionGroupName
            MemberName = $_.Name
	    EmailAddress =$_.primarysmtpaddress
            #Other recipientproperties here
        }
    }
}
    