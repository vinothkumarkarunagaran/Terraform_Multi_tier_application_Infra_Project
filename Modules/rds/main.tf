resource "aws_db_subnet_group" "db_subnet" {
  name       = "${var.project}-db-subnet"
  subnet_ids = var.db_subnets
}

resource "aws_db_instance" "this" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "${var.project}_db"
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  publicly_accessible  = false
}

output "db_endpoint" {
  value = aws_db_instance.this.endpoint
}

