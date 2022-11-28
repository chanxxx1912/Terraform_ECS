
module "ecs_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${local.prefix}-vpc"
  cidr = local.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway     = true
  enable_dns_hostnames   = true
  one_nat_gateway_per_az = true

  tags = local.common_tags
}
variable "vpc_cidr" {
  default = "10.100.0.0/16"
}

variable "azs" {
  type = list(string)
  description = "the name of availability zones to use subnets"
  default = [ "ap-northeast-1a"]
}

variable "public_subnets" {
  type = list(string)
  description = "the CIDR blocks to create public subnets"
  default = [ "10.100.10.0/24", "10.100.20.0/24" ]
}

variable "private_subnets" {
  type = list(string)
  description = "the CIDR blocks to create private subnets"
  default = [ "10.100.30.0/24", "10.100.40.0/24" ]
}
