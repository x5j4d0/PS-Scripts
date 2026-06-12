<#
.SYNOPSIS
    Using PowerShell To Run Log Parser Queries.

.DESCRIPTION
    Using PowerShell To Run Log Parser Queries.

.PARAMETER iisfiles
    Variable for the IIS log files.

.EXAMPLE
    PS C:\> .\ProtocolStatusQuery.ps1
    Edit the variables section and run to using PowerShell To Run Log Parser Queries.
#>

$iisfiles = dir $args[0] #Variable for the IIS log files
#The 2 variables below make use of the LogParser COM Object
$m = New-Object -comobject MSUtil.LogQuery
$pif = New-Object -comobject MSUtil.LogQuery.IISW3CInputFormat

foreach ($iisfile in $iisfiles) 
{

$SQL = "select DISTINCT cs-username, date, cs-uri-stem, sc-status from $iisfile where (sc-status >= 500 AND sc-status < 600) AND (cs-uri-stem LIKE '%.ASPX') "
$recordSet = $m.Execute($SQL, $pif)

"DATE        USER	   URL      				STATUS"
"====================================================================="
for(; !$recordSet.atEnd(); $recordSet.moveNext())
{
  $record=$recordSet.getRecord(); 
  write-host ($record.GetValue(“date”).toshortdatestring() + “--” + $record.GetValue(“cs-username”) + “--” + $record.GetValue(“cs-uri-stem”) + “--”+ $record.GetValue(“sc-status”));
}

$recordSet.Close(); 

}