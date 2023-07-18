resource "aws_launch_configuration" "main" {
  associate_public_ip_address = true
  name                        = "${var.ecs_cluster_name}-lauch-config"
  image_id                    = data.aws_ami.ecs.id
  iam_instance_profile        = var.iam_instance_profile
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = var.security_groups
  user_data                   = data.template_file.user_data.rendered
  #  user_data = "#!/bin/bash\necho ECS_CLUSTER='${var.ecs_cluster_name}-cluster' > /etc/ecs/ecs.config" #data.template_file.user_data.rendered 

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main" {
  desired_capacity     = var.desired_capacity
  health_check_type    = "ELB"
  launch_configuration = aws_launch_configuration.main.name
  max_size             = var.max_size
  min_size             = 1
  name                 = "${var.ecs_cluster_name}-asg"

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = var.ecs_cluster_name #"blog"
  }

  lifecycle {
    create_before_destroy = true
  }

  target_group_arns    = [aws_alb_target_group.main.arn]
  termination_policies = ["OldestInstance"]

  vpc_zone_identifier = var.subnets
}