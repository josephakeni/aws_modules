resource "aws_alb" "main" {
  name            = "${var.ecs_cluster_name}-load-balancer"
  subnets         = var.subnets
  security_groups = var.security_groups
}

resource "aws_alb_target_group" "app" {
  name        = "${var.ecs_cluster_name}-target-group"
  port        = 3000 #80
  protocol    = "HTTP"
  vpc_id      = var.aws_vpc_main
  target_type = var.target_type #"ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}