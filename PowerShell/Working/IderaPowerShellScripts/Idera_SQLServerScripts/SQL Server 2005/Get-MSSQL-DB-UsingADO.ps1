<#
.SYNOPSIS
    Retrieve DB Using ADO.

.DESCRIPTION
    Retrieve DB Using ADO.

.PARAMETER serverInstance
    server Instance.

.PARAMETER verbose
    verbose.

.PARAMETER debug
    debug.

.EXAMPLE
    PS C:\> .\Get-MSSQL-DB-UsingADO.ps1

#>

param
(
  	[string]$serverInstance = ".",
	[switch]$verbose,
	[switch]$debug
)

function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	Get-MSSQL-DB-UsingADO $serverInstance
}

function Get-MSSQL-DB-UsingADO($serverInstance)
{
	# TIP: using PowerShell to create an exception handler
   trap [Exception] 
	{
      write-error $("TRAPPED: " + $_.Exception.Message);
      continue;
   }
	
	$adoOpenStatic = 3
	$adoLockOptimistic = 3
	
	# Create ADO connection and recordset objects	
	$adoConnection = New-Object -comobject ADODB.Connection
	$adoRecordset = New-Object -comobject ADODB.Recordset

	Write-Debug "Opening connection..."
	$adoConnection.Open("Provider=SQLOLEDB;Data Source=$serverInstance;Initial Catalog=master;Integrated Security=SSPI")
	
	# Run query to retrieve database ids and names
	$query = "SELECT dbid, name FROM master.dbo.sysdatabases ORDER BY name"
	$adoRecordset.Open($query, $adoConnection, $adoOpenStatic, $adoLockOptimistic)
	$adoRecordset.MoveFirst()
	
	Write-Debug "Retrieving results..."

	do 
	{
		$dbID = $adoRecordset.Fields.Item("dbid").Value
		$dbName = $adoRecordset.Fields.Item("name").Value
		Write-Output "$dbID : $dbName"
		$adoRecordset.MoveNext()
	} until ($adoRecordset.EOF -eq $TRUE)
	
	$adoRecordset.Close()
	$adoConnection.Close()
}

main