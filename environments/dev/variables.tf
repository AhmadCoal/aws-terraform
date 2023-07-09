variable "aws_region" {
  type    = map(string)
  default = {
    dev       = "us-east-1"
  }
}

variable "aws_profile" {
  type    = map(string)
  default = {
    dev       = "dev"
  }
}

variable "vpc_cidr" {
  type    = map(string)
  default = {
    dev   = "10.1.0.0/16"
  }
}