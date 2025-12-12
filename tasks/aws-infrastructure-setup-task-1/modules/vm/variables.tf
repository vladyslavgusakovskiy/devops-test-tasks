variable "subnet_public_id" {
  description = "The ID of the public subnet where the VM will be deployed"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the VM"
  type        = string
}

variable "efs_id" {
  description = "The ID of the EFS to associate with the VM"
  type = string
}

variable "efs_mount_target_ip_address" {
  description = "The IP address of the EFS mount target to associate with the VM"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key to upload to AWS"
  type        = string
  default     = "/Users/vladyslav.gusakovskiy/.ssh/id_rsa.pub"
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key for provisioner connections"
  type        = string
  default     = "/Users/vladyslav.gusakovskiy/.ssh/id_rsa"
}