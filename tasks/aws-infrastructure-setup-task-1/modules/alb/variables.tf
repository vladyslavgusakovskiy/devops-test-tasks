variable "security_group_id" {
  description = "The ID of the security group to be associated with the ALB"
  type        = string
}

variable "subnet_pub_1_id" {
  description = "The ID of the first public subnet"
  type        = string
}

variable "subnet_pub_2_id" {
  description = "The ID of the second public subnet"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB and target group will be created"
  type        = string
}