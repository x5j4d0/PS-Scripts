<#
.SYNOPSIS
    Enable Active Directory object objects using ADSI..

.DESCRIPTION
    Enable Active Directory object objects using ADSI..

.EXAMPLE
    PS C:\> .\Enable-IADObject.ps1
    Run the script to perform the described operation.
#>

filter Enable-IADObject {




  if($_ -is [ADSI] -and $_.psbase.SchemaClassName -match '^(user|computer)$') 
  {
     $null = $_.psbase.invokeSet("AccountDisabled",$false)
     $null = $_.SetInfo()
     $_
    }
    else
    {
      Write-Warning "Invalid object type. Only 'User' or 'Computer' objects are allowed."
    }
  }