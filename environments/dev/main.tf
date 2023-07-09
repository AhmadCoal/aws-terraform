locals {
  environment              = "dev"
}

module "infra" {
  environment                   = local.environment
  source = "../../modules/infra"
}