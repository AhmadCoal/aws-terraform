variable "environment" {
  type    = string
  default = "dev"
}

variable "aws_region" {
  type    = map(string)
  default = {
    dev   = "us-east-1"
  }
}

variable "aws_profile" {
  type    = map(string)
  default = {
    dev   = "dev"
  }
}

# INFRASTRUCTURE
variable "vpc_cidr" {
  type    = map(string)
  default = {
    dev   = "10.1.0.0/16"
  }
}

variable private_subnets {
  type    = list
  default = ["10.1.2.0/24","10.1.3.0/24","10.1.4.0/24","10.1.5.0/24"]
}

variable "private_db_subnets" {
  type    = map(list(string))
  default = {
    dev   = ["10.1.5.0/24","10.1.4.0/24"]
  }
}

variable "private_wp_subnets" {
  type    = map(list(string))
  default = {
    dev   = ["10.1.2.0/24","10.1.3.0/24"]
  }
}

# variable private_subnets {
#   type    = map(map(list(string)))
#   default = {
#     db    =  ["10.1.5.0/24","10.1.4.0/24"]
#     wp    =  ["10.1.2.0/24","10.1.3.0/24"]
#   }
# }

# DATABASE
variable "database_port" {
  type = number
  default = 3306
}

variable "deletion_protection" {
  type = bool
  default = true
}

# WP APPLICATION
variable "application_port" {
  type = number
  default = 80
}

variable "wp_instance_type" {
  type = string
  default = "t3a.micro"
}

# SSH
variable "aws_ssh_key_name" {
  type = string
  default = "aws_ec2_access_key"
}

# ALB
