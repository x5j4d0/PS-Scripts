<#
.SYNOPSIS
    Retrieve Cluster Node.

.DESCRIPTION
    Retrieve Cluster Node.

.PARAMETER ClusteredMailboxServerName
    Clustered Mailbox Server Name.

.EXAMPLE
    PS C:\> .\Get-IEXClusterNode.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 
 
function Get-IEXClusterNode {
    param (
    $ClusteredMailboxServerName = $(Throw 'Please, specify clustered mailbox server name.'),
    [switch]$Passive
    )

    $Nodes = Get-ClusteredMailboxServerStatus -Identity $ClusteredMailboxServerName |
    select -expand OperationalMachines

    if ($Passive) {
        $Nodes | where {$_ -notmatch 'Active'}
    }
    else {
        $Node = $Nodes | where {$_ -cmatch 'Active'}
        $Node.substring(0,$Node.indexOf(" "))
    }
}
