<#
.SYNOPSIS
    Simple SMTP Email Check Script.

.DESCRIPTION
    Simple SMTP Email Check Script.

.EXAMPLE
    PS C:\> .\SMTPEmailTest.ps1
    Simple SMTP Email Check Script.
#>

############# Start Variables ################
$SMTPServerName = "smtp.servername.com"
$MailServerPort = "25"
$SenderServerName = "ServerName"
$MailFrom = "SMTPTest@YourDomain.com"
$MailTo = "YourUser@YourDomain.com"
$Subject = "Subject:Telnet SMTP Mail Test"
$MailBody = "This is a Telnet SMTP Mail Test."
############# End Variables ################

Send-MailMessage –From $MailFrom –To $MailTo –Subject $Subject –Body $MailBody -SmtpServer $SMTPServerName