output "subnet_id" {
  description = "El ID de la subred para conectar otros recursos."
  value       = azurerm_subnet.subnet.id
}