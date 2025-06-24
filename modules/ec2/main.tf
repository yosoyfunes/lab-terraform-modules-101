# EC2 Instance
resource "aws_instance" "main" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name

  user_data = var.user_data

  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
    encrypted   = var.root_volume_encrypted
  }

  tags = {
    Name = var.instance_name
  }
}
