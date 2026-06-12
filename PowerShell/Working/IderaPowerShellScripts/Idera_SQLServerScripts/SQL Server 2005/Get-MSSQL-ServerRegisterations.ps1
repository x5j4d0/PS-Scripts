<#
.SYNOPSIS
    Retrieve Server Registerations.

.DESCRIPTION
    Retrieve Server Registerations.

.PARAMETER file
    file.

.PARAMETER verbose
    verbose.

.PARAMETER debug
    debug.

.EXAMPLE
    PS C:\> .\Get-MSSQL-ServerRegisterations.ps1

#>

param
(
  	[string]$file = "C:\TEMP\SQLServerRegistrations.txt",
	[switch]$verbose,
	[switch]$debug
)

function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	Get-MSSQL-ServerRegisterations $file
}

function Get-MSSQL-ServerRegisterations($file)
{
	#Dumps current SQL Server Enterprise Manager Groups and servers to specific
	#$appl = New-Object -comobject "SQLDMO.Application"
	#$appl.ServerGroups | %{$group = $_.Name; $_.RegisteredServers | % {$group + " " + $_.Name}} >> $file
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.ConnectionInfo" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.SmoEnum" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.Smo" );
	 
	$smoServers = new-object 'Microsoft.SqlServer.Management.Smo.Server' 
	$smoServers.Name

}

main