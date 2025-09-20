# =====================================
# INTERNET GATEWAY
# =====================================
resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.project}-igw"
  }
}

# =====================================
# PUBLIC ROUTE TABLE
# =====================================
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "${var.project}-public-rt"
  }
}

# Associate public subnets with route table
resource "aws_route_table_association" "public_assoc" {
  for_each       = toset(var.public_subnets)
  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

# =====================================
# SECURITY GROUP FOR ALB
# =====================================
resource "aws_security_group" "alb_sg" {
  name        = "${var.project}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

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

  tags = {
    Name = "${var.project}-alb-sg"
  }
}

# =====================================
# APPLICATION LOAD BALANCER
# =====================================
resource "aws_lb" "this" {
  name               = "${var.project}-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [aws_security_group.alb_sg.id]
  enable_deletion_protection = false
  tags = {
    Name = "${var.project}-alb"
  }
}

# =====================================
# TARGET GROUP
# =====================================
resource "aws_lb_target_group" "this" {
  name     = "${var.project}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name = "${var.project}-tg"
  }
}

# =====================================
# REGISTER TARGETS
# =====================================
resource "aws_lb_target_group_attachment" "targets" {
  for_each = toset(var.target_ids)
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = each.value
  port             = 80
}

# =====================================
# LISTENER
# =====================================
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

