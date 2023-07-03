# locals {
#   azs = data.aws_availability_zones.available.names

#   public_subnets  = [
#     for num in local.azs:
#       cidrsubnet(lookup(var.vpc_cidr, var.environment), 8, index(local.azs, num))
#   ]

#   private_subnets = var.private_subnets
# }

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name                    = "${var.environment}"
  cidr                    = lookup(var.vpc_cidr, var.environment)
  azs                     = local.azs
  private_subnets         = local.private_subnets
  public_subnets          = local.public_subnets
  create_igw              = true
  enable_dns_hostnames    = true
  map_public_ip_on_launch = false

  public_route_table_tags = {
    Environment           = var.environment
    type                  = "public"
  }
  private_route_table_tags = {
    Environment            = var.environment
    type                   = "private"
  }
  public_subnet_tags       = {
    Environment            = var.environment
    type                   = "public"
  }
  private_subnet_tags      = {
    Environment            = var.environment
    type                   = "private"
  }
}