# 1. Crear el Grupo de Recursos
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# 2. Llamar al Módulo VNet (Red Virtual)
module "vnet" {
  source = "./modulos/vnet"

  # Pasamos las variables que el módulo necesita
  vnet_name           = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

# 3. Llamar al Módulo NSG (Grupo de Seguridad de Red)
module "nsg" {
  source = "./modulos//nsg"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = module.vnet.subnet_id # Dependencia del módulo vnet
}

# 4. Llamar al Módulo VM (Máquina Virtual)
module "vm" {
  source = "./modulos/vm"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = module.vnet.subnet_id     # Dependencia del módulo vnet
  nsg_id              = module.nsg.nsg_id         # Dependencia del módulo nsg
  vm_username         = var.vm_username
  vm_password         = var.vm_password
}