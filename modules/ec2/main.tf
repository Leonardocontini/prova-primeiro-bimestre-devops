data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  key_name = var.key_name

  iam_instance_profile = var.instance_profile

  associate_public_ip_address = true

  user_data = file("${path.root}/../scripts/user_data.sh")

  tags = {
    Name        = "${var.project_name}-api"
    Project     = var.project_name
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}