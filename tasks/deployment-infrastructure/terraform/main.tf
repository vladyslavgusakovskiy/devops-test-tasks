module "networking_module" {
  source = "./networking"
  vpc_cidr_block = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  route_cidr_block = "0.0.0.0/0"
}

module "aim_module" {
  source = "./iam"
}

module "eks_module" {
  source = "./eks"
  aim_role_eks_arn = module.aim_module.aim_role_eks_arn
}
