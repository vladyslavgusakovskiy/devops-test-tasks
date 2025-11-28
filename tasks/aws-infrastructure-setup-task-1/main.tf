module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

module "network_services" {
  source = "./modules/network"
  vpc_id = module.vpc.vpc_id
}

module "tm_sg" {
  source = "./modules/securityGroup"
  vpc_id = module.vpc.vpc_id
}