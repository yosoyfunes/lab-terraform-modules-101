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

variable "availability_zone" {
  description = "Zona de disponibilidad para la subnet"
  type        = string
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Habilitar hostnames DNS en la VPC"
  type        = bool
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "Asignar IP pública automáticamente en la subnet"
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "Nombre para la VPC"
  type        = string
  default     = "main-vpc"
}

variable "subnet_name" {
  description = "Nombre para la subnet"
  type        = string
  default     = "public-subnet"
}

variable "igw_name" {
  description = "Nombre para el Internet Gateway"
  type        = string
  default     = "main-igw"
}

variable "route_table_name" {
  description = "Nombre para la tabla de rutas"
  type        = string
  default     = "public-rt"
}
