<#
.SYNOPSIS
    Set properties on Email Address.

.DESCRIPTION
    Set properties on Email Address.

.PARAMETER EmailAddress
    Email Address.

.EXAMPLE
    PS C:\> .\Set-IEXEmailAddress.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 

filter Set-IEXEmailAddress
{
    param(
    [string]$EmailAddress = $(Throw "EmailAddress cannot be empty"),
    [switch]$Add,
    [switch]$Remove,
    [switch]$SetAsPrimary,
    $DisableEmailAddressPolicy,
    [switch]$PassThru
    ) 

  

    if([Microsoft.Exchange.Data.SmtpProxyAddress]::Parse($EmailAddress).ParseException)
    {
        Throw "Invalid email address: '$EmailAddress'"
    } 

  

    if($DisableEmailAddressPolicy -and $DisableEmailAddressPolicy -isnot [bool])
    {
        Throw "DisableEmailAddressPolicy accept booleans or numbers, use $true, $false, 1 or 0 instead."
    } 

  

    if($Add -and $Remove)
    {
        Throw "Add and Remove cannot be specified together, please choose just one"
    } 

  

    if(!$Add -and ! $Remove)
    {
        Throw "Add or Remove wasn't specified, please choose one"
    } 

  

    if($Remove -and $SetAsPrimary)
    {
        Throw "SetAsPrimary cannot be specified with Remove."
    } 

  

    trap{ Throw $_ } 

  

    if($Add)
    {
        $_.EmailAddresses = $_.EmailAddresses += $EmailAddress
    } 

  

    if($Remove)
    {
        $_.EmailAddresses= $_.EmailAddresses -= $EmailAddress
    } 

  

    if($SetAsPrimary)
    {
        if($DisableEmailAddressPolicy -eq $true)
        {
            $_ | Set-Mailbox -PrimarySmtpAddress $EmailAddress -EmailAddressPolicyEnabled:$false
        } 

        if($DisableEmailAddressPolicy -eq $false)
        {
            $_ | Set-Mailbox -PrimarySmtpAddress $EmailAddress -EmailAddressPolicyEnabled:$true
        }
    }
    else
    {
        $_ | Set-Mailbox
    } 

  

    if($PassThru) { $_ }
} 
