<#
.SYNOPSIS
    Script To Send an Email with HTML Formatting In The Message Body.

.DESCRIPTION
    Script To Send an Email with HTML Formatting In The Message Body.

.PARAMETER smtpServer
    Add your SMTP Server details here.

.PARAMETER smtpFrom
    Change the from address here.

.PARAMETER smtpTo
    Change the to address here. Add additional recipients with a ',' after each other.

.PARAMETER messageSubject
    Change the subject here.

.EXAMPLE
    PS C:\> .\SendEmailWithHTML.ps1
    Edit the variables section and run to script To Send an Email with HTML Formatting In The Message Body.
#>

$getdate = get-date  -Format D

$smtpServer = "smtp.server.here" #Add your SMTP Server details here
$smtpFrom = "fromemail@emailhere.com" #Change the from address here
$smtpTo = "toemail@emailhere.com" #Change the to address here. Add additional recipients with a ',' after each other
$messageSubject = "Subject details here" #Change the subject here

$message = New-Object System.Net.Mail.MailMessage $smtpfrom, $smtpto
$message.Subject = $messageSubject
$message.IsBodyHTML = $true

$message.Body = "<b>Meeting Time:</b> $getdate between 11:00 to 12:00 AM <br><br><b>Meeting Venue:</b>The House On the Hill <br><br>"

$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
$smtp.Send($message)