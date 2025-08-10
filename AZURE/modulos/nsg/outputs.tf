output "nsg_id" {
  description = "El ID del Network Security Group."
  value       = azurerm_network_security_group.nsg.id
}