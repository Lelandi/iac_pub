resource "azurerm_public_ip" "public_ip_address" {
  name                = "${var.app_name}-ip-public"
  location            = data.terraform_remote_state.core.outputs.azurerm_resource_group_location
  resource_group_name = data.terraform_remote_state.core.outputs.azurerm_resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  ip_tags = {
    RoutingPreference = "Internet"
  }
}

resource "azurerm_lb" "loadbalancer" {
  name                = "${var.app_name}-loadbalancer"
  location            = data.terraform_remote_state.core.outputs.azurerm_resource_group_location
  resource_group_name = data.terraform_remote_state.core.outputs.azurerm_resource_group_name
  sku                 = "Standard"

  depends_on = [azurerm_public_ip.public_ip_address]
  frontend_ip_configuration {
    name                 = "${var.app_name}-frontend"
    public_ip_address_id = azurerm_public_ip.public_ip_address.id

  }
}

resource "azurerm_lb_backend_address_pool" "guiazure_backendpool" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "${var.app_name}-backendpool"
  depends_on      = [azurerm_lb.loadbalancer]
}

resource "azurerm_lb_rule" "lb_rule_http" {
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "LBRuleHttp"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${var.app_name}-frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.guiazure_backendpool.id]
}
resource "azurerm_lb_rule" "lb_rule_https" {
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "LBRuleHttps"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "${var.app_name}-frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.guiazure_backendpool.id]

}

resource "azurerm_lb_probe" "loadbalancer" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "http-running-probe"
  port            = 80
  depends_on      = [azurerm_lb.loadbalancer]
}


resource "azurerm_network_interface_backend_address_pool_association" "association" {
  network_interface_id    = azurerm_network_interface.vmzure.id
  ip_configuration_name   = azurerm_network_interface.vmazure.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.vmazure_backendpool.id
}