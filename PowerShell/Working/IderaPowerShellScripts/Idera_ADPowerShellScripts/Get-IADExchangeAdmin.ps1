<#
.SYNOPSIS
    Retrieve Active Directory exchange admin objects using ADSI..

.DESCRIPTION
    Retrieve Active Directory exchange admin objects using ADSI..

.EXAMPLE
    PS C:\> .\Get-IADExchangeAdmin.ps1
    Run the script to perform the described operation.
#>

function Get-IADExchangeAdmin 
{


    $dnc = ([ADSI]"").distinguishedName
    $exchange = [ADSI]"LDAP://CN=Microsoft Exchange,CN=Services,CN=Configuration,$dnc"
    $acl = $exchange.psbase.ObjectSecurity
    $rights = $acl.GetAccessRules($true,$true,[System.Security.Principal.SecurityIdentifier])

    $rights | Where-Object {$_.ActiveDirectoryRights.value__ -match '^(983551|131220|197119)$'} | Foreach-Object {

        $obj = $_.IdentityReference.translate([system.security.principal.ntaccount])
        $pso = "" | Select-Object User,Role
        $pso.user = $obj

        switch($_.ActiveDirectoryRights.value__)
        {
            983551 { $pso.role="Exchange Full Administrator" }
            131220 { $pso.role="Exchange View Only Administrator" }
            197119 { $pso.role="Exchange Administrator" }
        }

        $pso
    }
}