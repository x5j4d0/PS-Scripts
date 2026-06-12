<#
.SYNOPSIS
    Retrieve Active Directory fsmo role holder objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory fsmo role holder objects using ADSI..

.EXAMPLE
    PS C:\> .\Get-IADFSMORoleHolder.ps1
    Run the script to perform the described operation.
#>

function Get-IADFSMORoleHolder 
{

    $domain = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
    $forest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()

    $pso = "" | select Naming,Schema,Pdc,Rid,Infrastructure

    $pso.Naming = $forest.NamingRoleOwner
    $pso.Schema = $forest.SchemaRoleOwner
    $pso.Pdc = $domain.PdcRoleOwner
    $pso.Rid = $domain.RidRoleOwner
    $pso.Infrastructure = $domain.InfrastructureRoleOwner
    $pso
}