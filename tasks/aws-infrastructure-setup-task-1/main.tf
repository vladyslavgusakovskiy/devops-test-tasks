module "tm_vpc_module" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

module "tm_network_services_module" {
  source = "./modules/network"
  vpc_id = module.tm_vpc_module.vpc_id
}

module "tm_sg_module" {
  source = "./modules/securityGroup"
  vpc_id = module.tm_vpc_module.vpc_id
}

module "tm_efs_module" {
  source               = "./modules/efs"
  tm_efs_sg_id         = module.tm_sg_module.tm_efs_security_group_id
  tm_subnet_private_id = module.tm_network_services_module.tm_subnet_private_id
}

module "tm_iam_module" {
  source  = "./modules/iam"
  efs_arn = module.tm_efs_module.efs_arn
}

module "tm_ecs_module" {
  source                        = "./modules/ecs"
  tm_efs_id                     = module.tm_efs_module.efs_id
  tm_subnet_private_id          = module.tm_network_services_module.tm_subnet_private_id
  tm_ecs_security_group_id      = module.tm_sg_module.tm_ecs_security_group_id
  ecs_execution_role_arn        = module.tm_iam_module.ecs_execution_role_arn
  ecs_task_role_arn             = module.tm_iam_module.ecs_task_role_arn
  ecs_execution_role_attachment = module.tm_iam_module.ecs_execution_role_attachment_id
  alb_target_group_arn          = module.tm_alb_module.application_lb_tg_arn
}

module "tm_alb_module" {
  source            = "./modules/alb"
  security_group_id = module.tm_sg_module.tm_ald_security_group_id
  subnet_pub_1_id   = module.tm_network_services_module.tm_subnet_public_1_id
  subnet_pub_2_id   = module.tm_network_services_module.tm_subnet_public_2_id
  vpc_id            = module.tm_vpc_module.vpc_id
}

module "tm_vm_instance_module" {
  source                      = "./modules/vm"
  subnet_public_id            = module.tm_network_services_module.tm_subnet_public_id
  security_group_id           = module.tm_sg_module.tm_vm_security_group_id
  efs_id                      = module.tm_efs_module.efs_id
  efs_mount_target_ip_address = module.tm_efs_module.efs_mount_target_ip_address
  depends_on = [module.tm_efs_module]
}