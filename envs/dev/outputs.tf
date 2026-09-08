output "resource_group_name" {
  value = azurerm_resource_group.platform.name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "subnet_ids" {
  value = module.network.subnet_ids
}
