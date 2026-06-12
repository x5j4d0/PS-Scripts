<#
.SYNOPSIS
    Retrieve Port Using DMO.

.DESCRIPTION
    Retrieve Port Using DMO.

.PARAMETER serverInstance
    server Instance.

.PARAMETER verbose
    verbose.

.PARAMETER debug
    debug.

.EXAMPLE
    PS C:\> .\Get-MSSQL-Port-UsingDMO.ps1

#>

param
(
  	[string]$serverInstance,
	[switch]$verbose,
	[switch]$debug
)

function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	Get-MSSQL-Port-UsingDMO $serverInstance
}

function Get-MSSQL-Port-UsingDMO($serverInstance)
{
	trap [Exception] 
	{
		write-error $("TRAPPED: " + $_.Exception.Message);
		continue;
	}

	# TIP: using PowerShell to instantiate a COM object
	$server = New-Object -comobject "SQLDMO.SQLServer"
	
	# Securely login to server instance and retrieve TCPPORT setting
	$server.loginsecure = $TRUE
	$server.connect($serverInstance)
	$server.registry.tcpport
	$server.close() 
}

main