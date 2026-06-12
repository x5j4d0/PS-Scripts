<#
.SYNOPSIS
    Script To Configure And Enable Client And Target Machines For PowerShell Remoting (WinRM).

.DESCRIPTION
    Script To Configure And Enable Client And Target Machines For PowerShell Remoting
    (WinRM).

.PARAMETER DelegateMachines
    Change the machine names or use a whole domain like the example below.

.EXAMPLE
    PS C:\> .\EnablePSRemoting.ps1
    Edit the variables section and run to script To Configure And Enable Client And Target Machines For PowerShell Remoting (WinRM).
#>

$DelegateMachines = "SERVER1", "SERVER2", "SERVER3" #Change the machine names or use a whole domain like the example below
#$DelegateMachines = "*.DOMAIN.com"

# Configures the Client for WinRM and WSManCredSSP
Write-Host "Configuring PowerShell remoting..."
$winRM = Get-Service -Name winrm
If ($winRM.Status -ne "Running") {Start-Service -Name winrm}
Set-ExecutionPolicy Bypass -Force
Enable-PSRemoting -Force
Enable-WSManCredSSP -Role Client -delegatecomputer $DelegateMachines -Force | Out-Null

#Get out of this PowerShell process
Stop-Process -Id $PID -Force

## 2: Enable PSRemoting on your Target (target machine that will be receiving PSRemoting commands) ##

# Configures the Target for WinRM and WSManCredSSP
Write-Host "Configuring PowerShell remoting..."
$winRM = Get-Service -Name winrm
If ($winRM.Status -ne "Running") {Start-Service -Name winrm}
Set-ExecutionPolicy Bypass -Force
Enable-PSRemoting -Force
Enable-WSManCredSSP -Role Server -Force | Out-Null
# Increase the local memory limit to 1 GB
Set-Item WSMan:\localhost\Shell\MaxMemoryPerShellMB 1024

#Get out of this PowerShell process
Stop-Process -Id $PID -Force



