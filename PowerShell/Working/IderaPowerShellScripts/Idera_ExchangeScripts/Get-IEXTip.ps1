<#
.SYNOPSIS
    Retrieve Tip.

.DESCRIPTION
    Retrieve Tip.

.PARAMETER number
    number.

.PARAMETER Online
    Online.

.EXAMPLE
    PS C:\> .\Get-IEXTip.ps1

#>

#requires -pssnapin Microsoft.Exchange.Management.PowerShell.Admin 


function Get-IEXTip
{ 

 param(
  $number = $null,
  [switch]$Online
 ) 

 trap
 {
  continue
 } 

 if ($Online) {
  (New-Object -com shell.application).Open('http://technet.microsoft.com/en-us/library/bb397216.aspx')
  return
 } 

     $exbin = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Exchange\Setup).MsiInstallPath + "bin" 


 if( ($exrandom -eq $null) -or ($exrandom -isnot [System.Random]))
 {
  $exrandom = New-Object System.Random
 } 

     $exchculture = (Get-UICulture).Parent.Name 

 if ( Test-Path "$exbin\$exchculture\extips.xml" )
 {
  $exchculture = $exchculture
 }
 else
 {
  $exchculture = 'en'
 } 

  

 if (Test-Path "$exbin\$exchculture\extips.xml")
 { 

  $tips = [xml](get-content "$exbin\$exchculture\extips.xml")
  if($number -eq $null)
  {
   $temp = $exrandom.Next( 0, $tips.topic.developerConceptualDocument.introduction.table.row.Count )
   write-host -fore Yellow ( "Tip of the day #" + $temp + ":`n" )
   $nav = $tips.topic.developerConceptualDocument.introduction.table.row[$temp].entry.CreateNavigator()
   $null =  $nav.MoveToFirstChild()
   
   do
   {
    write-host $nav.Value
   }
   while( $nav.MoveToNext() )
   write-host
  }
  else
  {
   $nav = $tips.topic.developerConceptualDocument.introduction.table.row[$number].entry.CreateNavigator()
   write-host -fore Yellow ( "Tip of the day #" + $number + ":`n" )
             $null = $nav.MoveToFirstChild()
   
   do
   {
    write-host $nav.Value
   }
   while( $nav.MoveToNext() )
   Write-Host
  }
 }
 else
 {
         "Exchange tips file '$exbin\$exchculture\extips.xml' not found!"
 }
} 

