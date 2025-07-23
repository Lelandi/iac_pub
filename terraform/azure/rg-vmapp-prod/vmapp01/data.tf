data "terraform_remote_state" "core" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-terraform-backends"
    storage_account_name = "backends"
    container_name       = "backend-prod"
    key                  = "vmapp-prod/terraform.tfstate"
  }
}
