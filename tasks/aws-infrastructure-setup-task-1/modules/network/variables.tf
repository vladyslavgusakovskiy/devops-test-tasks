variable "vpc_id" {
  description = "The ID of the VPC where network resources will be created"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "public_subnet_1_name" {
  description = "The name tag for the public subnet"
  type        = string
  default     = "PublicSubnet1"
}

variable "public_subnet_2_name" {
  description = "The name tag for the public subnet"
  type        = string
  default     = "PublicSubnet2"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_name" {
  description = "The name tag for the private subnet"
  type        = string
  default     = "PrivateSubnet"
}

variable "public_subnet_1_az" {
  description = "The availability zone for the first public subnet"
  type        = string
  default     = "eu-central-1a"
}

variable "public_subnet_2_az" {
  description = "The availability zone for the second public subnet"
  type        = string
  default     = "eu-central-1b"
}

variable "gw_name" {
  description = "The name tag for the internet gateway"
  type        = string
  default     = "MainInternetGateway"
}