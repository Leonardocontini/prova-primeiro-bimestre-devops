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