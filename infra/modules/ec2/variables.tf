variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet pública"
  type        = string
}

variable "security_group_id" {
  description = "ID do Security Group da EC2"
  type        = string
}

variable "instance_profile" {
  description = "Instance Profile utilizado pela EC2"
  type        = string
}

variable "key_name" {
  description = "Nome da chave SSH registrada na AWS"
  type        = string
}

variable "db_host" {
  description = "Endpoint do RDS"
  type        = string
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "db_user" {
  description = "Usuário do banco de dados"
  type        = string
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
}
