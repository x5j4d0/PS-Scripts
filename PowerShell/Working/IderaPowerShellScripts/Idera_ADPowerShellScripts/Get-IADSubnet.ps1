<#
.SYNOPSIS
    Retrieve Active Directory subnet objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory subnet objects using ADSI..

.PARAMETER All
    All.

.EXAMPLE
    PS C:\> .\Get-IADSubnet.ps1
    Run the script to perform the described operation.
#>

function Get-IADSubnet 
{

    param (
        [switch]$All
    )

    if ($All) 
   {
        $sites = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest().Sites
        $sites | Select-Object -ExpandProperty Subnets
    }
    else 
    {
        $currentSite = [DirectoryServices.ActiveDirectory.ActiveDirectorySite]::GetComputerSite()
        $currentSite | Select-Object -ExpandProperty Subnets
    }
}