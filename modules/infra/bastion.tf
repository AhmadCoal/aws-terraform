resource "aws_instance" "bastion" {
  count                       = 1
  associate_public_ip_address = true
  instance_type               = "t3a.medium"
  key_name                    = var.aws_ssh_key_name
  subnet_id                   = module.vpc.public_subnets[count.index]
  vpc_security_group_ids      = [aws_security_group.ssh.id,
                                aws_security_group.ping_internal.id
                                ]
  ami                         = "ami-0b807a42361daad08"

  ebs_block_device {
      device_name             = "/dev/xvdf"
      delete_on_termination   = true
      volume_size             = 50
      volume_type             = "gp2"
    }

  tags = {
    Name = "${var.environment}-bastion"
  }

  lifecycle {
    ignore_changes = [ami]
  }

}

resource "aws_eip" "bastioneip" {
  instance = "${aws_instance.bastion[0].id}"
  vpc      = true
}
