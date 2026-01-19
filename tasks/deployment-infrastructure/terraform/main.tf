module "networking_module" {
  source                = "./networking"
  vpc_cidr_block        = "10.0.0.0/16"
  public_subnet_cidr_1  = "10.0.1.0/24"
  public_subnet_cidr_2  = "10.0.2.0/24"
  private_subnet_cidr_1 = "10.0.3.0/24"
  private_subnet_cidr_2 = "10.0.4.0/24"
  route_cidr_block      = "0.0.0.0/0"
}

module "aim_module" {
  source = "./iam"
}

module "eks_module" {
  source               = "./eks"
  subnet_private_id_1  = module.networking_module.subnet_private_id_1
  subnet_private_id_2  = module.networking_module.subnet_private_id_2
  aim_role_eks_arn     = module.aim_module.aim_role_eks_arn
  iam_role_nodes_arn   = module.aim_module.iam_role_nodes_arn
  iam_role_aws_lbc_arn = module.aim_module.iam_role_aws_lbc_arn

  depends_on = [module.aim_module]
}

module "helm_module" {
  source           = "./helm"
  eks_cluster_name = module.eks_module.eks_cluster_name
  vpc_id           = module.networking_module.vpc_id

  depends_on = [module.eks_module]
}

module "rds_module" {
  source              = "./rds"
  vpc_id              = module.networking_module.vpc_id
  eks_cluster_name    = module.eks_module.eks_cluster_name
  subnet_private_id_1 = module.networking_module.subnet_private_id_1
  subnet_private_id_2 = module.networking_module.subnet_private_id_2

  depends_on = [module.eks_module]
}

module "s3_module" {
  source           = "./s3"
  eks_cluster_name = module.eks_module.eks_cluster_name

  depends_on = [module.eks_module]
}