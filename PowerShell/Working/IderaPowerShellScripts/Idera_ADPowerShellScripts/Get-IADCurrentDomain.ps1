<#
.SYNOPSIS
    Retrieve Active Directory current domain objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory current domain objects using ADSI..

.EXAMPLE
    PS C:\> .\Get-IADCurrentDomain.ps1
    Run the script to perform the described operation.
#>

function Get-IADCurrentDomain { 
 [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
}