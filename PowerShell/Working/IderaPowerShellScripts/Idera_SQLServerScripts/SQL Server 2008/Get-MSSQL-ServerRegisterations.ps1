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
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.Management.Common" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.SmoEnum" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.Smo" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.SmoExtended " );
	 
	$smoServers = new-object 'Microsoft.SqlServer.Management.Smo.Server' 
	$smoServers.Name

}

main