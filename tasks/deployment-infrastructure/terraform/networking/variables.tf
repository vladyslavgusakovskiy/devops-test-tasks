variable "vpc_cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
}

variable "public_subnet_cidr" {
    description = "The CIDR block for the public subnet"
    type        = string
}

variable "private_subnet_cidr_1" {
    description = "The CIDR block for the first private subnet"
    type        = string
}

variable "private_subnet_cidr_2" {
    description = "The CIDR block for the second private subnet"
    type        = string
}

variable "route_cidr_block" {
    description = "The CIDR block for the route"
    type        = string
}