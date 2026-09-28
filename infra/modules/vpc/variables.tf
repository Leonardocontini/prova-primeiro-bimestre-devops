variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
}

variable "availability_zones" {
  description = "Zonas de disponibilidade utilizadas"
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDRs das subnets públicas"
  type        = map(string)
}

variable "private_subnets" {
  description = "CIDRs das subnets privadas"
  type        = map(string)
}