locals {
  azs = data.aws_availability_zones.available.names

  public_subnets  = [
    for num in local.azs:
      cidrsubnet(lookup(var.vpc_cidr, var.environment), 8, index(local.azs, num))
  ]

  private_subnets = var.private_subnets
}