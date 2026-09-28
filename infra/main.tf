module "vpc" {
  source = "./modules/vpc"

  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
}

module "security_group" {
  source = "./modules/security-group"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "rds" {
  source = "./modules/rds"

  project_name         = var.project_name
  db_subnet_group_name = module.vpc.db_subnet_group_name
  security_group_id    = module.security_group.rds_sg_id

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}

module "ec2" {
  source = "./modules/ec2"

  project_name      = var.project_name
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security_group.ec2_sg_id

  instance_profile = "LabInstanceProfile"
  key_name         = var.key_name

  # Endpoint do RDS injetado no .env dentro da EC2 via user_data.sh (templatefile)
  db_host     = module.rds.rds_endpoint
  db_name     = var.db_name
  db_user     = var.db_username
  db_password = var.db_password

  depends_on = [module.rds]
}
