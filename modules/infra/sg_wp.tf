resource "aws_security_group" "wp_internal" {
  vpc_id              = module.vpc.vpc_id
  name                = "${var.environment}-wp-internal"
  description         = "Security group for wp traffic. Must only be attached to database wp ec2s."

  tags = {
    Name              = "${var.environment}-wp-internal"
  }

  ingress {
    cidr_blocks       = lookup(var.private_wp_subnets, var.environment)
    from_port         = var.application_port
    to_port           = var.application_port
    protocol          = "tcp"
    description       = "Allow tcp traffic from wp app private subnets within the vpc."
  }

  ingress {
    cidr_blocks       = local.public_subnets
    from_port         = var.application_port
    to_port           = var.application_port
    protocol          = "tcp"
    description       = "Allow tcp traffic from alb public subnets within the vpc."
  }

  egress {
    cidr_blocks       = lookup(var.private_db_subnets, var.environment)
    from_port         = var.database_port
    to_port           = var.database_port
    protocol          = "tcp"
    description       = "Allow egress tcp traffic to ONLY db subnets."
  }
}
