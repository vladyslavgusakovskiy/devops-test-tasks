terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = var.aws_version
    }
  }
}

provider "aws" {
  region = var.aws_region
}
