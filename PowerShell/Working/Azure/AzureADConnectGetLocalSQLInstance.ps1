<#
.SYNOPSIS
    PowerShell Script to Get the Local SQL Instance Connection Details (Named Pipes).

.DESCRIPTION
    PowerShell Script to Get the Local SQL Instance Connection Details (Named Pipes).

.PARAMETER LocalSQLInstancePath
    Change this path if your local SQL instance path differs to the default installation location.

.EXAMPLE
    PS C:\> .\AzureADConnectGetLocalSQLInstance.ps1
    Edit the variables section and run to powerShell Script to Get the Local SQL Instance Connection Details (Named Pipes).

.NOTES
    Resources:  https://itfordummies.net/2017/02/13/manage-localdb-aad-connect-sql-database
#>

$LocalSQLInstancePath = "C:\Program Files\Microsoft SQL Server\110\Tools\Binn" #Change this path if your local SQL instance path differs to the default installation location

Set-Location -Path $LocalSQLInstancePath

.\SqlLocalDB.exe info

.\SqlLocalDB.exe info .\ADSync