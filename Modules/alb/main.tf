variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}

# Create Internet Gateway (if not already created)
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
}

# Create a route table for public subnets
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate public subnets with route table
resource "aws_route_table_association" "public_assoc" {
  for_each       = toset(var.public_subnet_ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

# Create Application Load Balancer
resource "aws_lb" "this" {
  name               = "multitier-app-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [] # Add your ALB SG IDs here
  enable_deletion_protection = false
}

