# Variables generales
variable "region" {
  description = "Región de AWS donde desplegar la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre del proyecto (usado para nombrar recursos)"
  type        = string
  default     = "lab-terraform"
}

variable "common_tags" {
  description = "Tags comunes para todos los recursos"
  type        = map(string)
  default = {
    Environment = "lab"
    Project     = "terraform-modules"
    ManagedBy   = "terraform"
  }
}

# Variables de red
variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block para la subnet pública"
  type        = string
  default     = "10.0.1.0/24"
}

# Variables de seguridad
variable "enable_ssh_access" {
  description = "Habilitar acceso SSH"
  type        = bool
  default     = true
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks permitidos para SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_http_access" {
  description = "Habilitar acceso HTTP"
  type        = bool
  default     = true
}

variable "enable_https_access" {
  description = "Habilitar acceso HTTPS"
  type        = bool
  default     = false
}

# Variables de EC2
variable "ami_id" {
  description = "AMI ID para la instancia EC2 (deja vacío para usar la AMI más reciente de Amazon Linux 2)"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nombre del key pair para acceso SSH (opcional)"
  type        = string
  default     = null
}

variable "install_apache" {
  description = "Instalar Apache HTTP Server automáticamente"
  type        = bool
  default     = true
}

variable "encrypt_ebs_volumes" {
  description = "Encriptar volúmenes EBS"
  type        = bool
  default     = true
}
