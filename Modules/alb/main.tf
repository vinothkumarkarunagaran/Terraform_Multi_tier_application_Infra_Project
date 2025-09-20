resource "aws_lb" "this" {
  name               = "${var.project}-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnets
}

resource "aws_lb_target_group" "tg" {
  name     = "${var.project}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "tg_attach" {
  count            = length(var.target_ids)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.target_ids[count.index]
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

output "alb_dns" {
  value = aws_lb.this.dns_name
}

