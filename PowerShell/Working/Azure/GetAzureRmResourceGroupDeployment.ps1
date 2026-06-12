<#
.SYNOPSIS
    Useful Azure RM Resource Group Deployment Commands (AzureRMResourceGroupDeployment).

.DESCRIPTION
    Useful Azure RM Resource Group Deployment Commands (AzureRMResourceGroupDeployment).

.EXAMPLE
    PS C:\> .\GetAzureRmResourceGroupDeployment.ps1
    Useful Azure RM Resource Group Deployment Commands (AzureRMResourceGroupDeployment).
#>

# Get Azure RM Resource Group Deployment Details
Get-AzureRmResourceGroupDeployment -ResourceGroupName "YourResourceGroupName"
Get-AzureRmResourceGroupDeployment -ResourceGroupName "YourResourceGroupName" | Select DeploymentName, ResourceGroupName, ProvisioningState

# Stop Azure RM Resource Group Deployment
Stop-AzureRmResourceGroupDeployment -ResourceGroupName "YourResourceGroupName" -Name "YourDeploymentName"