<#
.SYNOPSIS
    List Property Info.

.DESCRIPTION
    List Property Info.

.PARAMETER serverInstance
    server Instance.

.PARAMETER verbose
    verbose.

.PARAMETER debug
    debug.

.EXAMPLE
    PS C:\> .\List-MSSQL-PropertyInfo.ps1

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
	List-MSSQL-PropertyInfo $serverInstance
}

function List-MSSQL-PropertyInfo($serverInstance)
{
	# Retrieve SQL Server advanced properties and settings using WMI
	Get-WmiObject sqlserviceadvancedproperty `
		-namespace "root\Microsoft\SqlServer\ComputerManagement10" -computername $serverInstance | 
		Select-Object -Property PropertyName, PropertyNumValue, PropertyStrValue
}

main