resource "aws_security_group" "db_internal" {
  vpc_id              = module.vpc.vpc_id
  name                = "${var.environment}-db-internal"
  description         = "Security group for db internal traffic. Must only be attached to database ec2s."

  tags = {
    Name              = "${var.environment}-db-internal"
  }

  ingress {
    cidr_blocks       = var.private_subnets
    from_port         = var.database_port
    to_port           = var.database_port
    protocol          = "tcp"
    description       = "Allow tcp traffic from private subnets within the vpc."
  }

  egress {
    cidr_blocks       = lookup(var.private_db_subnets, var.environment)
    from_port         = var.database_port
    to_port           = var.database_port
    protocol          = "tcp"
    description       = "Allow egress tcp traffic to ONLY db subnets."
  }
}