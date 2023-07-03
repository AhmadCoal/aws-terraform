data "aws_availability_zones" "available" {
  state         = "available"
  exclude_names = ["us-east-1a","us-east-1d","us-east-1e","us-east-1f"]
}
