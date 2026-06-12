<#
.SYNOPSIS
    Script to Query Active Directory to Get Password Last Set and Password Expiration Details.

.DESCRIPTION
    Script to Query Active Directory to Get Password Last Set and Password Expiration
    Details.

.EXAMPLE
    PS C:\> .\GetUserPasswordLastSetDetails.ps1
    Script to Query Active Directory to Get Password Last Set and Password Expiration Details.

.NOTES
    Requires:   ActiveDirectory
#>

Import-Module ActiveDirectory

function Get-UserDetails([string]$user) {
Get-ADUser $user -Properties PasswordLastSet, PasswordNeverExpires #Tip: Use a '*' after properties to get all available attributes related to a user
}
