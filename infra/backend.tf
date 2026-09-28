terraform {
  backend "s3" {
    bucket         = "prova-devops6325054"
    key            = "reservas/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "reservas-terraform-lock"
  }
}