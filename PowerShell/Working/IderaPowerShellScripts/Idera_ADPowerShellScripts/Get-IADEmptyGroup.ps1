<#
.SYNOPSIS
    Retrieve Active Directory empty group objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory empty group objects using ADSI..

.PARAMETER SearchRoot
    Search Root.

.PARAMETER PageSize
    Page Size.

.PARAMETER SizeLimit
    Size Limit.

.PARAMETER SearchScope
    Search Scope.

.EXAMPLE
    PS C:\> .\Get-IADEmptyGroup.ps1
    Run the script to perform the described operation.
#>

function Get-IADEmptyGroup 
{

  
param(
 [string]$SearchRoot,
 [int]$PageSize = 1000,
 [int]$SizeLimit = 0,
 [string]$SearchScope = "SubTree"
) 
 

$filter = "(&(objectClass=group)(!member=*))"
 
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