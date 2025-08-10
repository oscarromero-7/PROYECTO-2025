module "vnet" {
  source = "./modules/vnet"
  vpc_cidr_block = var.vpc_cidr_block
  region = var.region
}

module "nsg" {
  source = "./modules/nsg"
  vpc_id = module.vnet.vpc_id
  security_group_name = var.security_group_name
}

module "vm" {
  source = "./modules/vm"
  ami_id = var.ami_id
  instance_type = var.instance_type
  subnet_id = module.vnet.subnet_id
  security_group_id = module.nsg.security_group_id
}
