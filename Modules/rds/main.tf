# =====================================
# SECURITY GROUP FOR RDS
# =====================================
resource "aws_security_group" "rds_sg" {
  name        = "${var.project}-rds-sg"
  description = "Security group for RDS"
  vpc_id      = var.vpc_id

  # Allow MySQL access from anywhere (adjust for production!)
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-rds-sg"
  }
}

# =====================================
# DB SUBNET GROUP
# =====================================
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.project}-db-subnet-group"
  subnet_ids = var.db_subnets
  tags = {
    Name = "${var.project}-db-subnet-group"
  }
}

# =====================================
# RDS MYSQL INSTANCE
# =====================================
resource "aws_db_instance" "this" {
  identifier          = "${var.project}-db"
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  
  name     = "${var.project}db"  # Must start with a letter & alphanumeric only
  username = var.db_username
  password = var.db_password
  
  skip_final_snapshot  = true
  publicly_accessible  = false
  
  tags = {
    Name = "${var.project}-db"
  }
}

