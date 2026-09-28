output "rds_endpoint" {
  description = "Endpoint do PostgreSQL"
  value       = aws_db_instance.this.address
}

output "rds_port" {
  description = "Porta do PostgreSQL"
  value       = aws_db_instance.this.port
}

output "rds_database_name" {
  description = "Nome do banco de dados"
  value       = aws_db_instance.this.db_name
}