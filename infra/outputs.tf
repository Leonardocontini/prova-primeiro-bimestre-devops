output "ec2_public_ip" {
  description = "IP público da EC2"
  value       = module.ec2.public_ip
}

output "ec2_public_dns" {
  description = "DNS público da EC2"
  value       = module.ec2.public_dns
}

output "rds_endpoint" {
  description = "Endpoint do PostgreSQL"
  value       = module.rds.rds_endpoint
}

output "rds_port" {
  description = "Porta do PostgreSQL"
  value       = module.rds.rds_port
}

output "api_url" {
  description = "URL da API de reservas"
  value       = "http://${module.ec2.public_ip}:3000"
}