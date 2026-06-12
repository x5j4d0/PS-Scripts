<#
.SYNOPSIS
    Retrieve Active Directory tombstone object objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory tombstone object objects using ADSI..

.EXAMPLE
    PS C:\> .\Get-IADTombstoneObject.ps1
    Run the script to perform the described operation.
#>

function Get-IADTombstoneObject 
 {

  $root= New-Object System.DirectoryServices.DirectoryEntry("LDAP://RootDSE")
  $searcher = New-Object System.DirectoryServices.DirectorySearcher($root.defaultNamingContext)
  $searcher.Filter = "(&(isDeleted=TRUE))"
  $searcher.tombstone = $true
  $searcher.FindAll() 
}