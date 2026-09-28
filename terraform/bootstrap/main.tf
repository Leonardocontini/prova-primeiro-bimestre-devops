module "ec2" {
  source = "./modules/ec2"

  project_name      = var.project_name
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security_group.ec2_sg_id
  instance_profile  = "LabInstanceProfile"
  key_name          = "technova-key"

  db_host     = module.rds.rds_endpoint
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}