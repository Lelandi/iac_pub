terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-backends"
    storage_account_name = "backendslelandi"
    container_name       = "backend-prod"
    key                  = "vmapp-prod/terraformvmapp.tfstate"
  }
}