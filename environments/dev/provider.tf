provider "aws" {
  region  = lookup(var.aws_region, var.environment)
  profile = lookup(var.aws_profile, var.environment)
  # Rather pass creds somewhere else. ENVs in a pipeline or secret manager.
  shared_config_files      = ["$HOME/.aws/config"]
  shared_credentials_files = ["$HOME/.aws/credentials"]
}

terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    aws        = ">= 4.0"
  }
}
