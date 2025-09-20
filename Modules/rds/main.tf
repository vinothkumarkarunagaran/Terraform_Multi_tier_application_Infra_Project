variable "db_name" {
  default = "mydatabase"  # must start with a letter & alphanumeric only
}

variable "db_username" {
  default = "adminuser"
}

variable "db_password" {
  default = "StrongPass123!"  # follow AWS password rules
}

variable "db_subnet_group" {}

resource "aws_db_instance" "this" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = var.db_subnet_group
  skip_final_snapshot  = true
}

