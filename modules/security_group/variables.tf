variable "security_group_name" {
  description = "Nombre del Security Group"
  type        = string
}

variable "description" {
  description = "Descripción del Security Group"
  type        = string
  default     = "Security Group creado por Terraform"
}

variable "vpc_id" {
  description = "ID de la VPC donde crear el Security Group"
  type        = string
}

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

variable "http_cidr_blocks" {
  description = "CIDR blocks permitidos para HTTP"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_https_access" {
  description = "Habilitar acceso HTTPS"
  type        = bool
  default     = false
}

variable "https_cidr_blocks" {
  description = "CIDR blocks permitidos para HTTPS"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
