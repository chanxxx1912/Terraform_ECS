provider "aws"{
    region = "ap-northeast-1"
   
}



variable "aws_region" {
  type        = string
  description = "The region in which to create and manage resources"
  default     = "ap-northeast-1"
}

locals {
  aws_region = "ap-northeast-1a"
  prefix     = "Terraform-ECS-Demo"
  common_tags = {
    Project   = local.prefix
    ManagedBy = "Terraform"
  }
  vpc_cidr = var.vpc_cidr
}