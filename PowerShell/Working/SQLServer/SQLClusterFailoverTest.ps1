<#
.SYNOPSIS
    Script to Test SQL Server Clusters For Failover.

.DESCRIPTION
    Script to Test SQL Server Clusters For Failover.

.EXAMPLE
    PS C:\> .\SQLClusterFailoverTest.ps1
    Script to Test SQL Server Clusters For Failover.

.NOTES
    Requires:   FailoverClusters
#>

Import-Module FailoverClusters;

# Set cluster name
$cluster = "Cluster";

# Date stamp used for report name
$date = Get-Date -Format "yyyyMMdd";

# Take cluster services offline. You may need to customise this
# according to your specific needs
Stop-ClusterGroup -Cluster $cluster -Name "ClusterDtc";
Stop-ClusterGroup -Cluster $cluster -Name "SQL Server (MSSQLSERVER)";

# Test Cluster
Test-Cluster -Cluster $cluster -ReportName "$date";

# Bring services back online
Start-ClusterGroup -Cluster $cluster -Name "ClusterDtc";
Start-ClusterGroup -Cluster $cluster -Name "SQL Server (MSSQLSERVER)"; 

