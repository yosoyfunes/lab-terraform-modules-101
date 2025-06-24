# Data source para obtener la AMI más reciente de Amazon Linux 2
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Módulo VPC
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = "${var.region}a"
  
  vpc_name          = "${var.project_name}-vpc"
  subnet_name       = "${var.project_name}-public-subnet"
  igw_name          = "${var.project_name}-igw"
  route_table_name  = "${var.project_name}-public-rt"
}

# Módulo Security Group
module "security_group" {
  source = "./modules/security_group"

  security_group_name = "${var.project_name}-sg"
  description         = "Security Group para ${var.project_name}"
  vpc_id              = module.vpc.vpc_id
  
  enable_ssh_access   = var.enable_ssh_access
  ssh_cidr_blocks     = var.ssh_cidr_blocks
  enable_http_access  = var.enable_http_access
  enable_https_access = var.enable_https_access
}

# Módulo EC2
module "ec2" {
  source = "./modules/ec2"

  ami_id                      = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.subnet_id
  security_group_ids          = [module.security_group.security_group_id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  instance_name               = "${var.project_name}-instance"
  
  user_data = var.install_apache ? templatefile("${path.module}/user_data.sh", {
    project_name = var.project_name
  }) : null
  
  root_volume_encrypted = var.encrypt_ebs_volumes
}
