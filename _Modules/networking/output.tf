output "vnetid" {
  value = azurerm_virtual_network.vnet.id
}

output "k8s_subnet_id" {
  value = azurerm_subnet.k8s_subnet.id
}

output "k8s_subnet_name" {
  value = azurerm_subnet.k8s_subnet.name
}

output "ci_subnet_id" {
  value = azurerm_subnet.ci_subnet.id
}