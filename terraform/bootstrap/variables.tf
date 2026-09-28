variable "bucket_name" {
  description = "Nome do bucket S3 utilizado pelo Terraform Remote State"
  type        = string
  default     = "prova-devops6325054"
}

variable "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB utilizada para locking"
  type        = string
  default     = "reservas-terraform-lock"
}