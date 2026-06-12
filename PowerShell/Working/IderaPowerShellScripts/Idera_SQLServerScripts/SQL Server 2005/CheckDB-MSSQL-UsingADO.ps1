<#
.SYNOPSIS
    Check database integrity for Using ADO.

.DESCRIPTION
    Check database integrity for Using ADO.

.PARAMETER serverInstance
    server Instance.

.PARAMETER dbName
    db Name.

.PARAMETER verbose
    verbose.

.PARAMETER debug
    debug.

.EXAMPLE
    PS C:\> .\CheckDB-MSSQL-UsingADO.ps1

#>

param
(
   [string]$serverInstance = ".",
  	[string]$dbName = "AdventureWorks",
	[switch]$verbose,
	[switch]$debug
)

function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	CheckDB-MSSQL-UsingADO $serverInstance $dbName
}

function CheckDB-MSSQL-UsingADO($serverInstance, $dbName)
{
	trap [Exception] 
	{
		write-error $("TRAPPED: " + $_.Exception.Message);
		continue;
	}

	$cn = new-object system.data.SqlClient.SqlConnection( `
		"Data Source=$serverInstance;Integrated Security=SSPI;Initial Catalog=$dbName");
	$ds = new-object System.Data.DataSet "dsCheckDB"
	$query = "DBCC CHECKDB($dbName) WITH TABLERESULTS"
	$da = new-object "System.Data.SqlClient.SqlDataAdapter" ($query, $cn)
	$da.Fill($ds)

	$dtCheckDB = new-object "System.Data.DataTable" "dsCheckDB"
	$dtCheckDB = $ds.Tables[0]
	$dtCheckDB | Format-Table -autosize `
		-property Error, Level, State, MessageText, `
						RepairLevel, Status, DbId, ObjectId, `
						IndexId, PartitionId, AllocUnitId, File, `
						Page, Slot, RefFile, RefPage, RefSlot, Allocation
}

main