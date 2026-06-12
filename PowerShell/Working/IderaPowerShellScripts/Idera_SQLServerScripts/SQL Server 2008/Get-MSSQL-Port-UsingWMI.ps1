<#
.SYNOPSIS
    Retrieve Port Using WMI.

.DESCRIPTION
    Retrieve Port Using WMI.

.PARAMETER Computer
    Computer.

.PARAMETER Instance
    Instance.

.PARAMETER verbose
    verbose.

.PARAMETER debug
    debug.

.EXAMPLE
    PS C:\> .\Get-MSSQL-Port-UsingWMI.ps1

#>

param
(
  	[string]$Computer = ".",
	[string]$Instance = "MSSQLSERVER",
	[switch]$verbose,
	[switch]$debug
)

function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	Get-MSSQL-Port-UsingWMI $computer $instance
}

function Get-MSSQL-Port-UsingWMI($computer, $instance)
{
	trap [Exception] 
	{
		write-error $("TRAPPED: " + $_.Exception.Message);
		continue;
	}

	# Create a WMI query
	$WQL = "SELECT PropertyStrVal "
	$WQL += "FROM ServerNetworkProtocolProperty "
	$WQL += "WHERE InstanceName = '$instance' AND "
	$WQL += "IPAddressName = 'IPAll' AND "
	$WQL += "PropertyName = 'TcpPort' AND "
	$WQL += "ProtocolName = 'Tcp'"
	Write-Debug $WQL
	
	# Create a WMI namespace for SQL Server
	$WMInamespace = 'root\Microsoft\SqlServer\ComputerManagement10'
	
	# TIP: using PowerShell Get-WmiObject to run a WMI query and
	#      iterate through the the results using ForEach-Object
	Get-WmiObject -query $WQL -computerName $computer -namespace $WMInamespace |
		ForEach-Object { $_.PropertyStrVal }
}

main