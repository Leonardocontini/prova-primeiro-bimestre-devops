variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "reservas"
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability Zones utilizadas"
  type        = list(string)

  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "public_subnets" {
  description = "Subnets públicas por Availability Zone"
  type        = map(string)

  default = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.3.0/24"
  }
}

variable "private_subnets" {
  description = "Subnets privadas por Availability Zone"
  type        = map(string)

  default = {
    "us-east-1a" = "10.0.2.0/24"
    "us-east-1b" = "10.0.4.0/24"
  }
}

variable "db_name" {
  description = "Nome do banco PostgreSQL"
  type        = string
  default     = "reservas"
}

variable "db_username" {
  description = "Usuário do PostgreSQL"
  type        = string
}

variable "db_password" {
  description = "Senha do PostgreSQL"
  type        = string
  sensitive   = true
}

variable "key_name" {
  description = "Nome do key pair SSH registrado na AWS"
  type        = string
}
