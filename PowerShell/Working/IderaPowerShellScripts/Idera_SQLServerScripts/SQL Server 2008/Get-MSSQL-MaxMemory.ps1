<#
.SYNOPSIS
    Retrieve Max Memory.

.DESCRIPTION
    Retrieve Max Memory.

.PARAMETER serverInstance
    server Instance.

.PARAMETER verbose
    verbose.

.PARAMETER debug
    debug.

.EXAMPLE
    PS C:\> .\Get-MSSQL-MaxMemory.ps1

#>

param
(
  	[string]$serverInstance = "local",
	[switch]$verbose,
	[switch]$debug
)

function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	Get-MSSQL-MaxMemory $serverInstance
}

function Get-MSSQL-MaxMemory($serverInstance)
{
	trap [Exception] 
	{
		write-error $("TRAPPED: " + $_.Exception.Message);
		continue;
	}

	#initialize ADO connection parameters
	Write-Debug "Initializing connection parameters..."
	$adoOpenStatic = 3
	$adoLockOptimistic = 3
	$timeout = 3

	#get memory configuration setting from sysconfigures system table
	# TIP: using ADO to run a query
	Write-Debug "Connecting to server: $serverInstance"
	$adoConnection = New-Object -comobject ADODB.Connection
	$adoRecordset = New-Object -comobject ADODB.Recordset
	$query = "SELECT value FROM [master].[dbo].[sysconfigures] WHERE config = 1544"
	$adoConnection.Set_ConnectionString("Provider=SQLOLEDB; Data Source=" + $srv + "; Initial Catalog=master; Integrated Security=SSPI")
	$adoConnection.Set_ConnectionTimeout($timeout)
	$adoConnection.Open()

	if ($adoConnection.State -eq "1") 
	{
		Write-Debug "Connection succeeded..."
   	$adoRecordset.Open($query, $adoConnection, $adoOpenStatic, $adoLockOptimistic)
   	$adoRecordset.MoveFirst()
   	$maxMemory = ($adoRecordset.Fields.Item("value").Value)
   	if ($maxMemory -eq 2147483647) 
   	{
			Write-Verbose "Max memory is set to unlimited"
	      $maxMemory = -1
   	} 
   	$adoRecordset.Close()
   	$adoConnection.Close()
	} 
	else 
	{
		Write-Debug "Connection failed..."
	   $maxMemory = -2
	}
	Write-Debug "Max memory is set to $maxMemory"
	Write-Output $maxMemory
}

main