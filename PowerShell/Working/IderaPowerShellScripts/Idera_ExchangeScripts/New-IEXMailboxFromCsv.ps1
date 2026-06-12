<#
.SYNOPSIS
    Create a new Mailbox From Csv.

.DESCRIPTION
    Create a new Mailbox From Csv.

.PARAMETER CsvFilePath
    Csv File Path.

.EXAMPLE
    PS C:\> .\New-IEXMailboxFromCsv.ps1

#>

# Name,SamAccountName,Password,FirstName,LastName,Database,OrganizationalUnit
# Test1,Test1,P@ssw0rd,Test,User1,Mailbox Database,"domain.com/users"
# Test2,Test2,P@ssw0rd,Test,User2,Mailbox Database,
# Test3,Test3,P@ssw0rd,Test,User3,Mailbox Database,"cn=users,dc=domain,dc=com"


#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 

function New-IEXMailboxFromCsv
{ 

    param(
    [string]$CsvFilePath = $(Throw "Parameter 'CsvFilePath' cannot be empty"),
    [switch]$ResetPasswordOnNextLogon,
    [switch]$WhatIf,
    [switch]$Confirm
    )

    trap {
        Write-Error $_
        continue
    }

    if(Test-Path -Path $CsvFilePath -PathType Leaf)
    {

        $DomainFQDN = ([ADSI]"").distinguishedName -replace 'dc=' -replace ',','.'

        Import-Csv -Path $CsvFilePath | Foreach-Object {
            $line = $_

            if(!$_.OrganizationalUnit) {  
                Write-Warning "OU name was not specified, '$DomainFQDN/Users'  will be used ins."
                $_.OrganizationalUnit = "$DomainFQDN/Users" 
            }

            $db = Get-MailboxDatabase | Where-Object {$_.Name -eq $line.Database}

            if(!$db)
            {
                Throw "Database '$Database' could not be found"
            }

            $Pwd = ConvertTo-SecureString -String $_.Password -AsPlainText -Force

            $UPN = "{0}@$DomainFQDN" -f $_.name

            New-Mailbox -Name $_.Name -FirstName $_.FirstName -LastName $_.LastName -SamAccountName $_.SamAccountName -Password $Pwd -Database $db -UserPrincipalName $UPN -OrganizationalUnit $_.OrganizationalUnit -ResetPasswordOnNextLogon:([bool]$ResetPasswordOnNextLogon) -WhatIf:$WhatIf -Confirm:$Confirm
        }
    }
    else
    {
        Throw "File: '$CsvFilePath' cannot be found"
    }
}