<#
.SYNOPSIS
    PowerShell Script To Crawl Errors and Exceptions In Trace Logs With HTML Email Functionality.

.DESCRIPTION
    PowerShell Script To Crawl Errors and Exceptions In Trace Logs With HTML Email
    Functionality.

.PARAMETER criticalItems
    Add additional Items here e.g. , "Exception".

.EXAMPLE
    PS C:\> .\SP2013MonitorDiagnosticLogs.ps1
    Edit the variables section and run to powerShell Script To Crawl Errors and Exceptions In Trace Logs With HTML Email Functionality.
#>

############# Start Variables ################
$logDirectory = "D:\Logs\Diagnostic Logs\*.log"
$emailFrom = "FromEmailAddress"
$emailTo = @("Email1","Email2")
$subject = "SharePoint Diagnostics Critical Alert"
$smtpserver = "EmailServer"
############# End Variables ##################
$latestLogFile = get-childitem $logDirectory | sort LastWriteTime -desc | select -first 1
$criticalItems = Select-String $latestLogFile.FullName -Pattern "Critical" #Add additional Items here e.g. , "Exception"
if($criticalItems -ne $null)
{  
     $body = ""  
     foreach($criticalItem in $criticalItems)  
     {   
         $body += "<b>Error:</b> " + $criticalItem.Line + "<br><br>"   
         $body += "<b>Line Number:</b> " + $criticalItem.LineNumber + "<br><br>"   
         $body += "<b>File Path:</b> " + $criticalItem.Path + "<br><br>"   
         $body += "===================================<br><br>"  
     }    

     Send-MailMessage -To $emailTo -Subject $subject -Body $body -SmtpServer $smtpserver -From $emailFrom -BodyAsHtml
}