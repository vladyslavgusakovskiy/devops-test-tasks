variable "tm_efs_name" {
  description = "The name of the EFS file system"
  type        = string
  default     = "tm-devops-efs"
}

variable "tm_efs_sg_id" {
  description = "The ID of the EFS security group"
  type        = string
}

variable "tm_subnet_private_id" {
  description = "The ID of the private subnet where the EFS mount target will be created"
  type        = string
}