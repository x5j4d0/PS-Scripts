<#
.SYNOPSIS
    Script to send an Email with Multiple Attachments from a File Path Folder.

.DESCRIPTION
    Script to send an Email with Multiple Attachments from a File Path Folder.

.PARAMETER filepath
    Change this to match your requirements.

.PARAMETER files
    You can modify the 'Get-ChildItem' parameters to refine what files you want to attach - Example: Get-ChildItem $filepath -Include *.txt.

.EXAMPLE
    PS C:\> .\SendEmailWithMultipleAttachments.ps1
    Edit the variables section and run to script to send an Email with Multiple Attachments from a File Path Folder.
#>

#Connection Details
$username=""
$password=""
$smtpServer = "YourSMTPServer.com"
$msg = new-object Net.Mail.MailMessage

#Change port number for SSL to 587
$smtp = New-Object Net.Mail.SmtpClient($SmtpServer, 25) 

#Uncomment Next line for SSL  
#$smtp.EnableSsl = $true

$smtp.Credentials = New-Object System.Net.NetworkCredential( $username, $password )

#From Address
$msg.From = "yourfromemailaddress@yourdomain.com"
#To Address, Copy the below line for multiple recipients
$msg.To.Add("yourtoemailaddress@yourdomain.com")

#Message Body
$msg.Body="Please See Attached Files" #Change this to match your requirements

#Message Subject
$msg.Subject = "Email with Multiple Attachments" #Change this to match your requirements

#your file location
$filepath = "\\ShareName\FolderName" #Change this to match your requirements
$files=Get-ChildItem $filepath #You can modify the 'Get-ChildItem' parameters to refine what files you want to attach - Example: Get-ChildItem $filepath -Include *.txt

Foreach($file in $files)
{
Write-Host "Attaching File :- " $file
$attachment = New-Object System.Net.Mail.Attachment –ArgumentList $filepath\$file
$msg.Attachments.Add($attachment)

}
$smtp.Send($msg)
$attachment.Dispose();
$msg.Dispose();
