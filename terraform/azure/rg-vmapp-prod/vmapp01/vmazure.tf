resource "azurerm_network_interface" "vmazure" {
  name                = "${var.app_name}-nic"
  location            = data.terraform_remote_state.core.outputs.azurerm_resource_group_location
  resource_group_name = data.terraform_remote_state.core.outputs.azurerm_resource_group_name

  ip_configuration {
    name                          = "${var.app_name}-interface"
    subnet_id                     = data.terraform_remote_state.core.outputs.azurerm_subnet_private_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vmazure" {
  name                = var.app_name
  resource_group_name = data.terraform_remote_state.core.outputs.azurerm_resource_group_name
  location            = data.terraform_remote_state.core.outputs.azurerm_resource_group_location
  size                = "Standard_D4s_v5"
  admin_username      = "lelandi"
  
  network_interface_ids = [
    azurerm_network_interface.vmazure.id,
  ]

  depends_on = [azurerm_network_interface.vmazure]
  admin_ssh_key {
    username   = "lelandi"
    public_key = file("~/terraform/sshKey/***REPLACE_BEFORE_USE***.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 150
    name                 = var.app_name
  }
  source_image_id = data.azurerm_image.search.id
}

data "azurerm_image" "search" {
  name                = "vm-imagem-base"
  resource_group_name = "rg-vmapp-prod"
}

# resource "azurerm_managed_disk" "vmazure_disk" {
#   name                 = "${var.app_name}-disk"
#   location             = data.terraform_remote_state.core.outputs.azurerm_resource_group_location
#   resource_group_name  = data.terraform_remote_state.core.outputs.azurerm_resource_group_name
#   storage_account_type = "StandardSSD_ZRS"
#   create_option        = "Empty"
#   disk_size_gb         = 100
#   depends_on           = [azurerm_linux_virtual_machine.vmazure]
# }

# resource "azurerm_virtual_machine_data_disk_attachment" "attachment_disk" {
#   managed_disk_id    = azurerm_managed_disk.vmazure_disk.id
#   virtual_machine_id = azurerm_linux_virtual_machine.vmazure.id
#   lun                = 1
#   caching            = "ReadWrite"
# }
