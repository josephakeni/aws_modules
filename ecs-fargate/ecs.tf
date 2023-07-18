resource "aws_ecs_cluster" "main" {
  name = "${var.ecs_cluster_name}-cluster"
}

data "template_file" "cb_app" {
  template = file("../templates/ecs/cb_app.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    cpu_size       = var.cpu_size
    memory_size    = var.memory_size
    aws_region     = var.aws_region
    network_mode   = var.network_mode
    container_name = var.container_name
    ecs_cluster_name = var.ecs_cluster_name
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.ecs_cluster_name}-app-task"
  execution_role_arn       = var.execution_role_arn #aws_iam_role.ecs_task_execution_role.arn
  network_mode             = var.network_mode       #"awsvpc"
  requires_compatibilities = [var.launch_type]
  cpu                      = var.cpu_size
  memory                   = var.memory_size
  container_definitions    = data.template_file.cb_app.rendered
}

resource "aws_ecs_service" "main" {
  name            = "${var.ecs_cluster_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = var.launch_type #"FARGATE"

  network_configuration {
    security_groups  = var.security_groups
    subnets          = var.subnets #[data.terraform_remote_state.network.outputs.private_subnets[0], data.terraform_remote_state.network.outputs.private_subnets[1]] #aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = var.container_name
    container_port   = var.app_port
  }

  # depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment]
}