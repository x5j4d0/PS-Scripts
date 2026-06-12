<#
.SYNOPSIS
    Retrieve Active Directory tombstone user objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory tombstone user objects using ADSI..

.EXAMPLE
    PS C:\> .\Get-IADTombstoneUser.ps1
    Run the script to perform the described operation.
#>

function Get-IADTombstoneUser 
{

$root= New-Object System.DirectoryServices.DirectoryEntry("LDAP://RootDSE")
$searcher = New-Object System.DirectoryServices.DirectorySearcher($root.defaultNamingContext)
$searcher.Filter = "(&(isDeleted=TRUE)(objectClass=User)(!(samaccountname=*$)))"
$searcher.tombstone = $true
$searcher.FindAll()
}