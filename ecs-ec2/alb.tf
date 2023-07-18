resource "aws_alb" "main" {
  name            = "${var.ecs_cluster_name}-alb"
  security_groups = var.security_groups
  subnets         = var.subnets
}

resource "aws_alb_target_group" "main" {
  health_check {
    path = var.health_check_path
  }

  name     = "${var.ecs_cluster_name}-alb-tg"
  port     = var.app_port
  protocol = "HTTP"

  stickiness {
    type = "lb_cookie"
  }
  vpc_id = var.aws_vpc_main
}

resource "aws_alb_listener" "main" {
  load_balancer_arn = aws_alb.main.arn
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.main.arn
    type             = "forward"
  }
}
