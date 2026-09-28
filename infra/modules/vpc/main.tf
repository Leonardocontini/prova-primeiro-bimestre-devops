resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Project     = var.project_name
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}

# =========================
# SUBNETS PÚBLICAS
# =========================

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public-${each.key}"
    Project     = var.project_name
    Environment = "lab"
    Type        = "public"
    ManagedBy   = "Terraform"
  }
}

# =========================
# SUBNETS PRIVADAS
# =========================

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name        = "${var.project_name}-private-${each.key}"
    Project     = var.project_name
    Environment = "lab"
    Type        = "private"
    ManagedBy   = "Terraform"
  }
}

# =========================
# INTERNET GATEWAY
# =========================

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project_name}-igw"
    Project     = var.project_name
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}

# =========================
# ROUTE TABLE PÚBLICA
# =========================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name        = "${var.project_name}-public-rt"
    Project     = var.project_name
    Environment = "lab"
    Type        = "public"
    ManagedBy   = "Terraform"
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# =========================
# ROUTE TABLE PRIVADA
# =========================

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project_name}-private-rt"
    Project     = var.project_name
    Environment = "lab"
    Type        = "private"
    ManagedBy   = "Terraform"
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

# =========================
# DB SUBNET GROUP
# =========================

resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = [for subnet in aws_subnet.private : subnet.id]

  tags = {
    Name        = "${var.project_name}-db-subnet-group"
    Project     = var.project_name
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}