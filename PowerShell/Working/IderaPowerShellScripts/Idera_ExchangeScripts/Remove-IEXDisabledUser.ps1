<#
.SYNOPSIS
    Remove Disabled User.

.DESCRIPTION
    Remove Disabled User.

.PARAMETER Days
    Days.

.PARAMETER Permanent
    Permanent.

.PARAMETER Confirm
    Confirm.

.PARAMETER WhatIf
    What If.

.EXAMPLE
    PS C:\> .\Remove-IEXDisabledUser.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 

function Remove-IEXDisabledUser 
{
    param(
    [int]$Days = 30,
    [bool]$Permanent = $false,
    [switch]$Confirm = $true,
    [switch]$WhatIf
    )
   
    Get-Mailbox -ResultSize Unlimited |
    Where-Object {$_.ExchangeUseraccountControl -eq "AccountDisabled" -and $_.WhenChanged -lt (Get-Date).AddDays(-$Days)} |
    Remove-Mailbox -Permanent:$Permanent -Confirm:$Confirm -WhatIf:$WhatIf
}
