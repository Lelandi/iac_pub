resource "azurerm_backup_protected_vm" "backup_policy" {
  resource_group_name = data.terraform_remote_state.core.outputs.azurerm_resource_group_name
  recovery_vault_name = data.terraform_remote_state.core.outputs.azurerm_recovery_services_vault_name
  source_vm_id        = azurerm_linux_virtual_machine.vmapp.id
  backup_policy_id    = data.terraform_remote_state.core.outputs.azurerm_backup_policy_vm_policy_silver_id
}