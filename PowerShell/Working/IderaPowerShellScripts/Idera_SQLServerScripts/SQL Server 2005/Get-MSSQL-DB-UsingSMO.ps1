<#
.SYNOPSIS
    Retrieve DB Using SMO.

.DESCRIPTION
    Retrieve DB Using SMO.

.PARAMETER serverInstance
    server Instance.

.EXAMPLE
    PS C:\> .\Get-MSSQL-DB-UsingSMO.ps1

#>

param
(
  	[string]$serverInstance = "(local)",
	[switch]$verbose,
	[switch]$debug
)

function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	Get-MSSQL-DB-UsingSMO $serverInstance
}

function Get-MSSQL-DB-UsingSMO($ServerInstance)
{
	#Load SMO assemblies
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.ConnectionInfo" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.SmoEnum" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.Smo" );
	 
	$smoServer = new-object( 'Microsoft.SqlServer.Management.Smo.Server' ) ($serverInstance)
    
	foreach ($database in $smoServer.databases) 
	{
		$dbID = $database.ID
		$dbName = $database.Name
		Write-Output "$dbID : $dbName"
	}
}

main

