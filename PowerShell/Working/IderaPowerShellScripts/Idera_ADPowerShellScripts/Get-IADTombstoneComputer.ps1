<#
.SYNOPSIS
    Retrieve Active Directory tombstone computer objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory tombstone computer objects using ADSI..

.EXAMPLE
    PS C:\> .\Get-IADTombstoneComputer.ps1
    Run the script to perform the described operation.
#>

function Get-IADTombstoneComputer 
{ 
 $root= New-Object System.DirectoryServices.DirectoryEntry("LDAP://RootDSE")
 $searcher = New-Object System.DirectoryServices.DirectorySearcher($root.defaultNamingContext)
 $searcher.Filter = "(&(isDeleted=TRUE)(objectClass=User)(samaccountname=*$))"
 $searcher.tombstone = $true
 $searcher.FindAll()
}