resource "aws_instance" "wpserver" {
  count                       = 2
  ami                         = "ami-026ebd4cfe2c043b2"
  instance_type               = var.wp_instance_type
  key_name                    = var.aws_ssh_key_name
  subnet_id                   = module.vpc.private_subnets[count.index]
  vpc_security_group_ids      = [aws_security_group.wp_internal.id, 
                                aws_security_group.ping_internal.id,
                                aws_security_group.ssh.id]
  associate_public_ip_address = false

  root_block_device {
    volume_size               = 20
  }

  ebs_block_device {
      device_name             = "/dev/xvdf"
      delete_on_termination   = true
      volume_size             = 20
      volume_type             = "gp2"
    }

  tags = {
    Name                      = "${var.environment}-wpserver-${count.index}"
    Environment               = var.environment
    type                      = "private"
  }

  volume_tags = {
    Name                      = "${var.environment}-wpserver-${count.index}"
  }

  lifecycle {
    ignore_changes            = [ami,instance_type,ebs_block_device,root_block_device]
  }

}
