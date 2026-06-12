<#
.SYNOPSIS
    Start SQL Server Service.

.DESCRIPTION
    Start SQL Server Service.

.PARAMETER service
    service.

.PARAMETER verbose
    verbose.

.PARAMETER debug
    debug.

.EXAMPLE
    PS C:\> .\Start-SQLServerService.ps1

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
	Start-SQLServerService $service
}

function Start-SQLServerService()
{
	Start-Service $service
	Write-Host "$service service started"
}

main