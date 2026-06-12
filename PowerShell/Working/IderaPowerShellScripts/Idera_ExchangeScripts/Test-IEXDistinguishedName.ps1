<#
.SYNOPSIS
    Test Distinguished Name.

.DESCRIPTION
    Test Distinguished Name.

.PARAMETER dn
    dn.

.EXAMPLE
    PS C:\> .\Test-IEXDistinguishedName.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 

function Test-IEXDistinguishedName
{
    param(
        [string]$dn
    )
   
   [Microsoft.Exchange.Data.Directory.ADObjectId]::IsValidDistinguishedName($dn)
}
 