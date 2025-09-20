resource "aws_security_group" "app_sg" {
  vpc_id = var.vpc_id
  name   = "${var.project}-app-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app" {
  count         = 2
  ami           = "ami-08c40ec9ead489470" # Amazon Linux 2 (update per region)
  instance_type = var.instance_type
  subnet_id     = var.private_subnets[count.index]
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "Hello from EC2 $(hostname)" > /var/www/html/index.html
              EOF
  tags = { Name = "${var.project}-app-${count.index}" }
}

output "instance_ids" {
  value = aws_instance.app[*].id
}

