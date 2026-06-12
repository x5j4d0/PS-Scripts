<#
.SYNOPSIS
    Retrieve Active Directory domain controller objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory domain controller objects using ADSI..

.EXAMPLE
    PS C:\> .\Get-IADDomainController.ps1
    Run the script to perform the described operation.
#>

function Get-IADDomainController { 
   [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().DomainControllers
}