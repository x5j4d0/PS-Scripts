<#
.SYNOPSIS
    Script that uses SQL Server PowerShell Module (SQLPS) Function to Query a SQL Instance with Grid View Output (Out-GridView).

.DESCRIPTION
    Script that uses SQL Server PowerShell Module (SQLPS) Function to Query a SQL Instance
    with Grid View Output (Out-GridView).

.EXAMPLE
    PS C:\> .\SQLOutGridViewQueryFunction.ps1
    Script that uses SQL Server PowerShell Module (SQLPS) Function to Query a SQL Instance with Grid View Output (Out-GridView).

.NOTES
    Requires:   SQLPS
#>

#Import SQL Server module
Import-Module SQLPS -DisableNameChecking

function Out-SqlGrid(
    [string]$query="EXEC sp_databases", #Copy your SQL query here, and ensure it remains between the double qoutations ""
    [string]$title=$query,
    [string]$ServerInstance="SQLINSTANCENAME", #Provide your SQL Instance here
    [string]$Database="master" #Provide your Database name here
    )
{
    Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query $query | Out-GridView -Title $title
}

#Call the function
Out-SqlGrid