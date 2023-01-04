#Import existing Resource Group
data "azurerm_resource_group" "resource-group" {
  name = var.rg_name
}

resource "azurerm_container_group" "container-instance" {
  name                = var.Container_instance_name
  location            = data.azurerm_resource_group.resource-group.location
  resource_group_name = data.azurerm_resource_group.resource-group.name
  ip_address_type     = var.ip_address_type
  dns_name_label      = var.dns_name_label
  os_type             = var.os_type
  # subnet_id           = var.subnet_id

  container {
    name   = var.container_name
    image  = var.container_image
    cpu    = var.container_cpu
    memory = var.container_memory

    ports {
      port     = var.container_port
      protocol = var.container_protocol
    }
  }

  container {
    name   = "sidecar"
    image  = "mcr.microsoft.com/azuredocs/aci-tutorial-sidecar"
    cpu    = "0.5"
    memory = "1.5"
  }

  tags                = var.tags
  depends_on = [data.azurerm_resource_group.resource-group]
}