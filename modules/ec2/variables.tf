variable "ami_id" {
  description = "AMI ID para la instancia EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "ID de la subnet donde lanzar la instancia"
  type        = string
}

variable "security_group_ids" {
  description = "Lista de IDs de Security Groups"
  type        = list(string)
}

variable "associate_public_ip_address" {
  description = "Asociar IP pública a la instancia"
  type        = bool
  default     = true
}

variable "key_name" {
  description = "Nombre del key pair para acceso SSH"
  type        = string
  default     = null
}

variable "user_data" {
  description = "Script de user data para la instancia"
  type        = string
  default     = null
}

variable "instance_name" {
  description = "Nombre para la instancia EC2"
  type        = string
  default     = "main-instance"
}

variable "root_volume_type" {
  description = "Tipo de volumen root"
  type        = string
  default     = "gp3"
}

variable "root_volume_size" {
  description = "Tamaño del volumen root en GB"
  type        = number
  default     = 8
}

variable "root_volume_encrypted" {
  description = "Encriptar el volumen root"
  type        = bool
  default     = true
}
