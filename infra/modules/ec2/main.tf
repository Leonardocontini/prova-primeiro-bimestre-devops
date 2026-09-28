data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  key_name = var.key_name

  iam_instance_profile = var.instance_profile

  associate_public_ip_address = true

  user_data = templatefile("${path.root}/../scripts/user_data.sh", {
    db_host     = var.db_host
    db_name     = var.db_name
    db_user     = var.db_user
    db_password = var.db_password
  })

  tags = {
    Name        = "${var.project_name}-api"
    Project     = var.project_name
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}
