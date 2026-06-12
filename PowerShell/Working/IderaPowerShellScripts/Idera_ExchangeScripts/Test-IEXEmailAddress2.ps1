<#
.SYNOPSIS
    Test Email Address2.

.DESCRIPTION
    Test Email Address2.

.PARAMETER EmailAddress
    Email Address.

.EXAMPLE
    PS C:\> .\Test-IEXEmailAddress2.ps1

#>

function Test-IEXEmailAddress2

{
    param (
        [string]$EmailAddress=$(throw "EmailAddress cannot be empty.")
    )  
    
    ($EmailAddress -as [System.Net.Mail.MailAddress]).Address -eq $EmailAddress -and $EmailAddress -ne $null 
} 

  