resource "aws_ecs_cluster" "main" {
  name = "${var.ecs_cluster_name}-cluster"
  lifecycle {
    create_before_destroy = true
  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.ecs_cluster_name}-app-task"
  network_mode             = var.network_mode  #"bridge"
  requires_compatibilities = [var.launch_type] #["EC2"]
  container_definitions    = var.container_definitions #data.template_file.ec2_cb_app.rendered
  task_role_arn            = var.execution_role_arn 
}

resource "aws_ecs_service" "main" {
  name                    = "ec2_cb_app-service"
  cluster                 = aws_ecs_cluster.main.id
  task_definition         = "${aws_ecs_task_definition.app.family}:${max("${aws_ecs_task_definition.app.revision}")}"
  desired_count           = var.app_count
  scheduling_strategy     = "REPLICA"
  enable_ecs_managed_tags = true
  force_new_deployment    = true
  launch_type             = var.launch_type #"EC2"

  load_balancer {
    target_group_arn = aws_alb_target_group.main.arn
    container_name   = var.container_name
    container_port   = var.app_port #3000
  }
  deployment_controller {
    type = "ECS"
  }
}