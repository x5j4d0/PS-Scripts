<#
.SYNOPSIS
    Disable User.

.DESCRIPTION
    Disable User.

.PARAMETER Identity
    Identity.

.PARAMETER NewLocationDN
    New Location DN.

.PARAMETER HideFromAddressLists
    Hide From Address Lists.

.EXAMPLE
    PS C:\> .\Disable-IEXUser.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin


function Disable-IEXUser {
    param (
    [string]$Identity,
    [string]$NewLocationDN,
    [switch]$HideFromAddressLists
    )
    if ($NewLocationDN) {
        if(![ADSI]::Exists("LDAP://$NewLocationDN"))
        {
            Throw "'$NewLocationDN' doesn't exist, please check the value."
        }
        else
        {
            $NewLocation = [ADSI]"LDAP://$NewLocationDN"
        }
    }

    $EXUser = Get-User -Identity $Identity
    $EXUserDN = $EXUser.DistinguishedName
    $ADuser = [adsi]"LDAP://$EXUserDN"

    $ADuser.psbase.invokeSet("AccountDisabled",$true) | Out-Null
    $ADUser.put("info","Disabled on $(Get-Date) by $env:userdomain\$env:username") | Out-Null
    $ADuser.SetInfo() | Out-Null

    if ($NewLocation) {$ADuser.psbase.MoveTo($NewLocation)}

    if ($HideFromAddressLists) {
        switch ($EXUser.RecipientType) {
            'UserMailbox' {Get-Mailbox -Identity $Identity | Set-Mailbox -HiddenFromAddressListsEnabled $true}
            'MailUser' {Get-MailUser -Identity $Identity | Set-MailUser -HiddenFromAddressListsEnabled $true}
        }
    }
} 
