module "networking_module" {
  source = "./networking"
  vpc_cidr_block = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr_1 = "10.0.2.0/24"
  private_subnet_cidr_2 = "10.0.3.0/24"
  route_cidr_block = "0.0.0.0/0"
}

module "aim_module" {
  source = "./iam"
}

module "eks_module" {
  source = "./eks"
  subnet_private_id_1 = module.networking_module.subnet_private_id_1
  subnet_private_id_2 = module.networking_module.subnet_private_id_2
  aim_role_eks_arn = module.aim_module.aim_role_eks_arn
  iam_role_nodes_arn = module.aim_module.aim_role_nodes_arn
  eks_worker_node_policy = module.aim_module.eks_worker_node_policy
  ec2_container_registry_read_only = module.aim_module.ec2_container_registry_read_only

  depends_on = [ module.aim_module ]
}