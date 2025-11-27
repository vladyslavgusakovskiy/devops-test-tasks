variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The tag name for the VPC"
  type        = string
  default     = "MyVPC"
}