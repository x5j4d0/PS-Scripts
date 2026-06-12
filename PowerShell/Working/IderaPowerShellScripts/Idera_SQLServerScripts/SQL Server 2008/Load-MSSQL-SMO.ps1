<#
.SYNOPSIS
    Load MSSQL SMO.

.DESCRIPTION
    Load MSSQL SMO.

.EXAMPLE
    PS C:\> .\Load-MSSQL-SMO.ps1
    Load MSSQL SMO.
#>

# Load-MSSQL-SMO.ps1
#

[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.Management.Common" );
[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.SmoEnum" );
[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.Smo" );
[void][reflection.assembly]::LoadWithPartialName( "Microsoft.SqlServer.SmoExtended " );
