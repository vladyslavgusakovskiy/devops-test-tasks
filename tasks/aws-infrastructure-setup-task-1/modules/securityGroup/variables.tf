variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "ald_sg_name" {
  description = "ALB Security Group Name"
  type        = string
  default     = "tm-ald-security-group"
}

variable "ecs_sg_name" {
  description = "ECS Security Group Name"
  type        = string
  default     = "tm-ecs-security-group"
}

variable "efs_sg_name" {
  description = "EFS Security Group Name"
  type        = string
  default     = "tm-efs-security-group"
}