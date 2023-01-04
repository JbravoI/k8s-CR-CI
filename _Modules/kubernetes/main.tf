#Import existing Resource Group
data "azurerm_resource_group" "resource-group" {
  name = var.rg_name
}

resource "azurerm_kubernetes_cluster" "kube" {
  name                    = var.kubernetes_name
  location                = data.azurerm_resource_group.resource-group.location
  resource_group_name     = data.azurerm_resource_group.resource-group.name
  dns_prefix              = var.dns_prefix
  kubernetes_version      = var.kubernetes_version
  # subnet_name             = var.subnet_name
  # vnet_subnet_id          = var.subnet_id
  # outbound_type           = var.outbound_type
  # load_balancer_sku       = var.load_balancer_sku
  default_node_pool {
    name       = var.kubernetes_default_node_pool_name
    node_count = 1
    vm_size    = var.vm_size
    enable_auto_scaling     = var.enable_auto_scaling
    max_count               = var.max_count
    min_count               = var.min_count
  }

  identity {
    type = var.identity_type
  }
  tags                = var.tags
  depends_on = [data.azurerm_resource_group.resource-group]
}