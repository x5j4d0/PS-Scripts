<#
.SYNOPSIS
    Connect to IP Windows Auth.

.DESCRIPTION
    Connect to IP Windows Auth.

.PARAMETER ipAddress
    ip Address.

.PARAMETER verbose
    verbose.

.PARAMETER debug
    debug.

.EXAMPLE
    PS C:\> .\Connect-MSSQL-IPWindowsAuth.ps1

#>

param
(
  	[string]$ipAddress = "127.0.0.1",
	[switch]$verbose,
	[switch]$debug
)

function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	Connect-MSSQL-IPWindowsAuth $ipAddress
}

function Connect-MSSQL-IPWindowsAuth($ipAddress)
{
	trap [Exception] 
	{
		write-error $("TRAPPED: " + $_.Exception.Message);
		continue;
	}
	
	# Load-SMO assemblies
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.Management.Common" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.SmoEnum" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.Smo" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.SmoExtended " );
	
	# Instantiate a server object
	# TIP: using PowerShell "`" to signify line continuation
	Write-Debug "Creating SMO Server object..."
	
	$Smo = "Microsoft.SqlServer.Management.Smo."
	$smoServer = new-object ($Smo + 'server') "$ipAddress"

	# Use Windows Authentication by setting LoginSecure to TRUE
	Write-Debug "Setting Windows Authentication mode..."
	$smoServer.ConnectionContext.set_LoginSecure($TRUE)
	
	# Clear the screen
	# TIP: cls will clear the PowerShell console
	cls
	Write-Host Your connection string contains these values:
	Write-Host
	$smoServer.ConnectionContext.ConnectionString.Split(";")
	Write-Host
	
	# List information about the databases
	Write-Host "Databases on " $ipAddress
	Write-Host
	foreach ($db in $smoServer.Databases) 
	{
		write-host "Database Name : " $db.Name
		write-host "Owner         : " $db.Owner
		write-host
	}
}

main