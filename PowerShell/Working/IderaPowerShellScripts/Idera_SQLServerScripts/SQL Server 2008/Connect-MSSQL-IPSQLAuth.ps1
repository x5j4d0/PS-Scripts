<#
.SYNOPSIS
    Connect to IPSQL Auth.

.DESCRIPTION
    Connect to IPSQL Auth.

.PARAMETER ipAddress
    ip Address.

.PARAMETER verbose
    verbose.

.PARAMETER debug
    debug.

.EXAMPLE
    PS C:\> .\Connect-MSSQL-IPSQLAuth.ps1

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
	Connect-MSSQL-IPSQLAuth $ipAddress
}

function Connect-MSSQL-IPSQLAuth($ipAddress)
{
	trap [Exception] 
	{
		write-error $("TRAPPED: " + $_.Exception.Message);
		continue;
	}
	
	# Load SMO assemblies
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.Management.Common" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.SmoEnum" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.Smo" );
	[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.SmoExtended " );
	
	$smoServer = new-object( 'Microsoft.SqlServer.Management.Smo.Server' ) ($ipAddress)

	# The connection will use SQL Authentication, so set LoginSecure to FALSE
	$smoServer.ConnectionContext.set_LoginSecure($FALSE)
	
	# Pop a credentials box to get User Name and Password
	$LoginCredentials = Get-Credential
	
	# If the user does not specify a domain, UserName will begin with a slash.
	# Remove leading slash from UserName
	$Login = $LoginCredentials.UserName -replace("\\","")
	
	# Set properties of ConnectionContext
	$smoServer.ConnectionContext.set_EncryptConnection($FALSE)
	$smoServer.ConnectionContext.set_Login($Login)
	$smoServer.ConnectionContext.set_SecurePassword($LoginCredentials.Password)
	
	# The connection is established the first time you access the server's properties.
	cls
	Write-Host Your connection string contains these values:
	Write-Host
	Write-Host $smoServer.ConnectionContext.ConnectionString.Split(";")
	Write-Host
	
	# List info about databases on the instance.
	Write-Host "Databases on $ipAddress "
	Write-Host
	foreach ($Database in $smoServer.Databases) 
	{
		write-host "Database Name : " $Database.Name
		write-host "Owner         : "	$Database.Owner
		write-host
	}
}

main
