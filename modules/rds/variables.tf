variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "db_subnet_group_name" {
  description = "Nome do DB Subnet Group das subnets privadas"
  type        = string
}

variable "security_group_id" {
  description = "Security Group que poderá acessar o RDS"
  type        = string
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "db_username" {
  description = "Usuário administrador do banco"
  type        = string
}

variable "db_password" {
  description = "Senha do banco"
  type        = string
  sensitive   = true
}