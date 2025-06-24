output "instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "IP pública de la instancia EC2"
  value       = aws_instance.main.public_ip
}

output "instance_private_ip" {
  description = "IP privada de la instancia EC2"
  value       = aws_instance.main.private_ip
}

output "instance_public_dns" {
  description = "DNS público de la instancia EC2"
  value       = aws_instance.main.public_dns
}
