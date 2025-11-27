variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-central-1"
}

variable "aws_version" {
  description = "The version of the AWS provider"
  type        = string
  default     = "~> 5.0"
}