#Import existing Resource Group
data "azurerm_resource_group" "resource_group" {
  name = var.rg_name
}

#Creates the Azure Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  address_space       = var.vnet_address_space

  tags = var.tags
  depends_on      = [data.azurerm_resource_group.resource_group]
}

# Creating of Subnet for Kubernetes
resource "azurerm_subnet" "k8s_subnet" {
  name                 = var.k8s_subnet_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

  depends_on      = [data.azurerm_resource_group.resource_group]
}

# Creating of Subnet for Container Instance
resource "azurerm_subnet" "ci_subnet" {
  name                 = var.ci_subnet_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]

  depends_on      = [data.azurerm_resource_group.resource_group]
}