<#
.SYNOPSIS
    Retrieve Active Directory group objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory group objects using ADSI..

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

.PARAMETER GroupType
    Group Type.

.PARAMETER GroupScope
    Group Scope.

.EXAMPLE
    PS C:\> .\Get-IADGroup.ps1
    Run the script to perform the described operation.
#>

function Get-IADGroup {
 param(
  [string]$Name = "*",
  [string]$SearchRoot,
  [int]$PageSize = 1000,
  [int]$SizeLimit = 0,
  [string]$SearchScope = "SubTree",
  [string]$GroupType,
  [string]$GroupScope
 ) 

  


 if($SearchScope -notmatch '^(Base|OneLevel|Subtree)$')
 {
  Throw "SearchScope Value must be one of: 'Base','OneLevel or 'Subtree'"
 } 


 # validating group type values
 if($GroupType -ne "" -or $GroupType)
 {
  if($GroupType -notmatch '^(Security|Distribution)$')
  {
   Throw "GroupType Value must be one of: 'Security' or 'Distribution'"
  }
 }
  
  
 # validating group scope values
 if($GroupScope -ne "" -or $GroupScope)
 {
  if($GroupScope -notmatch '^(Universal|Global|DomainLocal)$')
   {
   Throw "GroupScope Value must be one of: 'Universal', 'Global' or 'DomainLocal'"
  }
 } 

  

 $resolve = "(|(sAMAccountName=$Name)(cn=$Name)(name=$Name))" 


 $parameters = $GroupScope,$GroupType
 
 switch (,$parameters)
 {
  @('Universal','Distribution') {$filter = "(&(objectcategory=group)(sAMAccountType=268435457)(grouptype:1.2.840.113556.1.4.804:=8)$resolve)"}
  @('Universal','Security') {$filter = "(&(objectcategory=group)(sAMAccountType=268435456)(grouptype:1.2.840.113556.1.4.804:=-2147483640)$resolve)"}
  @('Global','Distribution') {$filter = "(&(objectcategory=group)(sAMAccountType=268435457)(grouptype:1.2.840.113556.1.4.804:=2)$resolve)"}
  @('Global','Security') {$filter = "(&(objectcategory=group)(sAMAccountType=268435456)(grouptype:1.2.840.113556.1.4.803:=-2147483646)$resolve)"}
  @('DomainLocal','Distribution') {$filter = "(&(objectcategory=group)(sAMAccountType=536870913)(grouptype:1.2.840.113556.1.4.804:=4)$resolve)"}
  @('DomainLocal','Security') {$filter = "(&(objectcategory=group)(sAMAccountType=536870912)(grouptype:1.2.840.113556.1.4.804:=-2147483644)$resolve)"}
  @('Global','') {$filter = "(&(objectcategory=group)(grouptype:1.2.840.113556.1.4.804:=2)$resolve)"}
  @('DomainLocal','') {$filter = "(&(objectcategory=group)(grouptype:1.2.840.113556.1.4.804:=4)$resolve)"}
  @('Universal','') {$filter = "(&(objectcategory=group)(grouptype:1.2.840.113556.1.4.804:=8)$resolve)"}
  @('','Distribution') {$filter = "(&(objectCategory=group)(!groupType:1.2.840.113556.1.4.803:=2147483648)$resolve)"}
  @('','Security') {$filter = "(&(objectcategory=group)(groupType:1.2.840.113556.1.4.803:=2147483648)$resolve)"}
  default {$filter = "(&(objectcategory=group)$resolve)"}
 }
 
  


 $root= New-Object System.DirectoryServices.DirectoryEntry("LDAP://RootDSE")
 $searcher = New-Object System.DirectoryServices.DirectorySearcher $filter 

       
 if($SearchRoot -eq [string]::Empty)
 {
  $SearchRoot=$root.defaultNamingContext
 }
 elseif( ![ADSI]::Exists("LDAP://$SearchRoot"))
 {
  Throw "SearchRoot value: '$SearchRoot' is invalid, please check value"
 } 


 $searcher.SearchRoot = "LDAP://$SearchRoot"
 $searcher.SearchScope = $SearchScope
 $searcher.SizeLimit = $SizeLimit
 $searcher.PageSize = $PageSize
 $searcher.FindAll() | Foreach-Object { $_.GetDirectoryEntry() }

}