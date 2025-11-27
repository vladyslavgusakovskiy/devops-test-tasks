variable "vpc_id" {
  description = "The ID of the VPC where network resources will be created"
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_name" {
  description = "The name tag for the public subnet"
  type        = string
  default     = "PublicSubnet"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_name" {
  description = "The name tag for the private subnet"
  type        = string
  default     = "PrivateSubnet"
}

variable "gw_name" {
  description = "The name tag for the internet gateway"
  type        = string
  default     = "MainInternetGateway"
}