# Create ssh key pairs
resource "tls_private_key" "aws_ec2_access_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Public Key to be attached to ec2 instances.
resource "aws_key_pair" "aws_ec2_access_key" {
  key_name = var.aws_ssh_key_name
  public_key = tls_private_key.aws_ec2_access_key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.aws_ec2_access_key.private_key_pem}' > ./private_key.pem"
  }
}

