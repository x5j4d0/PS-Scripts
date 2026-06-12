<#
.SYNOPSIS
    Add Active Directory group member objects using ADSI..

.DESCRIPTION
    Add Active Directory group member objects using ADSI..

.PARAMETER MemberDN
    Member DN.

.EXAMPLE
    PS C:\> .\Add-IADGroupMember.ps1
    Run the script to perform the described operation.
#>

filter Add-IADGroupMember {
 param(
 [string[]]$MemberDN = $(Throw "MemberDN cannot be empty.") 
)
 

 if($_ -is [ADSI] -and $_.psbase.SchemaClassName -eq 'group')
 {
  $group = $_
  trap {
   Write-Error $_
   continue
  } 


  $MemberDN | Where-Object {$_} | ForEach-Object { $null = $group.member.add($_) } 

  $group.psbase.commitChanges()
 }
 else
 {
  Write-Warning "Wrong object type, only Group objects are allowed."
 }
}