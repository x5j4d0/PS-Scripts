<#
.SYNOPSIS
    Retrieve Active Directory site objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory site objects using ADSI..

.PARAMETER All
    All.

.EXAMPLE
    PS C:\> .\Get-IADSite.ps1
    Run the script to perform the described operation.
#>

function Get-IADSite { 


    param (
        [switch]$All
    )

    if ($All) 
    {
        [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest().Sites
    }
    else 
    {
        [DirectoryServices.ActiveDirectory.ActiveDirectorySite]::GetComputerSite()
    }
}