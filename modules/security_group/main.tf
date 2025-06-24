# Security Group
resource "aws_security_group" "main" {
  name        = var.security_group_name
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name = var.security_group_name
  }
}

# Security Group Rules - SSH
resource "aws_security_group_rule" "ssh_ingress" {
  count = var.enable_ssh_access ? 1 : 0
  
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.ssh_cidr_blocks
  security_group_id = aws_security_group.main.id
  description       = "SSH access"
}

# Security Group Rules - HTTP
resource "aws_security_group_rule" "http_ingress" {
  count = var.enable_http_access ? 1 : 0
  
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.http_cidr_blocks
  security_group_id = aws_security_group.main.id
  description       = "HTTP access"
}

# Security Group Rules - HTTPS
resource "aws_security_group_rule" "https_ingress" {
  count = var.enable_https_access ? 1 : 0
  
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.https_cidr_blocks
  security_group_id = aws_security_group.main.id
  description       = "HTTPS access"
}

# Security Group Rules - Egress (All traffic)
resource "aws_security_group_rule" "all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
  description       = "All outbound traffic"
}
