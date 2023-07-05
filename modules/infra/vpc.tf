module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name                    = "${var.environment}"
  cidr                    = lookup(var.vpc_cidr, var.environment)
  azs                     = local.azs
  private_subnets         = local.private_subnets
  public_subnets          = local.public_subnets
  create_igw              = true
  enable_dns_hostnames    = true
  enable_dns_support      = true
  map_public_ip_on_launch = false
  
  # Public Subnets ACL
  public_dedicated_network_acl = true
  public_outbound_acl_rules    = local.public_outbound_acl_rules
  public_inbound_acl_rules     = local.public_inbound_acl_rules

  # Private/wp Subnets ACL
  private_outbound_acl_rules   = local.private_outbound_acl_rules
  private_inbound_acl_rules    = local.private_inbound_acl_rules

  # Database Subnets
  database_subnets               = lookup(var.private_db_subnets, var.environment)
  database_subnet_group_name     = "${var.environment}-postgres"
  database_dedicated_network_acl = true
  database_inbound_acl_rules     = local.database_inbound_acl_rules
  database_outbound_acl_rules    = local.database_outbound_acl_rules
  
  database_subnet_tags    = {
     Environment          = "${var.environment}-postgres"
  }
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