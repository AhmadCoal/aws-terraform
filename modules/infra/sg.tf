resource "aws_security_group" "ping_internal" {
  vpc_id              = module.vpc.vpc_id
  name                = "${var.environment}-ping-internal"
  description         = "Security group for to allow ping from all private subnets within the vpc."

  tags = {
    Name              = "${var.environment}-ping-internal"
  }

  ingress {
    cidr_blocks       = var.private_subnets
    from_port         = 0
    to_port           = 0
    protocol          = "icmp"
    description       = "Allow ping from all private subnets within the vpc."
  }

  egress {
    cidr_blocks       = var.private_subnets
    from_port         = 0
    to_port           = 0
    protocol          = "icmp"
    description       = "Allow ping from all private subnets within the vpc."
  }
}

# For time sake i made it so that you can ssh FROM/TO any instance in the vpc.
resource "aws_security_group" "ssh" {
  vpc_id              = module.vpc.vpc_id
  name                = "${var.environment}-ssh"
  description         = "Security group to allow bastion ssh to all instances in vpc."

  tags = {
    Name              = "${var.environment}-ssh"
  }

  egress {
    cidr_blocks       = [lookup(var.vpc_cidr, var.environment)]
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    description       = "Allow ssh to all subnets within the vpc."
  }

  ingress {
    cidr_blocks       = [lookup(var.vpc_cidr, var.environment)] // [0.0.0.0/0]
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    description       = "Allow ssh from all subnets within"
  }
}

