resource "aws_security_group" "alb_external" {
  vpc_id              = module.vpc.vpc_id
  name                = "${var.environment}-alb-external"
  description         = "Security group for alb traffic management."

  tags = {
    Name              = "${var.environment}-alb-external"
  }

  ingress {
    cidr_blocks       = ["0.0.0.0/0"]
    from_port         = var.application_port
    to_port           = var.application_port
    protocol          = "tcp"
    description       = "Allow traffic from all sources at port 80"
  }

  egress {
    cidr_blocks       = lookup(var.private_wp_subnets, var.environment)
    from_port         = var.application_port
    to_port           = var.application_port
    protocol          = "tcp"
    description       = "Allow egress tcp traffic to ONLY app subnets."
  }
}
