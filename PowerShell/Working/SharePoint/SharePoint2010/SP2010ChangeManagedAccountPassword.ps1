<#
.SYNOPSIS
    PowerShell Script to change Managed Account Passwords.

.DESCRIPTION
    PowerShell Script to change Managed Account Passwords.

.EXAMPLE
    PS C:\> .\SP2010ChangeManagedAccountPassword.ps1
    PowerShell Script to change Managed Account Passwords.
#>

$ver = $host | select version
if ($ver.Version.Major -gt 1)  {$Host.Runspace.ThreadOptions = "ReuseThread"}
Add-PsSnapin Microsoft.SharePoint.PowerShell
Set-location $home

$inManagedAcct = Read-Host 'Service Account'

$managedAcct = Get-SPManagedAccount $inManagedAcct

$inPass = Read-Host 'Enter Password' -AsSecureString
$inPassConfirm = Read-Host 'Confirm Password' -AsSecureString

Set-SPManagedAccount -Identity $managedAcct -NewPassword $inPass -ConfirmPassword $inPassConfirm -SetNewPassword﻿