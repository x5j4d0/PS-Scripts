<#
.SYNOPSIS
    Retrieve Active Directory user objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory user objects using ADSI..

.PARAMETER Name
    Name.

.PARAMETER SearchRoot
    Search Root.

.PARAMETER PageSize
    Page Size.

.PARAMETER SizeLimit
    Size Limit.

.PARAMETER SearchScope
    Search Scope.

.PARAMETER Enabled
    Enabled.

.PARAMETER Disabled
    Disabled.

.PARAMETER AccountNeverExpires
    Account Never Expires.

.EXAMPLE
    PS C:\> .\Get-IADUser.ps1
    Run the script to perform the described operation.
#>

function Get-IADUser {

 
param(
  [string]$Name = "*",
  [string]$SearchRoot,
  [int]$PageSize = 1000,
  [int]$SizeLimit = 0,
  [string]$SearchScope = "SubTree",
  [switch]$Enabled,
  [switch]$Disabled,
  [switch]$AccountNeverExpires,
  [switch]$PasswordNeverExpires
 )
 
 
 if($SearchScope -notmatch '^(Base|OneLevel|Subtree)$')
 {
     Throw "SearchScope Value must be one of: 'Base','OneLevel or 'Subtree'"
 }
 
 $resolve = "(|(sAMAccountName=$Name)(cn=$Name)(displayName=$Name)(givenName=$Name))"
 
 if($Enabled) {$Enabledf = "(!userAccountControl:1.2.840.113556.1.4.803:=2)"}
 if($Disabled) {$Disabledf = "(userAccountControl:1.2.840.113556.1.4.803:=2)"}


 if($Enabled) {$EnabledDisabledf = $Enabledf}
 if($Disabled) {$EnabledDisabledf = $Disabledf}
 if($Enabled -and $Disabled) { $EnabledDisabledf = ""}

 if($AccountNeverExpires) {$AccountNeverExpiresf = "(|(accountExpires=9223372036854775807)(accountExpires=0))"}
 if($PasswordNeverExpires) {$PasswordNeverExpiresf = "(userAccountControl:1.2.840.113556.1.4.803:=65536)"}

 $filter = "(&(objectCategory=Person)(objectClass=User)$EnabledDisabledf$AccountNeverExpiresf$PasswordNeverExpiresf$resolve)"

 $root= New-Object System.DirectoryServices.DirectoryEntry("LDAP://RootDSE")
 $searcher = New-Object System.DirectoryServices.DirectorySearcher $filter

 if($SearchRoot -eq [string]::Empty)
 {
   $SearchRoot=$root.defaultNamingContext
 }

 $searcher.SearchRoot = "LDAP://$SearchRoot"
 $searcher.SearchScope = $SearchScope
 $searcher.SizeLimit = $SizeLimit
 $searcher.PageSize = $PageSize
 $searcher.FindAll() | Foreach-Object { $_.GetDirectoryEntry() }
}