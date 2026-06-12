<#
.SYNOPSIS
    Useful function to Search a File Path Location for Phrase Key Words.

.DESCRIPTION
    Useful function to Search a File Path Location for Phrase Key Words.

.PARAMETER true
    true.

.EXAMPLE
    PS C:\> .\SearchForPhraseInFiles.ps1
    Useful function to Search a File Path Location for Phrase Key Words.
#>

#requires -Version 3
function Find-Script
{
  param
  (
    [Parameter(Mandatory = $true)]
    $SearchPhrase,
    $Path = [Environment]::GetFolderPath('MyDocuments')
  )

  Get-ChildItem -Path $Path  -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue |
  Select-String -Pattern $SearchPhrase -List |
  Select-Object -Property Path, Line |
  Out-GridView -Title "All Scripts containing $SearchPhrase" -PassThru |
  ForEach-Object -Process {
    ise $_.Path
  }
}

#Example
#Find-Script -SearchPhrase "Content Type Hub" -Path "C:\BoxBuild\GitHub\Scripts\PowerShell\Working"