<#
.SYNOPSIS
    Stop SQL Server Service.

.DESCRIPTION
    Stop SQL Server Service.

.PARAMETER service
    service.

.PARAMETER verbose
    verbose.

.PARAMETER debug
    debug.

.EXAMPLE
    PS C:\> .\Stop-SQLServerService.ps1

#>

param
(
	[string]$service = "MSSQLServer",
	[switch]$verbose,
	[switch]$debug
)

function main()
{
	if ($verbose) {$VerbosePreference = "Continue"}
	if ($debug) {$DebugPreference = "Continue"}
	Stop-SQLServerService $service
}

function Stop-SQLServerService()
{
	Stop-Service $service -Force
	Write-Host "$service service stopped"
}

main