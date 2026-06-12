<#
.SYNOPSIS
    PowerShell Script To Update All Sites Request Access Email Addresses.

.DESCRIPTION
    PowerShell Script To Update All Sites Request Access Email Addresses.

.EXAMPLE
    PS C:\> .\SP2013UpdateRequestAccessEmail.ps1
    PowerShell Script To Update All Sites Request Access Email Addresses.
#>

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint") > $null

#For SharePoint 2007 compatibility

function global:Get-SPSite($url){

    return new-Object Microsoft.SharePoint.SPSite($url)

}

#Get the web application

Write-Host "Enter the Web Application URL:"

$WebAppURL= Read-Host

$SiteColletion = Get-SPSite($WebAppURL)

$WebApp = $SiteColletion.WebApplication

 

   # Get All site collections

    foreach ($SPsite in $webApp.Sites)

    {

       # get the collection of webs

       foreach($SPweb in $SPsite.AllWebs)

        {

              # if a site inherits permissions, then the Access request mail setting also will be inherited

             if (!$SPweb.HasUniquePerm)

               {

                  Write-Host "Inheriting from Parent site"

               }

             else

           {

              #$SPweb.RequestAccessEnabled=$true

              $SPweb.RequestAccessEmail ="support@yourdomain.com" #Change this email address to suit your environment

              $SPweb.Update()

           }

        }

    }
