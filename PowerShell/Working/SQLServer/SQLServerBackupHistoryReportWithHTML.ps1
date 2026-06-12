<#
.SYNOPSIS
    PowerShell Script to Query Backup History for SQL Instances with HTML Report Output.

.DESCRIPTION
    PowerShell Script to Query Backup History for SQL Instances with HTML Report Output.

.EXAMPLE
    PS C:\> .\SQLServerBackupHistoryReportWithHTML.ps1
    PowerShell Script to Query Backup History for SQL Instances with HTML Report Output.

.NOTES
    Resources:  http://msdn.microsoft.com/en-us/library/ms162189.aspx; http://blogs.msdn.com/b/jason_howell/archive/2010/10/25/list-of-sql-server-feature-packs.aspx
#>

#Change values of following variables as needed 
$ServerList = Get-Content "C:\Install\SQLInstances.txt" 
$OutputFile = "C:\Install\SQLBackupsReport.htm" 
 
$HTML = '<style type="text/css"> 
    #Header{font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;width:100%;border-collapse:collapse;} 
    #Header td, #Header th {font-size:14px;border:1px solid #98bf21;padding:3px 7px 2px 7px;} 
    #Header th {font-size:14px;text-align:left;padding-top:5px;padding-bottom:4px;background-color:#A7C942;color:#fff;} 
    #Header tr.alt td {color:#000;background-color:#EAF2D3;} 
    </Style>' 
     
$HTML += "<HTML><BODY><Table border=1 cellpadding=0 cellspacing=0 width=100% id=Header> 
        <TR> 
            <TH><B>Database Name</B></TH> 
            <TH><B>RecoveryModel</B></TD> 
            <TH><B>Last Full Backup Date</B></TH> 
            <TH><B>Last Differential Backup Date</B></TH> 
            <TH><B>Last Log Backup Date</B></TH> 
        </TR>" 
 
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null 
ForEach ($ServerName in $ServerList) 
{ 
    $HTML += "<TR bgColor='#ccff66'><TD colspan=5 align=left><B>$ServerName</B></TD></TR>" 
     
    $SQLServer = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $ServerName  
    Foreach($Database in $SQLServer.Databases) 
    { 
        $HTML += "<TR> 
                    <TD>$($Database.Name)</TD> 
                    <TD>$($Database.RecoveryModel)</TD> 
                    <TD>$($Database.LastBackupDate)</TD> 
                    <TD>$($Database.LastDifferentialBackupDate)</TD> 
                    <TD>$($Database.LastLogBackupDate)</TD> 
                </TR>" 
    } 
} 
 
$HTML += "</Table></BODY></HTML>" 
$HTML | Out-File $OutputFile
