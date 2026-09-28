output "vpc_id" {
  description = "ID da VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "ID da subnet pública utilizada pela EC2"
  value       = values(aws_subnet.public)[0].id
}

output "public_subnet_ids" {
  description = "IDs de todas as subnets públicas"
  value       = {
    for az, subnet in aws_subnet.public : az => subnet.id
  }
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas"
  value       = {
    for az, subnet in aws_subnet.private : az => subnet.id
  }
}

output "db_subnet_group_name" {
  description = "Nome do DB Subnet Group utilizado pelo RDS"
  value       = aws_db_subnet_group.this.name
}