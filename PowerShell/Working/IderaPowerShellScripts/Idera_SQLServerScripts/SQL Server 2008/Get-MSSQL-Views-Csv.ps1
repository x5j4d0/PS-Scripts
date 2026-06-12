<#
.SYNOPSIS
    Retrieve Views Csv.

.DESCRIPTION
    Retrieve Views Csv.

.PARAMETER serverInstance
    server Instance.

.EXAMPLE
    PS C:\> .\Get-MSSQL-Views-Csv.ps1

#>

param
(
	[string]$serverInstance = "(local)",
  	[string]$tempDir = "C:\TEMP\",
	[string]$filter = "objects",
	[switch]$verbose,
	[switch]$debug
)

function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	Get-MSSQL-Views-Csv $serverInstance $tempDir $filter
}

function Get-MSSQL-Views-Csv($serverInstance, $tempDir, $filter)
{
	trap [Exception] 
	{
		write-error $("TRAPPED: " + $_.Exception.Message);
		continue;
	}

	$outputFile = $tempDir + "GetViews.csv"
	
	# Validate path to temp directory
	Write-Debug "Validate output path $tempDir"
	if (-not (Test-Path -path $tempDir)) 
	{
		Write-Host "Unable to validate path to temp directory: $tempDir"
		break
	}

	# Load-SMO assemblies
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.Management.Common" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.SmoEnum" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.Smo" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.SmoExtended " );
	
	# Create a Server object for default instance
	Write-Debug "Get SMO named instance object for server: $serverInstance"
	$namedInstance = New-Object ('Microsoft.SqlServer.Management.Smo.Server') ($serverInstance)
	
	# Retrieve views based on filter string and export to CSV
	Write-Debug "Exporting filtered views based on filter:$filter to $outputfile"
	($namedInstance.databases["master"]).get_views() | 
		where {$_ -like "*$filter*"} | Export-Csv -path $outputFile
}

main