output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block de la VPC"
  value       = aws_vpc.main.cidr_block
}

output "subnet_id" {
  description = "ID de la subnet pública"
  value       = aws_subnet.public.id
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}
