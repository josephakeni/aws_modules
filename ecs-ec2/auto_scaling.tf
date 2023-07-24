resource "aws_launch_template" "main" {
  name                        = "${var.ecs_cluster_name}-lauch-config"
  image_id                    = data.aws_ami.ecs.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids              = var.security_groups
  user_data = base64encode(data.template_file.user_data.rendered)
  iam_instance_profile        { 
    name = var.iam_instance_profile 
    }
  instance_initiated_shutdown_behavior = "terminate"
}

resource "aws_autoscaling_group" "main" {
  desired_capacity     = var.desired_capacity
  health_check_type    = "ELB"
  max_size             = var.max_size
  min_size             = 1
  name                 = "${var.ecs_cluster_name}-asg"
  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = var.ecs_cluster_name 
  }

  lifecycle {
    create_before_destroy = true
  }

  target_group_arns    = [aws_alb_target_group.main.arn]
  termination_policies = ["OldestInstance"]

  vpc_zone_identifier = var.subnets
}