<#
.SYNOPSIS
    Disable Active Directory object objects using ADSI..

.DESCRIPTION
    Disable Active Directory object objects using ADSI..

.EXAMPLE
    PS C:\> .\Disable-IADObject.ps1
    Run the script to perform the described operation.
#>

filter Disable-IADObject {




  if($_ -is [ADSI] -and $_.psbase.SchemaClassName -match '^(user|computer)$')
  {
    $null = $_.psbase.invokeSet("AccountDisabled",$true)
    $null = $_.SetInfo()
    $_
  }
   else
  {
    Write-Warning "Invalid object type. Only 'User' or 'Computer' objects are allowed."
  }
}