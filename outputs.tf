# Outputs de VPC
output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.vpc.vpc_id
}

output "subnet_id" {
  description = "ID de la subnet pública"
  value       = module.vpc.subnet_id
}

# Outputs de Security Group
output "security_group_id" {
  description = "ID del Security Group"
  value       = module.security_group.security_group_id
}

# Outputs de EC2
output "instance_id" {
  description = "ID de la instancia EC2"
  value       = module.ec2.instance_id
}

output "instance_public_ip" {
  description = "IP pública de la instancia EC2"
  value       = module.ec2.instance_public_ip
}

output "instance_private_ip" {
  description = "IP privada de la instancia EC2"
  value       = module.ec2.instance_private_ip
}

output "instance_public_dns" {
  description = "DNS público de la instancia EC2"
  value       = module.ec2.instance_public_dns
}

# Output útil para conectarse
output "ssh_connection_command" {
  description = "Comando para conectarse por SSH (requiere key pair configurado)"
  value       = var.key_name != null ? "ssh -i ~/.ssh/${var.key_name}.pem ec2-user@${module.ec2.instance_public_ip}" : "Key pair no configurado - no se puede generar comando SSH"
}

output "web_url" {
  description = "URL para acceder al servidor web"
  value       = var.install_apache ? "http://${module.ec2.instance_public_ip}" : "Apache no instalado"
}
