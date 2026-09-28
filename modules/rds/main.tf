resource "aws_db_instance" "this" {
  identifier = "${var.project_name}-postgres"

  engine         = "postgres"
  engine_version = "16"

  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  port = 5432

  db_subnet_group_name = var.db_subnet_group_name

  vpc_security_group_ids = [
    var.security_group_id
  ]

  publicly_accessible = false

  backup_retention_period = 0

  multi_az = false

  skip_final_snapshot = true

  deletion_protection = false

  tags = {
    Name        = "${var.project_name}-postgres"
    Project     = var.project_name
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}